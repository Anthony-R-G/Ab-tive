//
//  FirestoreService.swift
//  RockHard
//
//  Created by Rockstars on 2/3/20.
//  Copyright © 2020 Rockstars. All rights reserved.
//

import Foundation
import FirebaseFirestore
import Firebase

class FirestoreService {
    static let manager = FirestoreService()
    private let db = Firestore.firestore()
    
    func createAppUser(user: AppUser, completion: @escaping (Result<(), Error>) -> ()) {
        var fields = user.fieldsDict
        fields["dateCreated"] = Date()
        db.collection("users").document(user.uid).setData(fields) { (error) in
            if let error = error {
                completion(.failure(error))
                print(error)
            }
            completion(.success(()))
        }
    }
    
    

    func createFavorite(post: Favorite, id: String, completion: @escaping (Result<(), Error>) -> ()) {

        var fields = post.fieldsDict
        fields["dateCreated"] = Date()
        let userID = FirebaseAuthService.manager.currentUser?.uid
        let uniqueID = userID! + id

        db.collection("Favorites").document(uniqueID).setData(fields) { (error) in

            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    

    func getUserFavorites(UserID: String, completion: @escaping (Result<[Favorite],Error>) ->()) {
        db.collection("Favorites").whereField("userID", isEqualTo: UserID).getDocuments { (snapshot, error) in

            if let error = error{
                completion(.failure(error))
            }else {
                let posts = snapshot?.documents.compactMap({ (snapshot) -> Favorite? in
                    let postID = snapshot.documentID
                    let post = Favorite(from: snapshot.data(), id: postID)
                    return post
                })
                completion(.success(posts ?? []))
            }
        }
    }
    

    func updateCurrentUser(accountType: String? = nil, completion: @escaping (Result<(), Error>) -> ()){
        guard let userId = FirebaseAuthService.manager.currentUser?.uid else { return }
        var updateFields = [String:Any]()
        
        if let account = accountType {
            updateFields["accountType"] = account
        }
    
        db.collection("users").document(userId).updateData(updateFields) { (error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }

    func getExercises( completion: @escaping (Result<[Exercise],Error>) ->()) {
        db.collection("exercise").getDocuments { (snapshot, error) in
               if let error = error{
                   completion(.failure(error))
               }else {
                   let posts = snapshot?.documents.compactMap({ (snapshot) -> Exercise? in
                       let post = Exercise(from: snapshot.data())
                       return post
                   })
                   completion(.success(posts ?? []))
               }
           }
       }
    

    
    func deleteAllUserFavorites(apiSourceRawValue: String, completion: @escaping (Result<(), Error>) -> ()){
        let userID = FirebaseAuthService.manager.currentUser?.uid
        
        let db = Firestore.firestore()
       db.collection("\(apiSourceRawValue)Favorites").whereField("userID", isEqualTo: userID!).getDocuments() { (querySnapshot, err) in
          if let err = err {
            completion(.failure(err))
          } else {
            for document in querySnapshot!.documents {
              document.reference.delete()
                completion(.success(()))
            }
          }
        }
    }
   func createWorkoutPlan(plan: WorkoutPlan, completion: @escaping (Result<(), Error>) -> ()) {
    let fields  = plan.fieldsDict
    db.collection("workoutPlan").document("12231").setData(fields) { (error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    func getWorkoutPlan(completion: @escaping (Result<[WorkoutPlan],Error>) ->()) {
     db.collection("workoutPlan").getDocuments { (snapshot, error) in
            if let error = error{
                completion(.failure(error))
            }else {
                let plans = snapshot?.documents.compactMap({ (snapshot) -> WorkoutPlan? in
                    let plan = WorkoutPlan(from: snapshot.data(), id: snapshot.documentID)
                    return plan
                })
                completion(.success(plans ?? []))
            }
        }
    }
    func updateWorkoutPlan( workoutPlan: WorkoutPlan, completion: @escaping (Result<(), Error>) -> ()){
        let fields  = workoutPlan.fieldsDict
        db.collection("workoutPlan").document("12231").updateData(fields) { (error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
}//By david



//        db.collection(FireStoreCollections.favorites.rawValue).document(userID!).setData(fields) { (error) in
//            if let error = error {
//                completion(.failure(error))
//            } else {
//                completion(.success(()))
//            }
//        }


//    private func getAccountTypeInformation() {
//        let db = Firestore.firestore()
//        let docRef = db.collection("users").document(userID!)
//
//        docRef.getDocument { (document, error) in
//            if let document = document, document.exists {
//                if let property = document.get("accountType"){
//                    self.userAccountType = selectedAPI(rawValue: "\(property)")!
//                }
//
//            } else {
//                print("Document does not exist")
//            }
//        }
//    }
