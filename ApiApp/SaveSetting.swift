//
//  SaveSetting.swift
//  ApiApp
//
//  Created by 中村 行汰 on 2024/04/23.
//

import RealmSwift

class SaveSetting: Object{
    @Persisted var largeAreaRow: Int
    @Persisted var genreRow: Int
    @Persisted var budgetRow: Int
    @Persisted var isWifi: Bool = false
    @Persisted var isParking: Bool = false
    @Persisted var isPrivateRoom: Bool = false
    @Persisted var isNonSmoking: Bool = false
    @Persisted var isBarrierFree: Bool = false
    @Persisted var isTatami: Bool = false
    @Persisted var isHorigotatsu: Bool = false
    @Persisted var isFreeDrink: Bool = false
    @Persisted var isFreeFood: Bool = false
    @Persisted var isCourse: Bool = false
    @Persisted var isLunch: Bool = false
    @Persisted var isShochu: Bool = false
    @Persisted var isCocktail: Bool = false
    @Persisted var isWine: Bool = false
    @Persisted var isSake: Bool = false
    @Persisted var isPet: Bool = false
}

struct PickerSet{
    let largeArea: KeyValuePairs = ["0":"選択してください（※必須）",
                                    "Z041":"北海道","Z051":"青森","Z054":"秋田","Z055":"山形",
                                    "Z052":"岩手","Z053":"宮城","Z056":"福島","Z011":"東京",
                                    "Z012":"神奈川","Z013":"埼玉","Z014":"千葉","Z016":"栃木",
                                    "Z015":"茨城","Z017":"群馬","Z061":"新潟","Z065":"山梨",
                                    "Z066":"長野","Z063":"石川","Z062":"富山","Z064":"福井",
                                    "Z033":"愛知","Z031":"岐阜","Z032":"静岡","Z034":"三重",
                                    "Z023":"大阪","Z024":"兵庫","Z022":"京都","Z021":"滋賀",
                                    "Z025":"奈良","Z026":"和歌山","Z073":"岡山","Z074":"広島",
                                    "Z071":"鳥取","Z072":"島根","Z075":"山口","Z082":"香川",
                                    "Z081":"徳島","Z083":"愛媛","Z084":"高知","Z091":"福岡",
                                    "Z092":"佐賀","Z093":"長崎","Z094":"熊本","Z095":"大分",
                                    "Z096":"宮崎","Z097":"鹿児島","Z098":"沖縄"]
    let genre: KeyValuePairs = ["0":"お店のジャンルすべて",
                                "G001":"居酒屋","G002":"ダイニングバー・バル","G003":"創作料理",
                                "G004":"和食","G005":"洋食","G006":"イタリアン・フレンチ",
                                "G007":"中華","G008":"焼肉・ホルモン","G017":"韓国料理",
                                "G009":"アジア・エスニック料理","G010":"各国料理",
                                "G011":"カラオケ・パーティ","G012":"バー・カクテル",
                                "G013":"ラーメン","G016":"お好み焼き・もんじゃ",
                                "G014":"カフェ・スイーツ","G015":"その他グルメ"]
    let budget: KeyValuePairs = ["0":"こだわらない",
                                 "B009":"～500円","B010":"501～1000円","B011":"1001～1500円",
                                 "B001":"1501～2000円","B002":"2001～3000円","B003":"3001～4000円",
                                 "B008":"4001～5000円","B004":"5001～7000円","B005":"7001～10000円",
                                 "B006":"10001～15000円","B012":"15001～20000円",
                                 "B0013":"20001～30000円","B0014":"30001円～"]
}
