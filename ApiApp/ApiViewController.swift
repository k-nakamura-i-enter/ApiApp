//
//  ApiViewController.swift
//  ApiApp
//
//  Created by 中村 行汰 on 2024/04/22.
//

import UIKit
import Alamofire
import AlamofireImage

class ApiViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var shopArray: [ApiResponse.Result.Shop] = []
    var apiKey: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

        // APIキー読み込み
        let filePath = Bundle.main.path(forResource: "ApiKey", ofType:"plist" )
        let plist = NSDictionary(contentsOfFile: filePath!)!
        apiKey = plist["key"] as! String

        // shopArray読み込み
        updateShopArray()
    }
    
    func updateShopArray() {
        let parameters: [String: Any] = [
            "key": apiKey,
            "start": 1,
            "count": 20,
            "keyword": "ランチ",
            "format": "json"
        ]
        AF.request("https://webservice.recruit.co.jp/hotpepper/gourmet/v1/", method: .get, parameters: parameters).responseDecodable(of: ApiResponse.self) { response in
            // レスポンス受信処理
            switch response.result {
            case .success(let apiResponse):
                print("受信データ: \(apiResponse)")
                self.shopArray = apiResponse.results.shop
                self.statusLabel.text = ""
            case .failure(let error):
                print(error)
                self.shopArray = []
                self.statusLabel.text = "データの取得が失敗しました"
            }
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shopArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ShopCell
        let shop = shopArray[indexPath.row]
        let url = URL(string: shop.logo_image)!
        cell.logoImageView.af.setImage(withURL: url)
        cell.shopNameLabel.text = shop.name

        return cell
    }
    
    @IBAction func tapFavoriteButton(_ sender: UIButton) {
        
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
