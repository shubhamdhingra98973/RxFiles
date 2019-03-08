//
//  ViewController.swift
//  RxSwiftTut
//
//  Created by Shubham on 22/02/19.
//  Copyright © 2019 Franciscan Solutions. All rights reserved.
//

import UIKit
import RxSwift
import Foundation

class ViewController: UIViewController {

    @IBOutlet weak var greetingsLabel : UILabel?
    let disposeBag = DisposeBag()
    var names = Variable(["Peter"])

    override func viewDidLoad() {
        
        super.viewDidLoad()
    //    print(names.value)
        
        funOnBasic()
        names.value = ["1"]
        names.value = ["1" , "2" , "3"]
        names.value = ["1", "2", "3", "4"]
        names.value = ["4"]
    }
    
    
    func funOnBasic(){
        
        //only subscribe
//        _ = names.asObservable().subscribe(onNext: { (values) in
//            print(values)
//        })
        
        
        //subscribe and filter
//        _ = names.asObservable().filter({ (value) -> Bool in
//            return value.count > 1
//        }).subscribe(onNext: { (value) in
//            print(value)
//        })
        
        
        //subscribe & map & filter
//        _ = names.asObservable().filter({ (value) -> Bool in
//            return value.count > 1
//        }).map({ value in
//            return "users : \(value)"
//        }).debug()
//            .subscribe(onNext: { (value) in
//            print(value)
//        })
        
        
        
        //subscribe & map & filter & throttle
        _ = names.asObservable().throttle(5, scheduler: MainScheduler.instance)
        .filter({ (value) -> Bool in
            return value.count > 1
        }).map({ value in
            return "users : \(value)"
        }).subscribe(onNext: { (value) in
            print(value)
        })
     }
    
}

extension ViewController {
    
    @IBAction func selectCharacter(_ sender : UIButton){
        guard  let vc = storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController else {
            return
        }
        _ = vc.selectedCharacter.subscribe(onNext: {[weak self] (value) in
            self?.greetingsLabel?.text = value
            }, onError: { (error) in
                print(error)
        }, onCompleted: {
            print("Greetings update successfully")
        }) {
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func selectNameAct(_ sender : UIButton){
        
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController else {
            return
        }
        _ =  vc.selectCharac.subscribe(onNext: { (string) in
            self.greetingsLabel?.text = string
        }, onError: { (_) in
            print("error")
        }, onCompleted: {
            print("Done")
        }).disposed(by: disposeBag)
        
        
    }
    
    
    @IBAction func selectCharacterAct(_ sender : Any){
        
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController else {
            return
        }
        _ =  vc.selectedCharacter.subscribe(onNext: { (string) in
            self.greetingsLabel?.text = string
        }, onError: { (_) in
            print("error")
        }, onCompleted: {
            print("Done")
        })
        self.navigationController?.pushViewController(vc, animated: true)
   
    }
}
