//
//  CAddHobbiesViewController.swift
//  HobbyTest
//
//  Created by appbellmac on 10/05/19.
//  Copyright © 2019 Sagar Rathode. All rights reserved.
//

import UIKit

class CAddHobbiesViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource,serviceDelegate {
    
    
    @IBOutlet weak var hobbyTypeBtn: RoundedButton!
    
    @IBOutlet weak var hobbyTypePickerview: UIPickerView!
    @IBOutlet weak var hobbyNamePickerview: UIPickerView!
    @IBOutlet weak var hobbyNameBtn: RoundedButton!
    @IBOutlet weak var m_cDescriptionTextview: UITextView!
     var g_categoryArray = [CategoryData]()
     var g_ChobbiesArray = [HobbiesData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        m_cDescriptionTextview.layer.borderColor = UIColor.black.cgColor
        m_cDescriptionTextview.layer.borderWidth = 1.0
        m_cDescriptionTextview.layer.cornerRadius = 5.0
        m_cDescriptionTextview.clipsToBounds = true
         hobbyTypePickerview.isHidden = true
        hobbyNamePickerview.isHidden = true
        
        hobbyNamePickerview.layer.cornerRadius = 3
        hobbyNamePickerview.layer.borderColor = UIColor.black.cgColor
        hobbyNamePickerview.layer.borderWidth =  0.7
        hobbyNamePickerview.clipsToBounds = true
        
        hobbyTypePickerview.layer.cornerRadius = 3
        hobbyTypePickerview.layer.borderColor = UIColor.black.cgColor
        hobbyTypePickerview.layer.borderWidth = 0.7
        hobbyTypePickerview.clipsToBounds = true
        hobbyNameBtn.isEnabled = false
        
    }

    @IBAction func hobbyTypeBtnAction(_ sender: Any) {
        //open dropdown HobbyType
        hobbyTypePickerview.isHidden = false
        hobbyNamePickerview.isHidden = true
        
        hobbyTypePickerview.dataSource = self
        hobbyTypePickerview.delegate = self
        
    }
    @IBAction func hobbyNameActionBtn(_ sender: Any) {
        //open pickerview HobbyName
        hobbyTypePickerview.isHidden = true
        hobbyNamePickerview.isHidden = false
        
        hobbyNamePickerview.delegate = self
        hobbyNamePickerview.dataSource = self
    
        
    }
    @IBAction func okActionBtn(_ sender: Any) {
        //add new Hobby
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func cancelActionBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func getHobbiesListResponse(HobbiesList : Array<Any>){
        self.g_ChobbiesArray = HobbiesList as [AnyObject] as! [HobbiesData]
        
    }
    func getCategoryListResponse(CategoryList: Array<Any>){
        self.g_categoryArray = CategoryList as [AnyObject] as! [CategoryData]
        hobbyNameBtn.isEnabled = true
    }
   
    //MARK:- pickerView
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        if( hobbyTypePickerview.isHidden == false){
            return g_categoryArray.count
        }else{
            return g_ChobbiesArray.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel: UILabel? = (view as? UILabel)
        if pickerLabel == nil {
            pickerLabel = UILabel()
            pickerLabel?.font = UIFont.systemFont(ofSize:13)
            pickerLabel?.textAlignment = .center
        }
        
        if( hobbyTypePickerview.isHidden == false){
            let temp = g_categoryArray[row]
            pickerLabel?.text = temp.name
            pickerLabel?.textColor = UIColor.black
        }else{
             let temp = g_ChobbiesArray[row]
            pickerLabel?.text = temp.name
            pickerLabel?.textColor = UIColor.black
        }
        
        return pickerLabel!
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
         if( hobbyTypePickerview.isHidden == false){
            let temp = g_categoryArray[row]
            self.hobbyTypeBtn.setTitle(temp.name , for: .normal)
            self.hobbyTypePickerview.isHidden = true
            
            (Services.sharedService).serDelegate = self as serviceDelegate
            let id = temp.id
            if id == 2 {
                 (Services.sharedService).getHobbiesList(GAME_URL:GlobalAPIConstants.INDOOR_GAME_URL)
                
            }else{
                (Services.sharedService).getHobbiesList(GAME_URL:GlobalAPIConstants.OUTDOOR_GAME_URL)
            }
        }else{
            let temp = g_ChobbiesArray[row]
            self.hobbyNameBtn.setTitle(temp.name, for: .normal)
            self.hobbyNamePickerview.isHidden = true
    
    }
   
    }
    override func viewDidAppear(_ animated: Bool) {
        (Services.sharedService).serDelegate = self as serviceDelegate
        (Services.sharedService).getHobbiescategory()
    }
    func touchesBegan(_ touches: Set<AnyHashable>, withwith event: UIEvent) {
        let touch: UITouch? = touches.first as? UITouch
        if touch?.view != hobbyTypePickerview {
            hobbyTypePickerview.isHidden = true
        }
        if touch?.view != hobbyNamePickerview {
            hobbyNamePickerview.isHidden = true
        }
        
    }
    
}
