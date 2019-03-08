//
//  StockPrice.swift
//  RxSwiftTut
//
//  Created by Shubham on 08/03/19.
//  Copyright © 2019 Franciscan Solutions. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift


class StockPrice {
    
    public let symbol : String
    public var isFavorite : Bool = false
    private let price = Variable<Double>(0)
    
    var priceObservable : Observable<Double> {
        return price.asObservable()
    }
    
    init(symbol : String , favorite : Bool) {
        self.symbol = symbol
        self.isFavorite = favorite
    }
    
    func updatePrice(_ price : Double){
        self.price.value = price
    }
}
