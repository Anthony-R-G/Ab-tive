//
//  Workout.swift
//  RockHard
//
//  Created by albert coelho oliveira on 2/11/20.
//  Copyright © 2020 Rockstars. All rights reserved.
//

import Foundation

struct WorkoutPlan: Codable{
    var planName: String
    var workoutCards: [WorkoutCard]
    let creatorID: String
    let workoutID: String
init?(from dict: [String: Any], id: String) {
        guard let planName = dict["planName"] as? String,
            let creatorID = dict["creatorID"] as? String,
            let workoutCards = (dict["workoutCards"] as? [[String:Any]]) else { return nil }
    
        self.creatorID = creatorID
        self.workoutID = id
        self.planName = planName
    self.workoutCards = workoutCards.compactMap({WorkoutCard(from: $0) })
    }
var fieldsDict: [String: Any] {
          return [
              "planName": self.planName,
              "creatorID": self.creatorID,
              "workoutCards": self.workoutCards.map({ $0.fieldsDict }) ,
    ]
      }
    init( planName: String,creatorID: String,workoutCards: [WorkoutCard]  ){
           self.creatorID = creatorID
           self.planName = planName
           self.workoutCards = workoutCards
           self.workoutID = "workoutID"
    }
}
