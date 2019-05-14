//
//  HobbiesCollectionViewCell.swift
//  HobbyTest
//
//  Created by appbellmac on 10/05/19.
//  Copyright © 2019 Sagar Rathode. All rights reserved.
//

import UIKit

class HobbiesCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var m_cProfileImageView: UIImageView!
    @IBOutlet weak var m_cNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        m_cNameLabel.layer.borderColor = UIColor.black.cgColor
        m_cNameLabel.layer.borderWidth = 1.0
        m_cNameLabel.layer.cornerRadius = 5.0
        m_cNameLabel.clipsToBounds = true
    }
    
    
}
