//
//  ApiResponse.swift
//  ApiApp
//
//  Created by 中村 行汰 on 2024/04/22.
//

struct ApiResponse: Decodable {
    var results: Result
    struct Result: Decodable {
        var shop: [Shop]
        struct Shop: Decodable {
            var id: String
            var name: String
            var logo_image: String
            var coupon_urls: CouponUrls
            struct CouponUrls: Decodable {
                var pc: String
                var sp: String
            }
        }
    }
}
