//
//  CDetailsViewController.swift
//  HobbyTest
//
//  Created by appbellmac on 10/05/19.
//  Copyright © 2019 Sagar Rathode. All rights reserved.
//

import UIKit

class CDetailsViewController: UIViewController {

    @IBOutlet weak var m_cHobbyTypeLbl: UILabel!
    
    @IBOutlet weak var m_cNameLbl: UILabel!
    
    @IBOutlet weak var m_cHobbyNameLbl: UILabel!
    
    @IBOutlet weak var m_cDescriptionTextview: UITextView!
    var M_ghobbyName = String()
    @IBOutlet weak var m_cOkBtn: RoundedButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        m_cDescriptionTextview.layer.borderColor = UIColor.black.cgColor
        m_cDescriptionTextview.layer.borderWidth = 1.0
        m_cDescriptionTextview.layer.cornerRadius = 5.0
        m_cDescriptionTextview.clipsToBounds = true
        
        m_cHobbyNameLbl.text = M_ghobbyName
        
    }
    
    
    @IBAction func okBtnAction(_ sender: Any) {
        
        //pop viewController
        self.navigationController?.popViewController(animated: true)
    }
    
}
