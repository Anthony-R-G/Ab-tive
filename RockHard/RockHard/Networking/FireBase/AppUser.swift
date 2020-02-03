//
//  AppUser.swift
//  RockHard
//
//  Created by Rockstars on 2/3/20.
//  Copyright © 2020 Rockstars. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

struct AppUser {
    let email: String?
    let uid: String
    let dateCreated: Date?
    let accountType: String?
    
    init(from user: User, accountType: String) {
        self.email = user.email
        self.uid = user.uid
        self.dateCreated = user.metadata.creationDate
        self.accountType = accountType
       
    }
    
    init?(from dict: [String: Any], id: String) {
        guard let email = dict["email"] as? String,
            let accountType = dict["accountType"] as? String,
                   
            let dateCreated = (dict["dateCreated"] as? Timestamp)?.dateValue() else { return nil }
       
        
        self.email = email
        self.uid = id
        self.dateCreated = dateCreated
        self.accountType = accountType
    }
    
    var fieldsDict: [String: Any] {
        return [
            "email": self.email ?? "",
            "accountType": self.accountType ?? ""
        ]
    }
}
