//
//  ShopDetailViewController.swift
//  ApiApp
//
//  Created by 中村 行汰 on 2024/04/24.
//

import UIKit

class ShopDetailViewController: UIViewController {
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var stationName: UILabel!
    @IBOutlet weak var access: UILabel!
    @IBOutlet weak var wifi: UILabel!
    @IBOutlet weak var course: UILabel!
    @IBOutlet weak var freeDrink: UILabel!
    @IBOutlet weak var freeFood: UILabel!
    @IBOutlet weak var privateRoom: UILabel!
    @IBOutlet weak var horigotatsu: UILabel!
    @IBOutlet weak var tatami: UILabel!
    @IBOutlet weak var nonSmoking: UILabel!
    @IBOutlet weak var parking: UILabel!
    @IBOutlet weak var barrierFree: UILabel!
    @IBOutlet weak var pet: UILabel!
    @IBOutlet weak var lunch: UILabel!
    @IBOutlet weak var largeArea: UILabel!
    @IBOutlet weak var genre: UILabel!
    @IBOutlet weak var budget: UILabel!
    
    var shopArea: String = ""
    var shopGenre: String = ""
    var shopBudget: String = ""
    
    var shopLogoImage: String = ""
    var shopName: String = ""
    var shopAddress: String = ""
    var shopStationName: String = ""
    var shopAccess: String = ""
    var shopWifi: String = ""
    var shopCourse: String = ""
    var shopFreeDrink: String = ""
    var shopFreeFood: String = ""
    var shopPrivateRoom: String = ""
    var shopHorigotatsu: String = ""
    var shopTatami: String = ""
    var shopNonSmoking: String = ""
    var shopParking: String = ""
    var shopBarrierFree: String = ""
    var shopPet: String = ""
    var shopLunch: String = ""
        
    override func viewDidLoad() {
        super.viewDidLoad()
        let imageUrl = URL(string: shopLogoImage)!
        logoImage?.af.setImage(withURL: imageUrl)
        title = shopName
        
//        largeArea.text = shopArea
//        genre.text = shopGenre
//        budget.text = shopBudget
        
        address.text = shopAddress
        stationName.text = "\(shopStationName)駅"
        access.text = shopAccess
        wifi.text = "[WiFi]\(shopWifi)"
        course.text = "[コース]\(shopCourse)"
        freeDrink.text = "[飲み放題]\(shopFreeDrink)"
        freeFood.text = "[食べ放題]\(shopFreeFood)"
        privateRoom.text = "[個室]\(shopPrivateRoom)"
        horigotatsu.text = "[掘りごたつ]\(shopHorigotatsu)"
        tatami.text = "[座敷]\(shopTatami)"
        nonSmoking.text = "[禁煙席]\(shopNonSmoking)"
        parking.text = "[駐車場]\(shopParking)"
        barrierFree.text = "[バリアフリー]\(shopBarrierFree)"
        pet.text = "[ペット連れ]\(shopPet)"
        lunch.text = "[ランチ]\(shopLunch)"
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
