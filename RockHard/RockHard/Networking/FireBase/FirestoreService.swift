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
    
    func getAllPost(completion: @escaping (Result<[Post], Error>) -> ()){
          db.collection("feedPosts").getDocuments {(snapshot, error) in
              if let error = error{
                  completion(.failure(error))
              }else {
                  let posts = snapshot?.documents.compactMap({ (snapshot) -> Post? in
                      let postID = snapshot.documentID
                      let post = Post(from: snapshot.data(), id: postID)
                      return post
                  })
                  completion(.success(posts ?? []))
              }
          }
      }
    
    func createPost(post: Post, completion: @escaping (Result<(), Error>) -> ()) {
        var fields = post.fieldsDict
        fields["dateCreated"] = Date()
      
        
        db.collection("feedPosts").document().setData(fields) { (error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
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
}

    
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
