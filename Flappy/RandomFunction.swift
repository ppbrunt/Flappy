//
//  RandomFunction.swift
//  FlappyClone
//
//  Created by oilklenze on 15/12/23.
//  Copyright © 2015年 pp. All rights reserved.
//

import Foundation
import CoreGraphics


public  extension CGFloat {
    public static func random() -> CGFloat{
        return  CGFloat (Float (arc4random()) / 0xFFFFFFFF)
        
    }
    
    public static func random (min min : CGFloat , max :CGFloat) ->CGFloat{
     
        return CGFloat.random() * (max - min) + min
    }
}


