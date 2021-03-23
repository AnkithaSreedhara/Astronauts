//
//  APIService.swift
//  Astronaut
//
//  Created by Anki on 22/03/21.
//

import Foundation
import os.log

class APIService :  NSObject {
    var session: URLSession!
    let log = OSLog(subsystem: Bundle.main.bundleIdentifier!, category: "network")
    func apiToGetAstronauts(path: String, completion : @escaping (Astronaut?, _ error: Error?) -> ()){
        let appendedURL = URL(string: path )!
        os_log("url = %@", log: log, path)
        URLSession.shared.dataTask(with: appendedURL) { (data, urlResponse, error) in
            if let data = data {
                
                let jsonDecoder = JSONDecoder()
                if let parsedData = try? jsonDecoder.decode(Astronaut.self, from: data){
                    completion(parsedData, nil)
                }else{
                    completion(nil,error)
                }
                
            }
        }.resume()
    }
    func apiToGetAstronautDetail(path: String, completion : @escaping (Result?, _ error: Error?) -> ()){
        let appendedURL = URL(string: path )!
        os_log("url = %@", log: log, path)
        URLSession.shared.dataTask(with: appendedURL) { (data, urlResponse, error) in
            if let data = data {
                
                let jsonDecoder = JSONDecoder()
                if let parsedData = try? jsonDecoder.decode(Result.self, from: data){
                    completion(parsedData,nil)
                }else{
                    completion(nil,error)
                }
            }
        }.resume()
    }
}
