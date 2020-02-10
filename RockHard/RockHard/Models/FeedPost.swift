//
//  FeedPost.swift
//  RockHard
//
//  Created by Anthony Gonzalez on 1/31/20.
//  Copyright © 2020 Rockstars. All rights reserved.
//

import Foundation
import UIKit


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
        FeedPost(userName: "Definitely Not A Spam Bot", contentPicture: "humanBeing", creatorID: "123456", contentText: "Hello, fellow human beings, because I am definitely a human as well. If you would like to increase your muscle mass and get big in just 10 days, follow this link...", date: "01/31/2020")]
}
