//
//  NetworkOperation.swift
//  StormyWeather
//
//  Created by Laryssa Husiak on 2/6/16.
//  Copyright © 2016 Laryssa Husiak. All rights reserved.
//

import Foundation

class NetworkOperation{
    lazy var config: NSURLSessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
    lazy var session: NSURLSession = NSURLSession(configuration: self.config)
    
    let queryURL: NSURL
    
    //To be passed into completion callback
    typealias JSONDictionaryCompletion = ([String: AnyObject]?) -> Void
    
        init(url: NSURL){
        self.queryURL = url
        }
    //completion is callback.
    //Apple has 3 types of callback: completion, handler or completion/handler
    func downloadJSONFromURL(completion: JSONDictionaryCompletion){
    
    let request: NSURLRequest = NSURLRequest(URL: queryURL)
    let dataTask = session.dataTaskWithRequest(request){
    (let data, let response, let error) in
        
        //1. Check HTTP response for successful GET request
        
        if let httpResponse = response as? NSHTTPURLResponse {
        
            switch(httpResponse.statusCode) {
            case 200:
                //2. Create JSON Object with data
                let jsonDictionary = try? NSJSONSerialization.JSONObjectWithData(data!, options: []) as? [String: AnyObject]
                
                completion(jsonDictionary!)
            default:
                print("GET request not successful, HTTP status code: \(httpResponse.statusCode)")
            }
        
        } else {
            print("Error: Not a valid HTTP response")
        
            }
        }
        dataTask.resume()
    }
}
