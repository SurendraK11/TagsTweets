//
//  HttpClient.swift
//  Tags
//
//  Created by Surendra on 13/11/2019.
//  Copyright © 2019 Surendra. All rights reserved.
//

import Foundation
protocol HttpClientProtocol {
    func fetchData(usingUrl url:URL, completion: @escaping (Result<Data, Error>) -> ())
}

class HttpClient {
    private let session: URLSession
    init(session: URLSession) {
        self.session = session
    }
}

extension HttpClient: HttpClientProtocol {
    func fetchData(usingUrl url:URL, completion: @escaping (Result<Data, Error>) -> ()) {
        let task = session.dataTask(with: URLRequest(url: url)){ (data, response, error) in
            guard error == nil else {
                completion(.failure(error!))
                return
            }
            if let _ = data {
                completion(.success(data!))
            } else {
                completion(.failure(CustomError.dataNotFoundError))
            }
        }
        task.resume()
    }
}
