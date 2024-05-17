//
//  Catalog.swift
//  Everyday
//
//  Created by Михаил on 17.05.2024.
//

import Foundation

struct Train {
    var count: Int
    var description: String
    var duration: Int
    var image: String
    var level: String
    var title: String

    init?(dictionary: [String: Any]) {
        guard let count = dictionary["count"] as? Int,
              let description = dictionary["description"] as? String,
              let duration = dictionary["duration"] as? Int,
              let image = dictionary["image"] as? String,
              let level = dictionary["level"] as? String,
              let title = dictionary["title"] as? String
        else {
            return nil
        }
        self.count = count
        self.description = description
        self.duration = duration
        self.image = image
        self.level = level
        self.title = title
    }
}
