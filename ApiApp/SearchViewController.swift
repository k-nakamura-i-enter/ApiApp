//
//  SearchViewController.swift
//  ApiApp
//
//  Created by 中村 行汰 on 2024/04/23.
//

import UIKit
import RealmSwift

class SearchViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var prefecturesPicker: UIPickerView!
    @IBOutlet weak var genrePicker: UIPickerView!
    @IBOutlet weak var pricePicker: UIPickerView!
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
    let pickerSet = PickerSet()
    let SettingArray = try! Realm().objects(SaveSetting.self)
    var largeAreaRow: Int?
    var genreRow: Int?
    var budgetRow: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prefecturesPicker.delegate = self
        prefecturesPicker.dataSource = self
        genrePicker.delegate = self
        genrePicker.dataSource = self
        pricePicker.delegate = self
        pricePicker.dataSource = self
        
        if let saveSetting = SettingArray.first{
            prefecturesPicker.selectRow(saveSetting.largeAreaRow, inComponent: 0, animated: true)
            genrePicker.selectRow(saveSetting.genreRow, inComponent: 0, animated: true)
            pricePicker.selectRow(saveSetting.budgetRow, inComponent: 0, animated: true)
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
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case prefecturesPicker:
            return pickerSet.largeArea.count
        case genrePicker:
            return pickerSet.genre.count
        case pricePicker:
            return pickerSet.budget.count
        default:
            return 1
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case prefecturesPicker:
            return pickerSet.largeArea[row].value
        case genrePicker:
            return pickerSet.genre[row].value
        case pricePicker:
            return pickerSet.budget[row].value
        default:
            return "データの取得に失敗しました"
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case prefecturesPicker:
            self.largeAreaRow = row
        case genrePicker:
            self.genreRow = row
        case pricePicker:
            self.budgetRow = row
        default:
            throw
        }
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
