//
//  FeedItem.swift
//  EssentialFeed
//
//  Created by Michael Kampouris on 4/19/22.
//

import Foundation

public struct FeedItem: Equatable {
    public let id: UUID
    public let description: String?
    public let location: String?
    public let imageURL: URL
    
    public init(id: UUID, descrition: String?, location: String?, imageURL: URL) {
        self.id = id
        self.description = descrition
        self.location = location
        self.imageURL = imageURL
    }
}

extension FeedItem: Decodable {
    private enum CodingKeys: String, CodingKey {
        case id
        case description
        case location
        case imageURL = "image"
    }
}
