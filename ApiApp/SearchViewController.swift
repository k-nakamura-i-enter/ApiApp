//
//  SearchViewController.swift
//  ApiApp
//
//  Created by 中村 行汰 on 2024/04/23.
//

import UIKit
import RealmSwift

class SearchViewController: UIViewController {
    @IBOutlet weak var wifiSwitch: UISwitch!
    @IBOutlet weak var parkingSwitch: UISwitch!
    @IBOutlet weak var privateRoomSwitch: UISwitch!
    @IBOutlet weak var nonSmokingSwitch: UISwitch!
    @IBOutlet weak var barrierFreeSwitch: UISwitch!
    @IBOutlet weak var tatamiSwitch: UISwitch!
    @IBOutlet weak var horigotatsuSwitch: UISwitch!
    @IBOutlet weak var freeDrinkSwitch: UISwitch!
    @IBOutlet weak var freeFoodSwitch: UISwitch!
    @IBOutlet weak var courseSwitch: UISwitch!
    @IBOutlet weak var lunchSwitch: UISwitch!
    @IBOutlet weak var shochuSwitch: UISwitch!
    @IBOutlet weak var cocktailSwitch: UISwitch!
    @IBOutlet weak var wineSwitch: UISwitch!
    @IBOutlet weak var sakeSwitch: UISwitch!
    @IBOutlet weak var petSwitch: UISwitch!
    
    let realm = try! Realm()
    let SettingArray = try! Realm().objects(SaveSetting.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let saveSetting = SettingArray.first{
            wifiSwitch.isOn = saveSetting.isWifi
            parkingSwitch.isOn = saveSetting.isParking
            privateRoomSwitch.isOn = saveSetting.isPrivateRoom
            nonSmokingSwitch.isOn = saveSetting.isNonSmoking
            barrierFreeSwitch.isOn = saveSetting.isBarrierFree
            tatamiSwitch.isOn = saveSetting.isTatami
            horigotatsuSwitch.isOn = saveSetting.isHorigotatsu
            freeDrinkSwitch.isOn = saveSetting.isFreeDrink
            freeFoodSwitch.isOn = saveSetting.isFreeFood
            courseSwitch.isOn = saveSetting.isCourse
            lunchSwitch.isOn = saveSetting.isLunch
            shochuSwitch.isOn = saveSetting.isShochu
            cocktailSwitch.isOn = saveSetting.isCocktail
            wineSwitch.isOn = saveSetting.isWine
            sakeSwitch.isOn = saveSetting.isSake
            petSwitch.isOn = saveSetting.isPet
        }
    }
    
    @IBAction func closeEvent(_ sender: UIButton) {
        if let saveSetting = SettingArray.first {
            try! realm.write{
                saveSetting.isWifi = wifiSwitch.isOn
                saveSetting.isParking = parkingSwitch.isOn
                saveSetting.isPrivateRoom = privateRoomSwitch.isOn
                saveSetting.isNonSmoking = nonSmokingSwitch.isOn
                saveSetting.isBarrierFree = barrierFreeSwitch.isOn
                saveSetting.isTatami = tatamiSwitch.isOn
                saveSetting.isHorigotatsu = horigotatsuSwitch.isOn
                saveSetting.isFreeDrink = freeDrinkSwitch.isOn
                saveSetting.isFreeFood = freeFoodSwitch.isOn
                saveSetting.isCourse = courseSwitch.isOn
                saveSetting.isLunch = lunchSwitch.isOn
                saveSetting.isShochu = shochuSwitch.isOn
                saveSetting.isCocktail = cocktailSwitch.isOn
                saveSetting.isWine = wineSwitch.isOn
                saveSetting.isSake = sakeSwitch.isOn
                saveSetting.isPet = petSwitch.isOn
                realm.add(saveSetting)
            }
        }
        else{
            let saveSetting = SaveSetting()
            try! realm.write{
                saveSetting.isWifi = wifiSwitch.isOn
                saveSetting.isParking = parkingSwitch.isOn
                saveSetting.isPrivateRoom = privateRoomSwitch.isOn
                saveSetting.isNonSmoking = nonSmokingSwitch.isOn
                saveSetting.isBarrierFree = barrierFreeSwitch.isOn
                saveSetting.isTatami = tatamiSwitch.isOn
                saveSetting.isHorigotatsu = horigotatsuSwitch.isOn
                saveSetting.isFreeDrink = freeDrinkSwitch.isOn
                saveSetting.isFreeFood = freeFoodSwitch.isOn
                saveSetting.isCourse = courseSwitch.isOn
                saveSetting.isLunch = lunchSwitch.isOn
                saveSetting.isShochu = shochuSwitch.isOn
                saveSetting.isCocktail = cocktailSwitch.isOn
                saveSetting.isWine = wineSwitch.isOn
                saveSetting.isSake = sakeSwitch.isOn
                saveSetting.isPet = petSwitch.isOn
                
                realm.add(saveSetting)
            }
        }
        dismiss(animated: true)
    }
    
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        super.dismiss(animated: flag, completion: completion)
        guard let presentationController = presentationController else {
            return
        }
        presentationController.delegate?.presentationControllerDidDismiss?(presentationController)
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
