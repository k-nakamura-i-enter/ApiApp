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
    // API通信セル
    func setCell(shopLogoImege: String, shopName: String, shopAddress: String){
        let url = URL(string: shopLogoImege)!
        self.logoImageView.af.setImage(withURL: url)
        self.shopNameLabel.text = shopName
        self.addressLabel.numberOfLines = 0
        self.addressLabel.text = shopAddress
        self.addressLabel.lineBreakMode = .byWordWrapping
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func tapFavoriteButton(_ sender: UIButton) {
        
    }
}
