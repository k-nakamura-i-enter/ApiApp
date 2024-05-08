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
    @Persisted var coupon_urls = ""
    
    //住所
    @Persisted var address = ""
    
    @Persisted var station_name = ""
    @Persisted var access = ""
    @Persisted var wifi = ""
    @Persisted var course = ""
    @Persisted var free_drink = ""
    @Persisted var free_food = ""
    @Persisted var private_room = ""
    @Persisted var horigotatsu = ""
    @Persisted var tatami = ""
    @Persisted var non_smoking = ""
    @Persisted var parking = ""
    @Persisted var barrier_free = ""
    @Persisted var pet = ""
    @Persisted var lunch = ""
    
    @Persisted var large_area_name = ""
    @Persisted var genre_name = ""
    @Persisted var budget_name = ""
    
    @Persisted var shopImage = ""

}
