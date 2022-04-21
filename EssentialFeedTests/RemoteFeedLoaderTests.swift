//
//  RemoteFeedLoaderTests.swift
//  EssentialFeedTests
//
//  Created by Michael Kampouris on 4/21/22.
//

import XCTest

class RemoteFeedLoader {
    
    let client: HTTPClient
    let url: URL
    
    init (url: URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }
    
    func load() {
        client.get(from: url)
    }
}

protocol HTTPClient {
    func get(from url: URL)
}

class HTTPClientSpy: HTTPClient {
    var requestedURL: URL?
    
    func get(from url: URL) {
        requestedURL = url
    }
    
}

class RemoteFeedLoaderTests: XCTestCase {

    func test_init_doesNotRequestDataFromURL() {
        
        //Given
        let client = HTTPClientSpy()
        let url = URL(string: "https://a-url.com")!

        //When
        _ = RemoteFeedLoader(url: url, client: client)
        
        //Then
        XCTAssertNil(client.requestedURL)
    }
    
    func test_load_requestDataFromURL() {
        
        //Given
        let url = URL(string: "https://a-given-url.com")!
        let client = HTTPClientSpy()
        let sut = RemoteFeedLoader(url: url, client: client)
        
        //When
        sut.load()
        
        //Then
        XCTAssertEqual(client.requestedURL, url)
    }

}
