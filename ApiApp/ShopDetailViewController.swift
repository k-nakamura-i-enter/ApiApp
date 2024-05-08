//
//  ShopDetailViewController.swift
//  ApiApp
//
//  Created by 中村 行汰 on 2024/04/24.
//

import UIKit
import RealmSwift
import SafariServices

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
    
    let realm = try! Realm()
    
    var shopRaw: Int = 0
    var shopId: String = ""
    var isFavorite: Bool = false
    
    var shopArea: String = ""
    var shopGenre: String = ""
    var shopBudget: String = ""
    var shopCouponUrls:String = ""
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
    
    var shopImage: String = ""
    
    //アニメーション 切り替え
    let keyframes:[Double] = [0.0, 0.5, 4.5, 5.0]
    var animationStartDate = Date()
    var placeholderOpcity:Double = 1
    var currentPlaceholder = 0
    
    var imageArray:[String] = []
        
    override func viewDidLoad() {
        super.viewDidLoad()
        imageArray = [shopLogoImage, shopImage]
        
        title = shopName
        
        //displayLink設置
        let displayLink = CADisplayLink(target: self, selector: #selector(imageUpdate))
        displayLink.add(to: .main, forMode: .default)
        
        largeArea.text = shopArea
        genre.text = shopGenre
        budget.text = shopBudget
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
        
        setupButton()
        setupCoupon()
    }
    
    private func setupButton(){
        let button = UIButton(type: .system)
        button.accessibilityIdentifier = "favoriteButton"
        button.setImage(setStar(isFavorite), for: .normal)
        button.addTarget(self, action: #selector(tapFavoriteButton), for: .touchUpInside)
        button.backgroundColor = .orange
        button.layer.cornerRadius = 40
        button.frame = CGRect(x: self.view.frame.size.width - 100, y: self.view.frame.size.height - 150, width: 80  , height: 80)
        self.view.addSubview(button)
    }
    
    private func setupCoupon(){
        let button = UIButton(type: .system)
        button.setTitle("クーポンはこちら", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.addTarget(self, action: #selector(tapCouponButton), for: .touchUpInside)
        button.backgroundColor = .yellow
        if #available(iOS 15.0, *) {
            button.configuration = nil
         }
        button.titleLabel?.font = UIFont(name: "Symbol", size: 25)
        button.layer.cornerRadius = 40
        button.frame = CGRect(x: 10, y: self.view.frame.size.height - 150, width: 200  , height: 80)
        self.view.addSubview(button)
    }
    
    func setStar(_ isFavorite: Bool) -> UIImage{
        let starImageName = isFavorite ? "star.fill" : "star"
        let starImage = (UIImage(systemName: starImageName, withConfiguration: UIImage.SymbolConfiguration(pointSize: 30))?.withRenderingMode(.alwaysOriginal))!
        return starImage
    }
    
    @objc func tapFavoriteButton(favoriteButton: UIButton){
        if isFavorite {
            print("「\(shopName)」をお気に入りから削除します")
            try! realm.write {
                let favoriteShop = realm.object(ofType: FavoriteShop.self, forPrimaryKey: shopId)!
                realm.delete(favoriteShop)
            }
        }
        else {
            print("「\(shopName)」をお気に入りに追加します")
            try! realm.write {
                let favoriteShop = FavoriteShop()
                favoriteShop.id = shopId
                favoriteShop.name = shopName
                favoriteShop.logo_image = shopLogoImage
                favoriteShop.address = shopAddress
                favoriteShop.station_name = shopStationName
                favoriteShop.access = shopAccess
                favoriteShop.wifi = shopWifi
                favoriteShop.course = shopCourse
                favoriteShop.free_drink = shopFreeDrink
                favoriteShop.free_food = shopFreeFood
                favoriteShop.private_room = shopPrivateRoom
                favoriteShop.horigotatsu = shopHorigotatsu
                favoriteShop.tatami = shopTatami
                favoriteShop.non_smoking = shopNonSmoking
                favoriteShop.parking = shopParking
                favoriteShop.barrier_free = shopBarrierFree
                favoriteShop.pet = shopPet
                favoriteShop.lunch = shopLunch
                favoriteShop.large_area_name = shopArea
                favoriteShop.genre_name = shopGenre
                favoriteShop.budget_name = shopBudget
                favoriteShop.coupon_urls = shopCouponUrls
                favoriteShop.shopImage = shopImage
                realm.add(favoriteShop)
            }
        }
        isFavorite.toggle()
        favoriteButton.setImage(setStar(isFavorite), for: .normal)
    }
    
    @objc func tapCouponButton(){
        let url = URL(string: shopCouponUrls)!
        let safariViewController = SFSafariViewController(url: url)
        safariViewController.modalPresentationStyle = .pageSheet
        present(safariViewController, animated: true)
    }
    
    @objc func imageUpdate(){
        let now = Date()
        let elapsedTime = now.timeIntervalSince(animationStartDate)
        print(elapsedTime.description)

        switch elapsedTime {
            case 0 ..< keyframes[1]:
                let animationDuration = keyframes[1] - keyframes[0]
                let percentage:Double = elapsedTime / animationDuration
                placeholderOpcity = percentage
                setImageAndOpacity(opacity: placeholderOpcity, image: imageArray[currentPlaceholder])

            case keyframes[1] ..< keyframes[2]:
                placeholderOpcity = 1
                setImageAndOpacity(opacity: placeholderOpcity, image: imageArray[currentPlaceholder])

            case keyframes[2] ..< keyframes[3]:
                let elapsedTimeInKeyframe = elapsedTime - keyframes[2]
                let animationDuration = keyframes[3] - keyframes[2]
                let percentage:Double = elapsedTimeInKeyframe / animationDuration
                placeholderOpcity = 1 - percentage
                setImageAndOpacity(opacity: placeholderOpcity, image: imageArray[currentPlaceholder])

            default:
                animationStartDate = Date()
                if currentPlaceholder == imageArray.count - 1 {
                    currentPlaceholder = 0
                } else {
                    currentPlaceholder += 1
                }
                
        }
        
        func setImageAndOpacity(opacity:Double, image:String) {
            let imageUrl = URL(string: imageArray[currentPlaceholder])!
            logoImage?.af.setImage(withURL: imageUrl)
            logoImage.alpha = CGFloat(opacity)
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
