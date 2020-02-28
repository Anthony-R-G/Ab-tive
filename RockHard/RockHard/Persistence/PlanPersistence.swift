//
//  ImagePersistence.swift
//  Photo-Journal-Project
//
//  Created by albert coelho oliveira on 10/3/19.
//  Copyright © 2019 albert coelho oliveira. All rights reserved.
//

import Foundation

struct PlanPersistence{
    private init(){}
    static let manager = PlanPersistence()
    private let persistenceHelper = PersistenceHelper<WorkoutPlan>(fileName: "workoutPlan.plist")
    func getPlans() throws -> [WorkoutPlan]{
        return try persistenceHelper.getObjects()
       }
    func saveImage(info: WorkoutPlan) throws{
          try persistenceHelper.save(newElement: info)
    }
    func deleteImage(Int: Int) throws{
        try persistenceHelper.delete(num: Int)
    }
    func editImage(Int: Int, newElement: WorkoutPlan) throws{
        try persistenceHelper.edit(num: Int, newElement: newElement)
    }
}
