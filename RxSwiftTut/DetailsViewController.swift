//
//  DetailsViewController.swift
//  RxSwiftTut
//
//  Created by Shubham on 22/02/19.
//  Copyright © 2019 Franciscan Solutions. All rights reserved.
//
import RxSwift
import RxAtomic
import UIKit

class DetailsViewController: UIViewController {

    private let selCharacterVal = Variable("")
    private let selCharacterValue = Variable("a")
    
    
    var selectedCharacter : Observable<String>{
        return selCharacterVal.asObservable()
    }
    
    var selectCharac : Observable<String>{
        return selCharacterValue.asObservable()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func characterSelected(_ sender : UIButton){
        guard let characterName = sender.titleLabel?.text else {
            return
        }
        selCharacterVal.value = characterName
        selCharacterValue.value = characterName
    }
    
}
