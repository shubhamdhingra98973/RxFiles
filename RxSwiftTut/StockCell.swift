//
//  StockCell.swift
//  RxSwiftTut
//
//  Created by Shubham on 08/03/19.
//  Copyright © 2019 Franciscan Solutions. All rights reserved.
//

import UIKit

class StockCell: UITableViewCell {

    @IBOutlet weak var lblSymbol : UILabel?
    @IBOutlet weak var lblPrice : UILabel?

    
    func update(with : StockPrice){
        lblSymbol?.text = with.symbol
        lblPrice?.text = "12"
    }
}
