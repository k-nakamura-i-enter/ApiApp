//
//  FavoriteShop.swift
//  ApiApp
//
//  Created by 中村 行汰 on 2024/04/23.
//

import RealmSwift

class FavoriteShop: Object {
    // 店舗id
    @Persisted(primaryKey: true) var id = ""

    // 店舗名
    @Persisted var name = ""

    // 店舗画像URL
    @Persisted var logo_image = ""

    // クーポン画面URL
    @Persisted var couponURL = ""
    
    //住所
    @Persisted var address = ""

}
