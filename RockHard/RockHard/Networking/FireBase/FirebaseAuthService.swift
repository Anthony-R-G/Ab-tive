//
//  FirebaseAuthService.swift
//  RockHard
//
//  Created by Rockstars on 2/3/20.
//  Copyright © 2020 Rockstars. All rights reserved.
//

import Foundation
import FirebaseAuth


class FirebaseAuthService {
    static let manager = FirebaseAuthService()
    
    private let auth = Auth.auth()
    
    var currentUser: User? {
        return auth.currentUser
    }
    
    func createNewUser(email: String, password: String, completion: @escaping (Result<User,Error>) -> ()) {
        auth.createUser(withEmail: email, password: password) { (result, error) in
            if let createdUser = result?.user {
                completion(.success(createdUser))
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }
    
    
    
    func loginUser(email: String, password: String, completion: @escaping (Result<(), Error>) -> ()) {
        auth.signIn(withEmail: email, password: password) { (result, error) in
            if (result?.user) != nil {
                completion(.success(()))
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }
    
    func signOutUser() {
        do {
            try auth.signOut()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
     func deleteUser(completion: @escaping (Result<(),Error>) -> ()){
        let user = auth.currentUser
        user?.delete { error in
          if let error = error {
            print(error)
            completion(.failure(error))
          } else {
            completion(.success(()))
           print("account deleted")
          }
        }
    }
    
    private init () {}
}
