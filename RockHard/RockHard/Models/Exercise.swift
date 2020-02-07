//
//  Exercise.swift
//  RockHard
//
//  Created by albert coelho oliveira on 2/3/20.
//  Copyright © 2020 Rockstars. All rights reserved.
//

import Foundation


struct Exercise {
    let cellImage: String?
    let comments: [String]
    let detailImage: String?
    let exerciseInfo: String?
    let name: String
    let type: String
        init?(from dict: [String: Any]) {
            guard let cellImage = dict["cellImage"] as? String,
                let detailImage = dict["detailImage"] as? String,
                let exerciseInfo = dict["exerciseInfo"] as? String,
                let comments = dict["comments"] as? [String],
                let name = dict["name"] as? String,
                let type = dict["type"] as? String else { return nil }
            self.cellImage = cellImage
            self.detailImage = detailImage
            self.exerciseInfo = exerciseInfo
            self.name = name
            self.type = type
            self.comments = comments
        }
    
    
    
    

    }
