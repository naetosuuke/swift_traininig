//
//  SettingViewController.swift
//  MyTimer
//
//  Created by Daisuke Doi on 2022/12/01.
//
/*
  for 文の書き方
  
  for 変数　in 開始値...終了値{
  //処理
  }
  
  ※...を..<にすると、終了値を含まずに繰り返し処理を行う。
  for 変数　in 開始値..<終了値{
  //処理
  }
  
  */



import UIKit

//ここで親クラスSettingViewControllerに①UIViewController(画面のクラス), ②UIPickerViewDataSource(選択画面のクラス)、
//③ UIPickerViewDelegate(他クラスへの通知プロトコル) の3つの子クラスを定義　(型みたいな書き方する)


class SettingViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    //UIPickerViewに表示するデータをArrayで作成
    //PickerVIewに表示させるデータをInt型の配列として宣言。
    //いろんな値をいれる、変数、定数、配列、辞書,タプルなどの入れ物をデータ構造と呼ぶ
    //settingArrayは配列として宣言、今回は直接データを指定
    //配列の値を取得するには、添字(index)を利用する。
    
    let settingArray : [Int] = [10,20,30,40,50,60]
    
    //設定値を覚えるキーを設定
    //カウント画面で用いる秒と共通利用する　値が紐づくのでキーは文字型でよい
    //キーそのものは変わらず、紐づいた値が変動するだけなので、定数として宣言してOK
    let settingKey = "timer_value"

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //timerSettingPickerのデリゲートとデータソースの通知先を指定
        //PickerViewを使うために、delegateとdataSourceの通知先を指定する必要がある。
        //今回はSettingViewController自身で通知を受けたいので、self を指定。selfは自分自身のインスタンスを指定する　という意味
        timerSettingPicker.delegate = self
        timerSettingPicker.dataSource = self
        
        //UserDefaultsの取得
        //forKey に　キーを入力することで、UserDefaults.standard 上に保管された秒数を取り出す。初回は10
        let settings = UserDefaults.standard
        let timerValue = settings.integer(forKey:settingKey)
        
        //Pickerの選択を合わせる
        //今回、0 を開始値として指定。settingArray.countで、settingArray配列に入っている値の個数 6 を取得できる。
        //しかし、indexは0から数えられるため、settingArray配列のindexは0,1,2,3,4,5となる。なので　6でなく5までの繰り返し
        for row in 0..<settingArray.count{
            if settingArray[row] == timerValue {
                timerSettingPicker.selectRow(row, inComponent: 0, animated: true)
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
    
    

    @IBOutlet weak var timerSettingPicker: UIPickerView!
    
    
    @IBAction func decisionButtonAction(_ sender: Any) {
        //前画面に戻る
        //ここのアンラップの方法だが、navigationControllerが入っている場合のみpopViewControllerが実行される。
        //詳細はオプショナルチェイニング　と検索するとわかる
        _ = navigationController?.popViewController(animated: true)
        
        
        
    }
    
    //UIPickerViewの列数を設定 (縦)1列なのでreturn 1
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //UIPickerViewの行数を取得 SettingArrayにある秒数の個数あればいい
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) ->Int {
        return settingArray.count
    }
    
    //UiPickerViewの表示する内容を設定
    //DualsourceのPickerViewメソッドの下に追加
    //変数rowが保持しているのは、保存（永続化）している秒数のインデックス　それを添字としてPickerViewから秒数を取得し、
    //画面のPickerViewに秒数のリストを表示させている。
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
    return String(settingArray[row])
    }

    //Picker選択時に実行
    //UserDefaulsのsetValueメソッドを利用して、選択された秒数を保存している。
    //settingKeyに指定されていたキーは、タイマー画面と同様の「"timer_value"」という文字列
    //UserDefaultsに保存されている値は、アプリの中でも共通で利用できるので、
    //画面が違っても同じキーを利用すると値を上書きできる。
    //UserDeafultsはメモリーに値を保持していて、あるタイミングでデータを永続化しているが、永続化されていない
    //タイミングでアプリが落ちるとデータが失われる。
    //synchronizeを利用すると、UserDefaultsはデータを即時に永続化する。
    //これによって、安全にタイマー画面と設定画面で保存された秒数を利用する。
    //永続化→アプリを落としても記憶した情報を覚えている状態。
    
    
    func pickerView(_ pickerVIew: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        //UserDefaultsの設定
        let settings = UserDefaults.standard
        settings.setValue(settingArray[row], forKey: settingKey)
        settings.synchronize()
    }
    
    
}
