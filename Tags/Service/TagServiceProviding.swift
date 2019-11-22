//
//  TagServiceProviding.swift
//  Tags
//
//  Created by Surendra on 13/11/2019.
//  Copyright © 2019 Surendra. All rights reserved.
//

import Foundation
protocol TagServiceProviding {
    func fetchTags(withComplitionHandler completion: @escaping(Result<[String], Error>) -> ())
    func fetchTweets(forTag tag: String, complitionHandler completion: @escaping(Result<[TweetInformation], Error>) -> ())
}

class TronaldDumpTagServiceProvider {
    let httpClient: HttpClientProtocol
    let tagsEndPoint: String
    let tweetsEndPoint: String
    
    init(withHttpClient httpClient: HttpClientProtocol, tagsEndPoint: String, tweetsEndPoint: String) {
        self.httpClient = httpClient
        self.tagsEndPoint = tagsEndPoint
        self.tweetsEndPoint = tweetsEndPoint
    }
}

extension TronaldDumpTagServiceProvider: TagServiceProviding {
    func fetchTags(withComplitionHandler completion: @escaping (Result<[String], Error>) -> ()) {
        guard let url = URL(string: tagsEndPoint) else {
            completion(.failure(CustomError.urlError))
            return
        }
        httpClient.fetchData(usingUrl: url) { result in
            switch result {
            case .success(let data):
                do {
                    let serverResponse = try JSONDecoder().decode(TronaldDumpTagsServerResponse.self, from: data)
                    completion(.success(serverResponse.tags))
                } catch {
                    completion(.failure(CustomError.dataParsingError))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchTweets(forTag tag: String, complitionHandler completion: @escaping (Result<[TweetInformation], Error>) -> ()) {
        guard var url = URL(string: tweetsEndPoint) else {
            completion(.failure(CustomError.urlError))
            return
        }
        url.appendPathComponent(tag)
        httpClient.fetchData(usingUrl: url) { result in
            switch result {
            case .success(let data):
                do {
                    let serverResponse = try JSONDecoder().decode(TronaldDumpTagInfoServerResponse.self, from: data)
                    completion(.success(serverResponse.tweetInfoList))
                } catch {
                    completion(.failure(CustomError.dataParsingError))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
