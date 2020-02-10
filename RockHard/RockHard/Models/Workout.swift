//
//  WorkoutModel.swift
//  RockHard
//
//  Created by albert coelho oliveira on 2/6/20.
//  Copyright © 2020 Rockstars. All rights reserved.
//

import Foundation

struct Workout{
    let workoutDay: String
    let workType: String
    let exercises: [Exercise]
    init?(from dict: [String: Any], id: String) {
            guard let workoutDay = dict["workoutDay"] as? String,
                let workType = dict["workType"] as? String,
                let exercises = (dict["exercises"] as? [Exercise]) else { return nil }
                
            self.workoutDay = workoutDay
            self.workType = workType
            self.exercises = exercises
        }
    var fieldsDict: [String: Any] {
              return [
                  "workoutDay": self.workoutDay,
                  "workType": self.workType ,
                  "exercises": self.exercises
              ]
          }
    }
