//
//  Workout.swift
//  RockHard
//
//  Created by albert coelho oliveira on 2/11/20.
//  Copyright © 2020 Rockstars. All rights reserved.
//

import Foundation

struct WorkoutPlan{
    let workoutName: String
    let workoutCards: [WorkoutCard]
    
init?(from dict: [String: Any], id: String) {
        guard let workoutName = dict["workoutName"] as? String,
            let workoutCards = (dict["workoutCards"] as? [WorkoutCard]) else { return nil }
            
        self.workoutName = workoutName
        self.workoutCards = workoutCards
    }
var fieldsDict: [String: Any] {
          return [
              "workoutName": self.workoutName,
              "workoutCards": self.workoutCards ,
    ]
      }
}
