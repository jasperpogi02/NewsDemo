//
//  NewsListAPIStore.swift
//  NewsDemo
//
//  Created by Jasper Alain Goce on 26/09/2019.
//  Copyright © 2019 blessed. All rights reserved.
//

import Foundation

class NewsListAPIStore: NewsListStoreProtocol {
    
    func getNews(parameter: NewsList.Request.NewsRequest, completion: @escaping(NewsList.Response.NewsResponse?) -> Void) {
        if let encodedURL = Config.newsURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
            let url = URL(string: encodedURL) {
            var request = URLRequest(url: url)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST"
            do {
                let encoder = JSONEncoder()
                let newsReq = try encoder.encode(parameter)
                request.httpBody = newsReq
            } catch {
                print("Cannot encode parameters")
            }
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    print(error)
                    return
                }
                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                    print(httpStatus)
                }
                do {
                    let decoder = JSONDecoder()
                    let news = try decoder.decode(NewsList.Response.NewsResponse.self, from: data)
                    completion(news)
                } catch {
                    completion(nil)
                }
            }
            task.resume()
        }
    }
    
}
