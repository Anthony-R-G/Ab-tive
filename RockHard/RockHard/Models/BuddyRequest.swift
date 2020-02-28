//
//  BuddyRequestModel.swift
//  RockHard
//
//  Created by albert coelho oliveira on 2/24/20.
//  Copyright © 2020 Rockstars. All rights reserved.
//

import Foundation
import FirebaseFirestore

struct BuddyRequest{
    let creatorId: String
    let creatorGym: String
    let buddyId: String
    let dateCreated: Date?
    var isAvailable: Bool
    let requestDate: Date?
    let requestInfo: String
    
    var createdDateFormat: String {
        guard let date = dateCreated else{
            return "no date"
        }
        return date.getElapsedInterval()
    }
    var requestedDateFormat: String {
        guard let date = requestDate else {
            return "error"
        }
        let dateFormatter = DateFormatter()
                     dateFormatter.dateFormat = "dd MMM, hh:mm"
        return "Requested for: \(dateFormatter.string(from: date))"
    }
    
    init?(from dict: [String: Any], id: String) {
            guard let creatorId = dict["creatorID"] as? String,
                let creatorGym = dict["creatorGym"] as? String,
                let buddyId = dict["buddyId"] as? String,
                let isAvailable = dict["isAvailable"] as? Bool,
                 let requestDate = (dict["requestDate"] as? Timestamp)?.dateValue(),
                let requestInfo = dict["requestInfo"] as? String,
                let dateCreated = (dict["dateCreated"] as? Timestamp)?.dateValue()
        else { return nil }
        self.creatorId = creatorId
        self.creatorGym = creatorGym
        self.buddyId = buddyId
        self.dateCreated = dateCreated
        self.isAvailable = isAvailable
        self.requestDate = requestDate
        self.requestInfo = requestInfo
    }}
extension Date {

func getElapsedInterval() -> String {

    let interval = Calendar.current.dateComponents([.day, .hour,.minute], from: self, to: Date())

   
      if let day = interval.day, day > 0 {
        return day == 1 ? "\(day)" + " " + "day ago" :
            "\(day)" + " " + "days ago"
    }else if let hour = interval.hour, hour > 0{
        return hour == 1 ? "\(hour)" + " " + "hours ago" :
        "\(hour)" + " " + "hours ago"
    }
    else if let minute = interval.minute, minute > 0{
        return minute == 1 ? "\(minute)" + " " + "minutes ago" :
        "\(minute)" + " " + "minutes ago"
    }
    else {
        return "a moment ago"
    }
}
}
       
