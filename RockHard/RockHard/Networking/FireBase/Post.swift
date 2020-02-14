//
//  Post.swift
//  RockHard
//
//  Created by Rockstars on 2/3/20.
//  Copyright © 2020 Rockstars. All rights reserved.
//

import Foundation
import FirebaseFirestore


struct Post {
    let userID: String
    let userName: String
   
    let postPicture: String
    let postText: String
    
    init(userID: String,userName: String, postPicture: String? = nil, postText: String? = nil){
        self.userName = userName
      
        self.userID = userID
        self.postPicture = postPicture!
        self.postText = postText!
    }
    
    
    init? (from dict: [String: Any], id: String){
        guard let userName = dict["userName"] as? String,
            let userID = dict["userID"] as? String,
            let postText = dict["postText"] as? String?,
            let postPicture = dict["postPicture"] as? String? else { return nil }
        self.userID = userID
        self.userName = userName
        
        self.postText = postText!
        self.postPicture = postPicture!
    }
    
    
    var fieldsDict: [String: Any] {
        return [
            "userName": self.userName,
            
            "postText": self.postText ,
            "postPicture": self.postPicture ,
            "userID": self.userID,

        ]
    }
}
