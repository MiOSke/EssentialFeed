//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Michael Kampouris on 4/19/22.
//

import Foundation

public enum LoadFeedResult {
    case success([FeedItem])
    case failure(Error)
}

protocol FeedLoader {
    func load(completion: @escaping (LoadFeedResult) -> ())
}
