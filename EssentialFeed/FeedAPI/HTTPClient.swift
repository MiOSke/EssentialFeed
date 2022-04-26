//
//  HTTPClient.swift
//  EssentialFeed
//
//  Created by Michael Kampouris on 4/26/22.
//

import Foundation

public enum HTTPClientResult {
    case success(Data, HTTPURLResponse)
    case failure(Error)
}

public protocol HTTPClient {
    func get(from url: URL, completion: @escaping (HTTPClientResult) -> ())
}
