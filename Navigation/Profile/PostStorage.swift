//
//  Post.swift
//  Navigation
//

import Foundation
import UIKit

struct PostVK {
    var author: String
    var description: String?
    var image: UIImage?
    var likes: Int
    var views: Int
}

struct Storage {
    
   static let arrayPost = [
    PostVK(
            author: "Ivan",
            description: "Интересный пост от Ивана",
            image: UIImage(named: "public_1")!,
            likes: 5,
            views: 5
        ),
    PostVK(
            author: "Masha",
            description: "Интересный пост от Маши",
            image: UIImage(named: "public_2")!,
            likes: 1,
            views: 1
        ),
    PostVK(
            author: "Dasha",
            description: "Интересный пост от Даши",
            image: UIImage(named: "public_3")!,
            likes: 3,
            views: 3
        ),
    PostVK(
            author: "Petr",
            description: "Интересный пост от Петра",
            image: UIImage(named: "public_4")!,
            likes: 2,
            views: 2
        ),
    ]
}
