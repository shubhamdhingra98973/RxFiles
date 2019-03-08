//
//  SecondViewController.swift
//  RxSwiftTut
//
//  Created by Shubham on 08/03/19.
//  Copyright © 2019 Franciscan Solutions. All rights reserved.
//

import UIKit
import RxSwift
import Foundation
import RxCocoa

class SecondViewController: UIViewController {

    fileprivate let bag = DisposeBag()
    
    //Input
    fileprivate let allSymbols = ["RZR" , "UDP" , "MTT" , "ZKQ" , "IPK" , "EQU"]
    fileprivate let allPrices = Variable<[StockPrice]>([])
    
    //Output
    fileprivate let prices = Variable<[StockPrice]>([])
    
    
    //Outlets
    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var favoriteSwitch : UISwitch!
    @IBOutlet weak var searchItem : UITextField!
    
    //Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        onViewDidLoad()
//        tableView?.delegate = self
//        tableView?.dataSource = self
//        tableView?.reloadData()
    }
    
    func onViewDidLoad() {
        allPrices.value = allSymbols.enumerated().map({ (index , symbol) in
            return StockPrice(symbol: symbol, favorite: index % 2 == 0)
        })
        //prices.value = allPrices.value
        bindUI()
        
    }
    
    func bindUI() {
        Observable.combineLatest(allPrices.asObservable(), favoriteSwitch.rx.isOn, searchItem.rx.text, resultSelector: {currentPrices , onlyFavorites ,search in
//        print("\(currentPrices) \(onlyFavorites) \(search ?? "nil")")
            currentPrices.filter{price  -> Bool in
                return self.showDisplayPrice(price: price, onlyFavorite: onlyFavorites, searchText: search)
            }
        }).bind(to: prices).disposed(by: bag)
        _ = prices.asObservable().subscribe(onNext: { [weak self] value in
        self?.tableView.reloadData()
        })
    }
}


extension SecondViewController : UITableViewDelegate, UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return prices.value.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "StockCell") as? StockCell else {
            return UITableViewCell()
        }
        let price = prices.value[indexPath.row]
        cell.lblSymbol?.text = price.symbol
        cell.selectionStyle = .none
        cell.lblPrice?.text = "\(indexPath.row)"
        return cell
    }
    
    
    fileprivate func showDisplayPrice(price : StockPrice , onlyFavorite : Bool , searchText : String?) -> Bool{
        if searchText?.trimmingCharacters(in: .whitespaces).count == 0 {
         return price.isFavorite == onlyFavorite
        }
        return price.isFavorite == onlyFavorite && price.symbol.contains("\(searchText ?? "")")
    }
    
    
    
}


