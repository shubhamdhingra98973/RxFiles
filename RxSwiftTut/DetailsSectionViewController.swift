
//
//  DetailsSectionViewController.swift
//  RxSwiftTut
//
//  Created by Shubham on 25/02/19.
//  Copyright © 2019 Franciscan Solutions. All rights reserved.
//

import UIKit
import RxAtomic
import RxSwift

class DetailsSectionViewController: UIViewController {

    private var selectNameVal = Variable("Raxson")
   
    var selectName : Observable<String> {
        return selectNameVal.asObservable()
    }
    
    var string = "A"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func btnSelectNameAct(_ sender : UIButton){
        if string == "A"{
            string = "B"
            selectNameVal.value = string
        }
        else {
            string = "A"
            selectNameVal.value = string
        }
     }
    
}
