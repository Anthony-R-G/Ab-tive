//
//  FeedPost.swift
//  RockHard
//
//  Created by Anthony Gonzalez on 1/31/20.
//  Copyright © 2020 Rockstars. All rights reserved.
//

import Foundation
import UIKit
import FirebaseFirestore


struct FeedPost {
    
    let userName: String
    let contentPicture: String
    let creatorID: String
    //    let ID: UUID
    let contentText: String
    let date: String
    
    
    
    static let testFeedData: [FeedPost] = [
        FeedPost(userName: "Hilbert", contentPicture: "hilbertPic", creatorID: "123ABC", contentText: "Wow! The gym is so cool! I just love, LOVE getting my gains!", date: "01/31/2020"),
        FeedPost(userName: "Mr. Buff Boi", contentPicture: "MrBuffManPic", creatorID: "456ABC", contentText: "I got super strong by doing 10 crunches and 5 push-ups a day! Who tryna step to the king??", date: "1/31/2020"),
        FeedPost(userName: "GymDude123", contentPicture: "gin", creatorID: "12318209", contentText: "I am a funny individual who enjoys posting humorous pictures from the internet. Please, my fellow readers, laugh with me.", date: "2/3/2020")]
}




