//
//  FavoreteViewController.swift
//  ApiApp
//
//  Created by 中村 行汰 on 2024/04/22.
//

import UIKit
import RealmSwift
import AlamofireImage
import SafariServices

class FavoriteViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ShopCellDelegate {
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    let realm = try! Realm()
    
    var favoriteArray = try! Realm().objects(FavoriteShop.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ShopCell", bundle: nil), forCellReuseIdentifier: "ShopCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        tableView.reloadData()
        if favoriteArray.count == 0 {
            statusLabel.text = "お気に入りはまだ登録されていません"
        } else {
            statusLabel.text = ""
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShopCell", for: indexPath) as! ShopCell
        cell.delegate = self
        let favoriteShop = favoriteArray[indexPath.row]
        cell.setCell(shopLogoImege: favoriteShop.logo_image, shopName: favoriteShop.name, shopAddress: favoriteShop.address)

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let shop = favoriteArray[indexPath.row]
        
        let shopDetailView = self.storyboard?.instantiateViewController(withIdentifier: "ShopDetail") as! ShopDetailViewController
        shopDetailView.shopName = shop.name
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
        self.navigationController?.pushViewController(shopDetailView, animated: true)
    }
    
    func shopCellDelegateTapFavoriteButton(favoriteButton: UIButton) {
        let point = favoriteButton.convert(CGPoint.zero, to: tableView)
        let indexPath = tableView.indexPathForRow(at: point)!
        let favoriteShop = favoriteArray[indexPath.row]

        let alert = UIAlertController(title: favoriteShop.name, message: "この店舗をお気に入りから削除してもよろしいですか?", preferredStyle: .alert)

        let okAction = UIAlertAction(title: "OK", style: .default) { action in
            print("「\(favoriteShop.name)」をお気に入りから削除します")
            try! self.realm.write {
                self.realm.delete(favoriteShop)
            }
            self.tableView.reloadData()
            if self.favoriteArray.count == 0 {
                self.statusLabel.text = "お気に入りはまだ登録されていません"
            } else {
                self.statusLabel.text = ""
            }
        }
        alert.addAction(okAction)

        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel)
        alert.addAction(cancelAction)

        present(alert, animated: true)
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
