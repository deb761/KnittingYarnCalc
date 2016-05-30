//
//  Mittens.swift
//  YarnRequirements
//
//  Created by Deb on 5/22/16.
//  Copyright © 2016 The Inquisitive Introvert. All rights reserved.
//

import Foundation

class Mittens : Project {
    
}

class Gloves : Project {
    
}

class Socks : Project {
    
}

class Tam : Project {
    
}

class Scarf : Project {
    override func calcYarnRequired()
    {
        super.calcYarnRequired(100, siWidth: 100)
    }
    
}

class Blanket : Scarf {
    
}

class Toque : Project {
    
}
class Vest : Project {
    
}