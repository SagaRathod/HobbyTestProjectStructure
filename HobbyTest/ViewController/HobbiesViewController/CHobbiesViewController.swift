//
//  CHobbiesViewController.swift
//  HobbyTest
//
//  Created by appbellmac on 10/05/19.
//  Copyright © 2019 Sagar Rathode. All rights reserved.
//

import UIKit
import Kingfisher
class CHobbiesViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource, serviceDelegate {
    @IBOutlet weak var hcollectionView: UICollectionView!
     var g_ChobbiesArray = [HobbiesData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return g_ChobbiesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HobbiesCollectionViewCell
        cell.layer.cornerRadius = 3
        
        let temp = g_ChobbiesArray[indexPath.row]
        cell.m_cNameLabel?.text = temp.name
        let url = URL(string: GlobalAPIConstants.BASE_URL + temp.icon)
        print(url as Any)
       // cell.m_cProfileImageView.kf.setImage(with: url)
       DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            
            DispatchQueue.main.async {
                cell.m_cProfileImageView.image = UIImage(data: data!)
                
            }
        }
        
       return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let nbCol = 3
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(nbCol - 1))
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(nbCol))
        return CGSize(width: size, height: size)
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
          let temp = g_ChobbiesArray[indexPath.row]
        let controller = storyboard?.instantiateViewController(withIdentifier: "CDetailsViewController") as! CDetailsViewController
        controller.M_ghobbyName = temp.name
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
    func getHobbiesListResponse(HobbiesList : Array<Any>){
        self.g_ChobbiesArray = HobbiesList as [AnyObject] as! [HobbiesData]
        DispatchQueue.main.async {
        self.hcollectionView.reloadData()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        (Services.sharedService).serDelegate = self as serviceDelegate
        (Services.sharedService).getHobbiesList(GAME_URL:GlobalAPIConstants.INDOOR_GAME_URL)
    }
    @IBAction func addHobbiesAction(_ sender: Any) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "CAddHobbiesViewController") as! CAddHobbiesViewController
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
    
}
