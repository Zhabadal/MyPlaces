//
//  PlaceModel.swift
//  MyPlaces
//
//  Created by Alexandr Badmaev on 11.09.2020.
//  Copyright © 2020 Alexandr Badmaev. All rights reserved.
//

import UIKit

struct Place {
    var name: String
    var location: String?
    var type: String?
    var image: UIImage?
    var restaurantImage: String?
    
    static let restaurantNames = ["Балкан Гриль", "Бочка", "Вкусные истории", "Дастархан", "Индокитай", "Классик", "Шок", "Bonsai", "Burger Heroes", "Kitchen", "Love&Life", "Morris Pub", "Sherlock Holmes", "Speak Easy", "X.O"]
    
    static func getPlaces() -> [Place] {
        var places = [Place]()
        for name in restaurantNames {
            places.append(Place(name: name, location: "Москва", type: "Ресторан", image: nil, restaurantImage: name))
        }
        return places
    }

}
