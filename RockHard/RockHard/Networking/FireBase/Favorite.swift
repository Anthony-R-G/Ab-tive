//
//  Post.swift
//  RockHard
//
//  Created by Rockstars on 2/3/20.
//  Copyright © 2020 Rockstars. All rights reserved.
//

import Foundation
import FirebaseFirestore

struct Favorite {
    let userID: String
    let id: String
    let name: String
    let dateCreated: Date?
    let imageUrl: String?
    let startTime: String?
    let objectOrEventIdentifier: String
    
    init(userID: String, name: String, dateCreated: Date? = nil , imageUrl: String? = nil, startTime: String? = nil, objectOrEventIdentifier: String){
        self.name = name
        self.dateCreated = dateCreated
        self.imageUrl = imageUrl
        self.id = UUID().description
        self.userID = userID
        self.startTime = startTime
        self.objectOrEventIdentifier = objectOrEventIdentifier
       
    }
    
    
    init? (from dict: [String: Any], id: String){
        guard let name = dict["name"] as? String,
            let userID = dict["userID"] as? String,
            let imageURL = dict["imageUrl"] as? String,
            let startTime = dict["startTime"] as? String?,
        let objectOrEventIdentifier = dict["objectOrEventIdentifier"] as? String,
            let dateCreated = (dict["dateCreated"] as? Timestamp)?.dateValue() else { return nil }
        self.userID = userID
        self.name = name
        self.id = id
        self.dateCreated = dateCreated
        self.imageUrl = imageURL
        self.startTime = startTime
        self.objectOrEventIdentifier = objectOrEventIdentifier
       
    }
    var fieldsDict: [String: Any] {
        return [
            "name": self.name,
            "imageUrl": self.imageUrl ?? "",
            "startTime": self.startTime ?? "",
            "userID": self.userID,
            "objectOrEventIdentifier": self.objectOrEventIdentifier
           
        ]
    }
}
