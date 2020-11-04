//
//  APIClient.swift
//  TeliaWeather
//
//  Created by Yuliia Stelmakhovska on 2020-11-01.
//  Copyright © 2020 Yuliia Stelmakhovska. All rights reserved.
//

import Foundation
typealias JSONTask = URLSessionDataTask
typealias JSONCompletionHandler = (Data?, HTTPURLResponse?, Error?) -> Void

protocol JSONDecodable {
    init?(JSON: [String: AnyObject])
}

protocol FinalURLPoint {
    var baseURL: URL { get }
    var path: String { get }
    var request: URLRequest { get }
}

protocol APIClient {
    var sessionConfiguration: URLSessionConfiguration { get }
    var session: URLSession { get set }
    func JSONTaskWith(request: URLRequest, completionHandler: JSONCompletionHandler?) -> JSONTask
    func fetch<T: JSONDecodable>(request: URLRequest, parse: @escaping (Data) -> T?, completionHandler: @escaping (Result<T, Error>) -> Void)
    
}

/**
Base implementation of HTTP client
*/
extension APIClient {
   
     func JSONTaskWith(request: URLRequest, completionHandler: JSONCompletionHandler?) -> JSONTask {
           
           let dataTask = session.dataTask(with: request) { (data, response, error) in
               
               guard let HTTPResponse = response as? HTTPURLResponse else {
                   
                   let userInfo = [
                       NSLocalizedDescriptionKey: NSLocalizedString("Missing HTTP Response", comment: "")
                   ]
                   let error = NSError(domain: TWNetworkingErrorDomain, code: 100, userInfo: userInfo)
               
                completionHandler!(nil, nil, error)
                   return
               }
               
               if data == nil {
                   if let error = error {
                       completionHandler?(nil, HTTPResponse, error)
                   }
               } else {
                   switch HTTPResponse.statusCode {
                   case 200:
                     completionHandler?(data, HTTPResponse, nil)
                   default:
                       print("We have got response status \(HTTPResponse.statusCode)")
                   }
               }
           }
           return dataTask
       }
       
    func fetch<T>(request: URLRequest, parse: @escaping (Data) -> T?, completionHandler: @escaping (Result<T, Error>) -> Void) {
           
           let dataTask = JSONTaskWith(request: request) { (json, response, error) in
               DispatchQueue.main.async(execute: {
                   guard let json = json else {
                       if let error = error {
                        completionHandler(.failure(error))
                       }
                       return
                   }
                   
                   if let value = parse(json) {
                        completionHandler(.success(value))
                   } else {
                       let error = NSError(domain: TWNetworkingErrorDomain, code: 200, userInfo: nil)
                        completionHandler(.failure(error))
                   }
                   
               })
           }
           dataTask.resume()
       }
}
