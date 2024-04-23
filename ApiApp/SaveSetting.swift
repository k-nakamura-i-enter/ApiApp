//
//  SaveSetting.swift
//  ApiApp
//
//  Created by 中村 行汰 on 2024/04/23.
//

import RealmSwift

class SaveSetting: Object{
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
