//
//  NewsViewModel.swift
//  isdavydov_3PW4
//
//  Created by Иван Давыдов on 06.12.2022.
//

import UIKit

final class NewsViewModel {
    let title: String
    let description: String
    let imageURL: URL?
    var imageData: Data? = nil
    
    init(title: String, description: String, imageURL: URL?) {
        self.title = title
        self.description = description
        self.imageURL = imageURL
    }
}
