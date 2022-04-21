//
//  RemoteFeedLoader.swift
//  EssentialFeed
//
//  Created by Michael Kampouris on 4/21/22.
//

import Foundation

public enum HTTPClientResult {
    case success(Data, HTTPURLResponse)
    case failure(Error)
}


public protocol HTTPClient {
    func get(from url: URL, completion: @escaping (HTTPClientResult) -> ())
}

public final class RemoteFeedLoader {
    
    private let url: URL
    private let client: HTTPClient
    
    public enum Error: Swift.Error {
        case connectivity
        case invalidData
    }
    
    public enum Result: Equatable {
        case success([FeedItem])
        case failure(Error)
    }
    
    public init (url: URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }
    
    public func load(completion: @escaping (Result) -> ()) {
        client.get(from: url) { result in
            switch result {
            case let .success(data, response):
                do {
                    let items = try FeedItemMapper.map(data, response)
                    completion(.success(items))
                } catch {
                    completion(.failure(.invalidData))
                }
            case .failure:
                completion(.failure(.connectivity))
            }
        }
    }
}

private class FeedItemMapper {

    private struct Root: Decodable {
        let items: [Item]
    }

    private struct Item: Decodable {
        public let id: UUID
        public let description: String?
        public let location: String?
        public let image: URL
        
        var item: FeedItem {
            return FeedItem(id: id, descrition: description, location: location, imageURL: image)
        }
    }
    
    static func map(_ data: Data, _ response: HTTPURLResponse) throws -> [FeedItem] {
        guard response.statusCode == 200 else { throw RemoteFeedLoader.Error.invalidData }
        let root = try JSONDecoder().decode(Root.self, from: data)
        return root.items.map {$0.item}
    }
}
