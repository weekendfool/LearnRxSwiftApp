//
//  ViewController.swift
//  LearnRxSwiftApp
//
//  Created by Oh!ara on 2022/05/19.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        createSample()
        
        firstSample()
    }

    // MARK: - 関数
    func createSample() {
        // 購読の破棄のコントロール
        let disposebag = DisposeBag()
        
        // マニュアルの作成
        let observable = Observable<String>.create { observer in
            observer.onNext("か")
            observer.onNext("き")
            observer.onNext("く")
            observer.onCompleted()
            
            return Disposables.create {
                print("Observer dispose")
            }
        }
        
        // observerの購読
        observable.subscribe { element in
            print("Observer: \(element)")
        } onDisposed: {
            print("Observer Disposed")
        }.disposed(by: disposebag)

    }
    
    func firstSample() {
        let praice = [0, 100, 200, 300]
        
        let taxRate = 1.10
        
        Observable.from(praice).map { praice in
            // タスクを流す
            Int(Double(praice) * taxRate)
//            print("on Next: \(praice)")
        }.subscribe { event in
            print(event)
        }.dispose()
    }
    
    

}

