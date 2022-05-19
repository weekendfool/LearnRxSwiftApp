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
        
//        firstSample()
        
        secondSample()
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
    
    func secondSample() {
        // 購読の監視？
        let disposeBag = DisposeBag()
        // subjectの生成
//        let subject = PublishSubject<String>()
       let subject = BehaviorSubject<String>(value: "黒")
        
        // subjectにひとつ目の要素を発行
        subject.onNext("赤")
        
        // 購読者１
        subject.subscribe { element in
            print("observer: 1 - Event \(element)")
        } onCompleted: {
            print("observer: 1 - Event fin")
        } onDisposed: {
            print("observer: 1 - Event 購読破棄")
        }.disposed(by: disposeBag)
        
        
        // subjectにふたつ目の要素を発行
        subject.onNext("青")
        // subjectに三つ目の要素を発行
        subject.onNext("黄")
        
        // 購読者2
        subject.subscribe { element in
            print("observer: 2 - Event \(element)")
        } onCompleted: {
            print("observer: 2 - Event fin")
        } onDisposed: {
            print("observer: 2 - Event 購読破棄")
        }.disposed(by: disposeBag)
        
        // subjectに四つ目の要素を発行
        subject.onNext("緑")
        
        // 購読者３
        subject.subscribe { element in
            print("observer: 3 - Event \(element)")
        } onCompleted: {
            print("observer: 3 - Event fin")
        } onDisposed: {
            print("observer: 3 - Event 購読破棄")
        }.disposed(by: disposeBag)
        
        // subjectに四つ目の要素を発行
        subject.onNext("紫")
        
        // 購読者4
        subject.subscribe { element in
            print("observer: 4 - Event \(element)")
        } onCompleted: {
            print("observer: 4 - Event fin")
        } onDisposed: {
            print("observer: 4 - Event 購読破棄")
        }.disposed(by: disposeBag)
        
        subject.onCompleted()
        
        // 購読者の設定より後に実装したイベントのみ発火する
        
        // イベントが発火する->それまでに登録されていた購読者に通知　のイメージ

    }
    
    

}

