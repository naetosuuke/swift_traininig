//
//  ViewController.swift
//  MyCamera
//
//  Created by Daisuke Doi on 2022/12/03.
//



/*
 モーダルビュー
 present を実行すると、新しい画面がオーバーラップするように画面遷移する。これをモーダルビューと呼ぶ。
 
 present(hoge, animater:true, completion: nil)
 第一引数 hoge どの画面を表示させるかを指定。このプログラムだとインスタンス化させたimagePickerControllerを指定
 第二引数 animated:true 表示するときアニメーションをするかしないか
 第三引数 completion:nil モーダルビューの表示が完了した後で、追加で処理を行いたい場合に指示。なければnil
 
 UIActivityViewController 
 第一引数　シェアするコンテンツの配列を指定　第二引数　iOS標準として搭載されていないサービスを拡張する場合に指定。今回は拡張しないのでnilを指定
 */

import UIKit

// Delegateの宣言
class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBOutlet weak var pictureImage: UIImageView!
    
    @IBAction func cameraButtonAction(_ sender: Any) {
        //カメラが利用可能かチェック　UIImagePickerControllerはカメラ撮影、写真の選択する機能が提供されているクラス。
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            print("カメラは利用できます")
            //(1)UIImagePickerControllerのインスタンスを作成
            let imagePickerController = UIImagePickerController()
            //(2)sourceTypeにcameraを追加
            imagePickerController.sourceType = .camera
            //(3)delegateを選択(self = ViewControllerクラス)
            imagePickerController.delegate = self
            //(4)モーダルビューで表示
            present(imagePickerController, animated: true, completion: nil)
        } else {
            print("カメラは利用できません")
        }
    }

    @IBAction func shareButtonAction(_ sender: Any) {
        //表示画像をアンラップしてシェア画像を取り出す pictureImageは起動したときは空　if letでバインディングしてる
        if let shareImage = pictureImage.image{
            //UIActivityViewControllerに渡す配列を作成
            let shareItems = [shareImage]
            //UIActivityViewControllerにシェア画像を渡す　controllerにインスタンス化しながら、対象物を引数で指定
            //第一引数　シェアするコンテンツの配列を指定　第二引数　iOS標準として搭載されていないサービスを拡張する場合に指定。今回は拡張しないのでnilを指定
            let controller = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
            //iPadで落ちてしまう対策　iPadでUIActivityViewControllerをインスタンス化すると、特定の場所から吹き出しのように表示されるUIになる。
            //この場合、吹き出し元になる場所を指定する必要がある。今回はViewController自体を指定
            controller.popoverPresentationController?.sourceView = view
            //UIActivityViewContollerをモーダルビューで表示
            present(controller, animated: true, completion: nil)
        }
    }
    
    //(1)撮影が終わったときに呼ばれるDelegateメソッド
    //delegateメソッドのメソッド名はあらかじめ決められていて、UIImagePickerControllerで撮影が終わった後や写真が選択されたときに通知されるのがimagePickerControllerメソッド
    //第一引数　カメラ撮影を行う画面をpickerとして格納　第二引数　撮影した写真の情報を格納。didFinishPickingMediaWithInfoはラベル名
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        
        //(2)撮影した画像を配置したpictureImageに渡す　infoには、撮影した写真の情報が格納されている。Infokey.originalImageキーを指定すれば、カメラで撮影した写真を取得できる。
        //info[UIImagePickerController.InfoKey.originalImage](撮った写真)は,型がAny（いろいろなデータを格納できる。） pictureImage.image(インスタンス化したUIImageView)はUIImage型
        //Swiftだと代入するデータ型を揃える必要はあり、揃えることを型変換（キャスト）と呼ぶ。
        //最後のas? UIimageは、Any型をUIImage型へ変換する文法。
        pictureImage.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        //(3)モーダルビューを閉じる presentと対になっている
        dismiss(animated: true, completion: nil)
    }
}

