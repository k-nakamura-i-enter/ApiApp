//
//  ShopCell.swift
//  ApiApp
//
//  Created by 中村 行汰 on 2024/04/26.
//

import UIKit

class ShopCell: UITableViewCell {
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var shopNameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    func setCell(shop: ApiResponse.Result.Shop){
        let url = URL(string: shop.logo_image)!
        self.logoImageView.af.setImage(withURL: url)
        self.shopNameLabel.text = shop.name
        self.addressLabel.numberOfLines = 0
        self.addressLabel.text = shop.address
        self.addressLabel.lineBreakMode = .byWordWrapping
        // 星アイコンの設定
        self.favoriteButton.setImage(setStar(shop.isFavorite), for: .normal)
    }
    
    func setCell(favoriteShop: FavoriteShop){
        let url = URL(string: favoriteShop.logo_image)!
        self.logoImageView.af.setImage(withURL: url)
        self.shopNameLabel.text = favoriteShop.name
        self.addressLabel.numberOfLines = 0
        self.addressLabel.text = favoriteShop.address
        self.addressLabel.lineBreakMode = .byWordWrapping
    }
    
    func setStar(_ isFavorite: Bool) -> UIImage{
        let starImageName = isFavorite ? "star.fill" : "star"
        let starImage = (UIImage(systemName: starImageName)?.withRenderingMode(.alwaysOriginal))!
        return starImage
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
