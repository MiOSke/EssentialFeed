//
//  FeedItem.swift
//  EssentialFeed
//
//  Created by Michael Kampouris on 4/19/22.
//

import Foundation

public struct FeedItem: Equatable {
    let id: UUID
    let description: String?
    let location: String?
    let imageURL: String
}
