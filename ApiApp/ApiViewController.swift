//
//  ApiViewController.swift
//  ApiApp
//
//  Created by 中村 行汰 on 2024/04/22.
//

import UIKit
import Alamofire
import AlamofireImage
import RealmSwift


class ApiViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UIAdaptivePresentationControllerDelegate, ShopCellDelegate {
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    //searchBarアニメーション 切り替え
    let keyframes:[Double] = [0.0, 0.4, 3.4, 3.8]
    var animationStartDate = Date()
    var placeholderOpcity:Double = 1
    var currentPlaceholder = 0
    var placeholders = ["焼肉 食べ放題", "名古屋 居酒屋 宴会","札幌 ジンギスカン","福岡 ラーメン","女子会 スイーツ"]
        
    let realm = try! Realm()
    
    var shopArray: [ApiResponse.Result.Shop] = []
    var apiKey: String = ""
    
    var isLoading = false
    var isLastLoaded = false
    
    var settingArray = try! Realm().objects(SaveSetting.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "ShopCell", bundle: nil), forCellReuseIdentifier: "ShopCell")
        
        view.addSubview(searchBar)
        searchBar.frame = view.frame
        //displayLink設置
        let displayLink = CADisplayLink(target: self, selector: #selector(handleUpdate))
        displayLink.add(to: .main, forMode: .default)
        
        self.placeholders = self.placeholders.shuffled()

        // APIキー読み込み
        let filePath = Bundle.main.path(forResource: "ApiKey", ofType:"plist" )
        let plist = NSDictionary(contentsOfFile: filePath!)!
        apiKey = plist["key"] as! String

        // shopArray読み込み
        updateShopArray()
        
        // RefreshControlの設定
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    @objc func refresh() {
        // shopArray再読み込み
        updateShopArray()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    func updateShopArray(appendLoad: Bool = false, keyWord: String = "0") {
        settingArray = try! Realm().objects(SaveSetting.self)
        let settingFirst = settingArray.first ?? SaveSetting()
        let pickerSet = PickerSet()
        
        // 現在読み込み中なら読み込みを開始しない
        if isLoading {
            return
        }
        // 最後まで読み込んでいるなら、追加読み込みしない
        if appendLoad && isLastLoaded {
            return
        }
        // 読み込み開始位置を設定
        let startIndex: Int
        if appendLoad {
            startIndex = shopArray.count + 1
        } else {
            startIndex = 1
        }
        
        //読み込み数
        let indexCount: Int = 20
        
        // 読み込み中状態開始
        isLoading = true
        var parameters: [String: Any] = [
            "key": apiKey,
            "start": startIndex,
            "count": indexCount,
            "keyword": keyWord,
            "large_area": String(pickerSet.largeArea[settingFirst.largeAreaRow].key),
            "genre": String(pickerSet.genre[settingFirst.genreRow].key),
            "budget": String(pickerSet.budget[settingFirst.budgetRow].key),
            "wifi": String(settingFirst.isWifi ? 1 : 0),
            "parking": String(settingFirst.isParking ? 1 : 0),
            "private_room": String(settingFirst.isPrivateRoom ? 1 : 0),
            "non_smoking": String(settingFirst.isNonSmoking ? 1 : 0),
            "barrier_free": String(settingFirst.isBarrierFree ? 1 : 0),
            "tatami": String(settingFirst.isTatami ? 1 : 0),
            "horigotatsu": String(settingFirst.isHorigotatsu ? 1 : 0),
            "course": String(settingFirst.isCourse ? 1 : 0),
            "free_drink": String(settingFirst.isFreeDrink ? 1 : 0),
            "free_food": String(settingFirst.isFreeFood ? 1 : 0),
            "lunch": String(settingFirst.isLunch ? 1 : 0),
            "shochu": String(settingFirst.isShochu ? 1 : 0),
            "cocktail": String(settingFirst.isCocktail ? 1 : 0),
            "wine": String(settingFirst.isWine ? 1 : 0),
            "sake": String(settingFirst.isSake ? 1 : 0),
            "format": "json"
        ]
        
        parameters = parameters.filter { $0.value as? String != "0" }
        
        AF.request("https://webservice.recruit.co.jp/hotpepper/gourmet/v1/", method: .get, parameters: parameters).responseDecodable(of: ApiResponse.self) { response in
            // 読み込み中状態終了
            self.isLoading = false
            // リフレッシュ表示動作停止
            if self.tableView.refreshControl!.isRefreshing {
                self.tableView.refreshControl!.endRefreshing()
            }
            // レスポンス受信処理
            switch response.result {
            case .success(let apiResponse):
//                print("受信データ: \(apiResponse)")
//                print("受信データ: \(apiResponse.results.shop.count)")
                if appendLoad {
                    // 追加読み込みの場合は、現在のshopArrayに追加
                    self.shopArray += apiResponse.results.shop
                } else {
                    // 追加読み込みでない場合はそのまま代入し、isLastLoadedをリセット
                    self.shopArray = apiResponse.results.shop
                    self.isLastLoaded = false
                }
                // 読み込み数が0なら最後まで読み込まれたと判断
                if apiResponse.results.shop.count == 0 {
                    self.isLastLoaded = true
                }
                self.statusLabel.text = ""
            case .failure(let error):
                print(error)
                self.shopArray = []
                self.isLastLoaded = true
                self.statusLabel.text = "一致する情報は見つかりませんでした"
            }
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print(shopArray.count)
        return shopArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShopCell", for: indexPath) as! ShopCell
        cell.delegate = self
        let shop = shopArray[indexPath.row]
        // セルの設定
        cell.setCell(shopLogoImege: shop.logo_image, shopName: shop.name, shopAddress: shop.address)
        // 星アイコンの設定
        cell.favoriteButton.setImage(setStar(shop.isFavorite), for: .normal)
        
        if shopArray.count - indexPath.row < 10 {
            self.updateShopArray(appendLoad: true)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let shop = shopArray[indexPath.row]
        
        let shopDetailView = self.storyboard?.instantiateViewController(withIdentifier: "ShopDetail") as! ShopDetailViewController
        shopDetailView.shopName = shop.name
        shopDetailView.shopId = shop.id
        shopDetailView.shopLogoImage = shop.logo_image
        shopDetailView.shopAddress = shop.address
        shopDetailView.shopStationName = shop.station_name
        shopDetailView.shopAccess = shop.access
        shopDetailView.shopWifi = shop.wifi
        shopDetailView.shopCourse = shop.course
        shopDetailView.shopFreeDrink = shop.free_drink
        shopDetailView.shopFreeFood = shop.free_food
        shopDetailView.shopPrivateRoom = shop.private_room
        shopDetailView.shopHorigotatsu = shop.horigotatsu
        shopDetailView.shopTatami = shop.tatami
        shopDetailView.shopNonSmoking = shop.non_smoking
        shopDetailView.shopParking = shop.parking
        shopDetailView.shopBarrierFree = shop.barrier_free
        shopDetailView.shopPet = shop.pet
        shopDetailView.shopLunch = shop.lunch
        if shop.coupon_urls.sp == "" {
            shopDetailView.shopCouponUrls = shop.coupon_urls.pc
        } else {
            shopDetailView.shopCouponUrls = shop.coupon_urls.sp
        }
        if shop.photo.mobile.l == "" {
            shopDetailView.shopImage = shop.photo.pc.l
        }else{
            shopDetailView.shopImage = shop.photo.mobile.l
        }
        shopDetailView.shopArea = shop.large_area.name
        shopDetailView.shopGenre = shop.genre.name
        shopDetailView.shopBudget = shop.budget.name
        shopDetailView.isFavorite = shop.isFavorite
        self.navigationController?.pushViewController(shopDetailView, animated: true)
    }
    
    func shopCellDelegateTapFavoriteButton(favoriteButton: UIButton) {
        let point = favoriteButton.convert(CGPoint.zero, to: tableView)
        let indexPath = tableView.indexPathForRow(at: point)!
        let shop = shopArray[indexPath.row]

        if shop.isFavorite {
            print("「\(shop.name)」をお気に入りから削除します")
            try! realm.write {
                let favoriteShop = realm.object(ofType: FavoriteShop.self, forPrimaryKey: shop.id)!
                realm.delete(favoriteShop)
            }
        }
        else {
            print("「\(shop.name)」をお気に入りに追加します")
            try! realm.write {
                let favoriteShop = FavoriteShop()
                favoriteShop.id = shop.id
                favoriteShop.name = shop.name
                favoriteShop.logo_image = shop.logo_image
                favoriteShop.address = shop.address
                favoriteShop.station_name = shop.station_name
                favoriteShop.access = shop.access
                favoriteShop.wifi = shop.wifi
                favoriteShop.course = shop.course
                favoriteShop.free_drink = shop.free_drink
                favoriteShop.free_food = shop.free_food
                favoriteShop.private_room = shop.private_room
                favoriteShop.horigotatsu = shop.horigotatsu
                favoriteShop.tatami = shop.tatami
                favoriteShop.non_smoking = shop.non_smoking
                favoriteShop.parking = shop.parking
                favoriteShop.barrier_free = shop.barrier_free
                favoriteShop.pet = shop.pet
                favoriteShop.lunch = shop.lunch
                favoriteShop.large_area_name = shop.large_area.name
                favoriteShop.genre_name = shop.genre.name
                favoriteShop.budget_name = shop.budget.name
                if shop.coupon_urls.sp == "" {
                    favoriteShop.coupon_urls = shop.coupon_urls.pc
                } else {
                    favoriteShop.coupon_urls = shop.coupon_urls.sp
                }
                if shop.photo.mobile.l == "" {
                    favoriteShop.shopImage = shop.photo.pc.l
                } else {
                    favoriteShop.shopImage = shop.photo.mobile.l
                }
                realm.add(favoriteShop)
            }
        }
        tableView.reloadData()
    }
    
    @IBAction func settingButton(_ sender: UIButton) {
        let storyboard: UIStoryboard = self.storyboard!
        let settingView = storyboard.instantiateViewController(withIdentifier: "Setting") as! SearchViewController
        settingView.presentationController?.delegate = self
        settingView.keyword = searchBar.text ?? "0"
        self.present(settingView, animated: true, completion: nil)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar){
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        updateShopArray(keyWord: searchBar.text ?? "0")
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.resignFirstResponder()
        searchBar.setShowsCancelButton(false, animated: true)
        updateShopArray(keyWord: "0")
    }
    
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        settingArray = try! Realm().objects(SaveSetting.self)
        let settingFirst = settingArray.first ?? SaveSetting()
        updateShopArray(keyWord: settingFirst.keyword)
    }
    
    func setStar(_ isFavorite: Bool) -> UIImage{
        let starImageName = isFavorite ? "star.fill" : "star"
        let starImage = (UIImage(systemName: starImageName)?.withRenderingMode(.alwaysOriginal))!
        return starImage
    }
    
    func setPlaceholderTextAndOpacity(opacity:Double, text:String) {
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString( string: text, attributes: [NSAttributedString.Key.foregroundColor : UIColor.init(white: 0.6, alpha: CGFloat(opacity))])
    }

    //SearchBarのアニメーション更新設定
    @objc func handleUpdate() {
        let now = Date()
        let elapsedTime = now.timeIntervalSince(animationStartDate)

        switch elapsedTime {
            case 0 ..< keyframes[1]:
                let animationDuration = keyframes[1] - keyframes[0]
                let percentage:Double = elapsedTime / animationDuration
                placeholderOpcity = percentage
                setPlaceholderTextAndOpacity(opacity: placeholderOpcity, text: placeholders[currentPlaceholder])

            case keyframes[1] ..< keyframes[2]:
                //keyframe 1
                placeholderOpcity = 1
                setPlaceholderTextAndOpacity(opacity: placeholderOpcity, text: placeholders[currentPlaceholder])

            case keyframes[2] ..< keyframes[3]:
                let elapsedTimeInKeyframe = elapsedTime - keyframes[2]
                let animationDuration = keyframes[3] - keyframes[2]
                let percentage:Double = elapsedTimeInKeyframe / animationDuration
                placeholderOpcity = 1 - percentage
                setPlaceholderTextAndOpacity(opacity: placeholderOpcity, text: placeholders[currentPlaceholder])

            default:
                animationStartDate = Date()
                if currentPlaceholder == placeholders.count - 1 {
                    currentPlaceholder = 0
                } else {
                    currentPlaceholder += 1
                }
                setPlaceholderTextAndOpacity(opacity: 0, text: placeholders[currentPlaceholder])
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
