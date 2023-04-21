//
//  PageModel.swift
//  Pinch
//
//  Created by Jared Infantino on 2023-04-21.
//

import Foundation

// Using the Identifiable protocol so the properties are more easily accessed later
struct Page: Identifiable {
    let id: Int
    let imageName: String
}

extension Page {
    var thumbnailName: String  { // computer property
        return "thumb-" + imageName // string concatenation
    }
}
