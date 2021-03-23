//
//  Astronaut.swift
//  Astronaut
//
//  Created by Anki on 22/03/21.
//

import Foundation

import Foundation

// MARK: - Astronaut
struct Astronaut : Codable{
    
    var count: Int?
    var next: String?
    var results: [Result]?
}

// MARK: - Result
struct Result : Codable , Comparable {
    static func < (lhs: Result, rhs: Result) -> Bool {
        return lhs.name! < rhs.name!
    }
    
    static func == (lhs: Result, rhs: Result) -> Bool {
        return lhs.name == rhs.name
    }
    var id: Int?
    var url: String?
    var name: String?
    var date_of_birth: String?
    var nationality, bio: String?
    var twitter, instagram: String?
    var wiki: String?
    var profile_image: String?
    var profile_image_thumbnail: String?
}

