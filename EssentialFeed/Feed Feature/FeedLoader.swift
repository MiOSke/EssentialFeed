//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Michael Kampouris on 4/19/22.
//

import Foundation

enum LoadFeedResult {
    case success([FeedItem])
    case error(Error)
}

protocol FeedLoader {
    func load(completion: @escaping (LoadFeedResult) -> ())
}
