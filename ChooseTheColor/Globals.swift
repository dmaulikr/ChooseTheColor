//
//  Globals.swift
//  ChooseTheColor
//
//  Created by Greg Willis on 2/28/16.
//  Copyright © 2016 Willis Programming. All rights reserved.
//

import UIKit


/**
 Gets you a random number (CGFloat) between 0 and 1.
 - Returns: A pseudo-random number between 0 and 1.
 */
func random() -> CGFloat {
    return CGFloat(Float(arc4random()) / Float(UINT32_MAX))
}
