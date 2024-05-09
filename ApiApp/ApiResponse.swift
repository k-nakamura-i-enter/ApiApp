//
//  ApiResponse.swift
//  ApiApp
//
//  Created by 中村 行汰 on 2024/04/22.
//

import RealmSwift

struct ApiResponse: Decodable {
    var results: Result
    struct Result: Decodable {
        var results_available: Int
        var shop: [Shop]
        struct Shop: Decodable {
            var id: String
            var name: String
            var logo_image: String
            var address: String
            var station_name: String
            var large_area: LargeArea
            var genre: Genre
            var budget: Budget
            var access: String
            var wifi: String
            var course: String
            var free_drink: String
            var free_food: String
            var private_room: String
            var horigotatsu: String
            var tatami: String
            var non_smoking: String
            var parking: String
            var barrier_free: String
            var pet: String
            var lunch: String
            var photo: Photo
            var coupon_urls: CouponUrls
            
            struct Photo: Decodable {
                var pc: PhotoPC
                var mobile: PhotoMobile
                
                struct PhotoPC: Decodable{
                    var l: String
                }
                struct PhotoMobile: Decodable{
                    var l: String
                }
            }
            struct CouponUrls: Decodable {
                var pc: String
                var sp: String
            }
            struct LargeArea: Decodable {
                var code: String
                var name: String
            }
            struct Genre: Decodable{
                var code: String
                var name: String
            }
            struct Budget: Decodable {
                var code: String
                var name: String
            }
            var isFavorite: Bool {
                if try! Realm().object(ofType: FavoriteShop.self, forPrimaryKey: self.id) != nil {
                    return true
                } else {
                    return false
                }
            }
        }
    }
}
