//
//  ViewController.swift
//  MyMap
//
//  Created by Daisuke Doi on 2022/11/28.
//

import UIKit
import MapKit


/*
 閑話休題
 クラスに"./ドット"を当てると、そのクラス内のメソッドを呼び出せる
 固有のメソッドに"./ドット"をつけると、プロパティとして機能を呼び出せる
 要は親要素がもってる機能を1つ選んで実行していると言う理解でおk
 PowerShellだとオプションとか呼ぶせいでオプショナルとごっちゃになるが、なんか呼び出してやらしてるくらいの認識で全て　投げ出しても　いいじゃないの？　Used to be 諦めるのは　easy
  */




/*
delegateとは、あるクラスで行いたい処理の一部を他のクラスに任せたり、任せた処理を指定したクラスに通知(=戻り値を渡す)したりする仕組み 登場するものは下記の3つ

 ①処理を依頼するクラス　ViewController
 　UITextFieldクラスから作ったインスタンスのinputTextに、delegateメソッドを当ててる
  imputText.delegate = self　と記述することで、delegateの通知先を自分自身(self)に設定
  通知してほしい内容は「textFieldShouldReturn」メソッドを指定しているので、マップを検索するキーワードが
　入力されて、キーボードの「return」がタップされたタイミングの情報

 ②依頼する、依頼されるクラスを取り持つプロトコル（規約、決め事）　 UITextFieldDelegate
 　マップアプリで実際に、検索キーワードが入力されて「return」がタップされた時の情報を取得して
 　通知先が「ViewController」である、という決め事を「UITextField」に教える
 
 ③処理が依頼されるクラス UITextField　(=inputText)
 　UITextFieldDelegateから通知を受けたら、UITextFieldは、ViewCOntrollerに
 「return」がタップされた時の情報を知らせる
 
 ざっくり説明すると、「アプリで操作された内容とタイミングを通知してくれて、私たちが行いたい処理を実装できる仕組み」
*/



/*
 クロージャ　とは、{} で囲った処理をまとめて実行させること
 　↓↓基本的な書式↓↓
 {(引数 : 引数の型) -> (戻り値の型) in
  何らかの処理
  return 戻り値
 }
 
 戻り値がない場合は、-> (戻り値)　と　return 戻り値　を省略できる。
　↓↓省略版の書式↓↓
 {(引数 : 引数の型) in
  何らかの処理
 }
 
 今回はgeocoder.geocodeAddressString メソッドに2つの引数を与えており、
 第一引数は　検索キーワードのseachKey変数、第2引数には、いろんなプロパティを添付つつ
 毎回アンラップを行い、最終的に検索結果　1番目データの緯度経度情報を渡している
 この第二引数を割り出すために、処理している方法がクロージャ
 
 これもdelegate同様、イベントが発生したタイミングで一連の処理を行うことができる。
 Appleから提供されるクラスには、delegateメソッドを利用して処理を実装するものと、
 クロージャとして処理を実行できるものの2種類がある。色々作ってたら覚えるでしょう。
  */



// ViewControllerクラスに UITextFieldDelegate　プロトコル(規約)を追加している
// こうすることで、returnが押された際のdelegate情報はViewControllerクラスに渡される
class ViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //インスタンス化されたUITextFieldのDelegate通知(処理の戻り)先を設定(自分自身)
        //これはViewDidLoadメソッドの中で宣言している。画面の読み込みと同時に宣言するものっぽい
        inputText.delegate = self
        
    }
  
    //UITextFieldクラス(storyboard上のオブジェクト)をinputTextとしてインスタンス化
    //変数宣言の際、型指定と同じ書き方でクラスを代入できるっぽい
    @IBOutlet weak var inputText: UITextField!
    
    //MKMapViewクラス(storyboard上のオブジェクト)をdispMapとしてインスタンス化
    //変数宣言の際、型指定と同じ書き方でクラスを代入できるっぽい
     @IBOutlet weak var dispMap: MKMapView!
    
    //キーボードの検索ボタンをタップすると、delegate機能によって「func textField ShouldReturn(_ textField: UITextField) -> Bool)」メソッドが実行される。
    //これはViewControllerクラスからdelegateによって委任された処理である
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        //キーボードを閉じる(1)　これを入れないと入力完了後もキーボードが表示される
        textField.resignFirstResponder()
        
        //入力された文字を繰り返す(2)
        //引数のtextFieldには画面の検索窓パーツが格納されている
        //.textのプロパティは値がない(検索画面でキーワード入力をしてreturnを
        //押さないと空のまま)場合があるが、if let を使うことで、
        //値がある場合にのみif分岐内で実行、変数searchkeyへ格納され、
        //値があることを保証する。このような処理をアンラップと呼ぶ
               
        if let searchKey = textField.text{
            //入力された文字をデバッグエリアに表示(3)
            print(searchKey)
            
            
            //------------ここまでエラーなし、移行、検索＋緯度経度データ取得時にNullIsland Received エラー発生　でも緯度経度は表示されてる--------------------
          
            //CLGeocoderインスタンスを取得(5)
            let geocoder = CLGeocoder()
            
            //入力された文字から位置情報を取得(6)
            //geocodeAddressStringメソッドは郵便番号やキーワード、住所から位置情報に関する情報を検索して、CLPlacemarkクラス(placemark変数)で格納してくれる。
            //ここではクロージャという機能を使われており、位置情報の結果はクロージャ内に通知される
            //わかりやすく言うと、位置情報が検索できたタイミングで{}内が実行される
            geocoder.geocodeAddressString(searchKey , completionHandler: { (placemarks , error) in
            
                //位置情報が存在する場合は、unwrapPlacemarksに取り出す(7)
                //placemarkは値がない可能性がある変数(オプショナル)なので、アンラップしている
                if let unwrapPlacemarks = placemarks {
                    
                    //unwrapPlacemarksは複数の検索結果を格納する配列　1件目の情報を取り出す(8)
                    //unwrapPlacemarksの値もオプショナル、アンラップしてる
                    if let firstPlacemark = unwrapPlacemarks.first {
                        
                        //firstPlacemarkは色々な情報を持っており、その中で位置情報を取り出す(9)
                        //.first プロパティの値もオプショナルなのでアンラップ
                        if let location = firstPlacemark.location{
                            
                            //位置情報から緯度経度をtargetCoordinateに取り出す(10)
                            let targetCoordinate = location.coordinate
                            
                            //緯度経度をデバッグエリアに表示(11)
                            print(targetCoordinate)
                            
                            //MKPointAnnotationインスタンスを取得し、ピンを作成(12)
                            //MKPointAnnotatinはピンを置くための機能をもったクラス
                            //Annotation = 注釈　の意味
                            let pin = MKPointAnnotation()
                            
                            //ピンの置く場所に緯度経度(さっき検索結果で取得したもの)を設定
                            pin.coordinate = targetCoordinate
                            
                            //ピンのタイトルを設定(14) ピンの下に表示される
                            pin.title = searchKey
                            
                            //ピンを地図に置く(15)
                            self.dispMap.addAnnotation(pin)
                            
                            //緯度経度を中心にして半径500mの範囲を表示）(16)
                            //引数は中心の緯度経度、縦、横の幅(メートル単位)
                            //latitudinal = 北緯、南緯の、longitudinal =　縦方向の　という意味
                            self.dispMap.region = MKCoordinateRegion(center: targetCoordinate, latitudinalMeters: 500.0, longitudinalMeters: 500.0)
                            
                        }
                    }
                }
            })
        }
        
        //デフォルト動作を行うのでTrueを返す(4)
        return true
    }
    
    
    
    
    
    
}

