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
        
//        secondSample()
        
//    deferredSample()
        
//        fratMapSample()
        
        margeSample()
    }

    // MARK: - 関数
   
    func firstSample() {
        // コールド　仕事していない、上司に質問されて即座に仕事して返事をするイメージ
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
        
        // ホット　仕事自体はしている、日報を上げたら上司が購読するイメージ
        // 購読の監視？
        // disposeBagがsecondSample()内で宣言されているから、secondSample()が終了したときに.disposed(by: disposeBag)処理が走る
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
        
        // observerの購読者登録
        observable.subscribe { element in
            print("Observer: \(element)")
        } onDisposed: {
            print("Observer Disposed")
        }.disposed(by: disposebag)

    }
    
    func deferredSample() {
        // 購読の破棄のコントロール
        let disposebag = DisposeBag()
        var count = 0
        
        //
        let observable = Observable<Date>.deferred {
            count += 1
            print("create observale: \(count)")
            
            return Observable<Date>.just(Date())
        }
        
        // 購読者１
        observable.subscribe { element in
            print("observer1 : \(element)")
        }.disposed(by: disposebag)
        
        // 二秒間待機
        Thread.sleep(until: Date(timeIntervalSinceNow: 2))
        
        // 購読者２
        observable.subscribe { element in
            print("observer2 : \(element)")
        
        }.disposed(by: disposebag)

    }
    
    func fratMapSample() {
        // 購読の破棄のコントロール
        let disposebag = DisposeBag()
        
        Observable<String>.of("左", "右").flatMap { element in
            // ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー
            // 新しいObservableに変換
            // 新しいObservableに対してsubscribe,disposedが不要なイメージ
            Observable<String>.of("L", "R").map { value in
                "element：　\(element), value：　\(value)"
            }
            
            // ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー
            
        }.subscribe { element in
            // 購読開始
            print("element2: \(element)")
        
        }.disposed(by: disposebag)

    }
    
    func margeSample() {
        // 購読の破棄のコントロール
        let disposebag = DisposeBag()
        
        // subject作成
        let subject1 = PublishSubject<String>()
        let subject2 = PublishSubject<String>()
        
        // observable作成
        // .merge([subject1, subject2])で登録しておけばどちらのイベントも購読できる
        let observable = Observable<String>.merge([subject1, subject2])
        
        // 購読
        observable.subscribe { event in
            print("observer: \(event)")
        
        }.disposed(by: disposebag)
        
        // 発行
        subject1.onNext("ai")
        subject2.onNext("ue")

        
    }
    

}

