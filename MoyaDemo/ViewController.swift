//
//  ViewController.swift
//  MoyaDemo
//
//  Created by tenltrs on 2019/4/16.
//  Copyright © 2019 Tenltrs. All rights reserved.
//

import UIKit
import RxSwift

class ViewController: UIViewController {
    
    fileprivate var bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        
//        RequestManager.homeApi.rxRequest(.saveName(name: "刘")).subscribe(onNext: { (result) in
//            if result.success{
//
//
//            }
//        }, onError: { (error) in
//
//
//        }).disposed(by: bag)
//
//
//        RequestManager.homeApi.rxRequest(.saveList(list: ["sss", "qqq", "数据啊海口市的卡号的"])).subscribe(onNext: { (result) in
//            if result.success, let data = result.data{
//
//                print(data)
//            }
//        }, onError: { (error) in
//
//        }).disposed(by: bag)
//
//
//        Observable.zip(RequestManager.homeApi.rxRequest(.saveList(list: ["sss", "qqq", "数据啊海口市的卡号的"])),RequestManager.homeApi.rxRequest(.saveName(name: "刘"))).subscribe(onNext: { (list, name) in
//
//            if list.success, let data = list.data{
//
//                print(data)
//            }
//
//            if name.success, let data = name.data{
//
//                print(data)
//            }
//
//        }).disposed(by: bag)

    }

}

