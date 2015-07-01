//
//  Episode.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 01/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation

class Episode {
    
    var number: Int
    var name: String
    var url: String

    init(episode: Int, name: String, url: String) {
        self.number = episode
        self.name = name
        self.url = url
    }
    
}