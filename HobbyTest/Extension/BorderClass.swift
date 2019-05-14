//
//  BorderClass.swift
//  HobbyTest
//
//  Created by appbellmac on 10/05/19.
//  Copyright © 2019 Sagar Rathode. All rights reserved.
//

import UIKit

class BorderClass: UIView {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.borderWidth = 1.0
        layer.borderColor = (UIColor.black as! CGColor)
        layer.cornerRadius = 5.0
        clipsToBounds = true
        
    }

}
