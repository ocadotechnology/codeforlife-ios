//
// Created by Thomas CASSANY on 17/06/15.
// Copyright (c) 2015 Ocado. All rights reserved.
//

import Foundation

class Level {
    
    var number: Int
    var description: String
    var nextLevel: Level?

    init(number: Int, description: String){
        self.number = number
        self.description = description
    }

}
