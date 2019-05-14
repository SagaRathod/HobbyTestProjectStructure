//
//  Services.swift
//  HobbyTest
//
//  Created by appbellmac on 10/05/19.
//  Copyright © 2019 Sagar Rathode. All rights reserved.
//

import UIKit
import Foundation
import UIKit
import SwiftyJSON
import Alamofire
@objc protocol serviceDelegate {
   @objc optional func getHobbiesListResponse(HobbiesList: Array<Any>)
   @objc optional func getCategoryListResponse(CategoryList: Array<Any>)
}
class Services: NSObject{
    
        var serDelegate: serviceDelegate?
      class var sharedService : Services {
           return sharedServices
      }
    var g_ChobbiesArray = [AnyObject]()
     var g_categoryArray = [AnyObject]()
    func getHobbiesList(GAME_URL:String){
      
        let url = URL(string:GlobalAPIConstants.BASE_URL + GAME_URL)
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: request, completionHandler: {
            (data : Data?, response : URLResponse?, error : Error?) in
            
            if error != nil{
                print("Unable to fetch data")
            }
            
            do{
                let g_ChobbiesArrayRes = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSArray
                self.g_ChobbiesArray = [AnyObject]()
             for i in stride(from: 0, to: g_ChobbiesArrayRes.count, by: 1){
            
                  let tempObj = g_ChobbiesArrayRes.object(at: i) as AnyObject
                  let tempPlaceObject = HobbiesData()
                  let icon = tempObj.object(forKey: "icon") as! String
                  let name = tempObj.object(forKey: "name") as! String
                  tempPlaceObject.icon = icon
                   tempPlaceObject.name = name
                self.g_ChobbiesArray.append(tempPlaceObject)
            
              }
         self.serDelegate?.getHobbiesListResponse!(HobbiesList: self.g_ChobbiesArray)
        
       }
    })
        dataTask.resume()
  }
    func getHobbiescategory(){
        
        let url = URL(string:GlobalAPIConstants.BASE_URL + GlobalAPIConstants.GAME_CATEGORY_URL)
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: request, completionHandler: {
            (data : Data?, response : URLResponse?, error : Error?) in
            
            if error != nil{
                print("Unable to fetch data")
            }
            
            do{
                let g_categoryArrayRes = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSArray
                print(g_categoryArrayRes)
                self.g_categoryArray = [AnyObject]()
                for i in stride(from: 0, to: g_categoryArrayRes.count, by: 1){
                    
                    let tempObj = g_categoryArrayRes.object(at: i) as AnyObject
                    let tempPlaceObject = CategoryData()
                    let id = tempObj.object(forKey: "id") as! Int
                    let name = tempObj.object(forKey: "name") as! String
                    tempPlaceObject.id = id
                    tempPlaceObject.name = name
                    self.g_categoryArray.append(tempPlaceObject)
                    
                }
                self.serDelegate?.getCategoryListResponse!(CategoryList: self.g_categoryArray)
                
            }
        })
        dataTask.resume()
    }
  
}
let sharedServices = Services()
