//
//  Catalog.swift
//  Everyday
//
//  Created by Михаил on 17.05.2024.
//

import Foundation

struct Train {
    var id: String
    var count: String
    var description: String
    var duration: String
    var image: String
    var level: String
    var title: String
    var exercises: [String]

    init?(dictionary: [String: Any]) {
        guard let id = dictionary["id"] as? String,
              let count = dictionary["count"] as? String,
              let description = dictionary["description"] as? String,
              let duration = dictionary["duration"] as? String,
              let image = dictionary["image"] as? String,
              let level = dictionary["level"] as? String,
              let title = dictionary["title"] as? String
        else {
            return nil
        }
        
        self.id = id
        self.count = count
        self.description = description
        self.duration = duration
        self.image = image
        self.level = level
        self.title = title
        self.exercises = []
    }
    
    init(id: String, count: String, description: String, duration: String,
         image: String, level: String, title: String, exercises: [String]) {
        self.id = id
        self.count = count
        self.description = description
        self.duration = duration
        self.image = image
        self.level = level
        self.title = title
        self.exercises = exercises
    }
}
