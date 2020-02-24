//
//  BuddyRequestModel.swift
//  RockHard
//
//  Created by albert coelho oliveira on 2/24/20.
//  Copyright © 2020 Rockstars. All rights reserved.
//

import Foundation
import FirebaseFirestore

struct BuddyRequest{
    let creatorId: String
    let creatorGym: String
    let buddyId: String
    let dateCreated: Date?
    var isAvailable: Bool
    let requestDate: Date?
    let requestInfo: String
    
    init?(from dict: [String: Any], id: String) {
            guard let creatorId = dict["creatorId"] as? String,
                let creatorGym = dict["creatorGym"] as? String,
                let buddyId = dict["buddyId"] as? String,
                let isAvailable = dict["isAvailable"] as? Bool,
                 let requestDate = (dict["requestDate"] as? Timestamp)?.dateValue(),
                let requestInfo = dict["requestInfo"] as? String,
                let dateCreated = (dict["dateCreated"] as? Timestamp)?.dateValue()
        else { return nil }
        self.creatorId = creatorId
        self.creatorGym = creatorGym
        self.buddyId = buddyId
        self.dateCreated = dateCreated
        self.isAvailable = isAvailable
        self.requestDate = requestDate
        self.requestInfo = requestInfo
    }}
       
