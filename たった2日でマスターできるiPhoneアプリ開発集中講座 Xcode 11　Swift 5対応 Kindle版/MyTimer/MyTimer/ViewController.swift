//
//  ViewController.swift
//  MyTimer
//
//  Created by Daisuke Doi on 2022/11/30.
//



/*
 Tips メソッドの書き方
 
 func hogeHoge(_ huga:Int hogo:Str) -> Bool {
  return =
 }
 
 hogeHoge が メソッド名
 _　が　ラベル、設定しない場合は"_"とかく　ラベルによって引数を保管できる？
 huga が 第一引数　:Int が第一引数の型指定
 hogo　が　第二引数　:Str が第二引数の型指定
 -> Bool が　戻り値の型宣言　この肩の通りの戻り値がこないとエラーおこす
 return = で代入される値が戻り値になる

  
 */



import UIKit

class ViewController: UIViewController {
    
    //タイマーの変数を作成 Timer型の　Timerという変数を作成　: は型指定する時の符号
    //Timerクラスを利用すると、指定した時間に何らかの処理を実行したり、定期的に繰り返し処理を行なったりすることができる。
    //?をつけているのは、「オプショナル型」つまり、Timerクラスから呼び出した値が空でもエラーをださずに進めて良い
    //(代わりにnilという戻り値を渡す)、という型指定をしている。
    //既に型を宣言済み, 型推論で割当炭の定数/関数についても、名前の後ろに?をつけるとnilを受け入れるようになる。こちらは アンラップ処理と呼ぶ
    //なお、?でオプショナル型指定をした場合、演算処理を行うことができない(Int型でなくオプショナル型だから,型推論もしてくれない)
    //?でオプショナル型にした値を演算に使いたい場合、その定数/変数に!をつければ演算可能になる。
    //なお、値が空でもエラーで強制停止せず、別の処理に逃したいときは"if let 任意の定数名　= 対象の定数/変数 {}　"でアンラップすることもできる
    //(対象の定数、変数に値がある場合は、{}内の任意の処理を行い、戻り値を任意の定数名に保管することで、値があることを保証することができる。)
    //逆に、定数、変数がからの場合は、{}内の処理は行われないし、戻り値も定数名に保管されないので、そこで値があったかなかったかを判断できる
    
    var timer : Timer?
    //カウントの変数を作成 変数の宣言時に値をセットすることを初期化といい、今回は0が初期値となる。　セットしてない場合の変数の値はNil?
    var count = 0
    //設定値を扱うキーを設定 今回だと設定した秒数を保持する際に利用する。
    let settingKey = "timer_value"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //viewDidLoadは、このViewControllerが呼び出されるときに1度だけ実行される。
        //UserDefaultsには、アプリで利用する値を保存できる。
        //アプリを停止して、再度起動させたときに、UserDefaultsを使用して保存していた値を利用する。
        //データを保存して復元できるようにすることを「データの永続化」と呼び、キー(settingKey)と
        //記録したい値（秒数）を指定することで、そのキーを使って自由に値を取り出したり、書き換えたりすることができる。
        
        
        //UserDefaultsのインスタンスを生成
        //UserDefaultをインスタンス化する場合は、常にこの方法で行う。
        //関数内でインスタンス化したクラスは、関数が終わると消える？だから他の関数で使う場合、毎回インスタンス化する必要があるかも
        let settings = UserDefaults.standard
        
        //UserDefaultsに初期値を登録
        //registerメソッドに、キーと値[settingKey:10]を引数として渡すことで、初期値の登録を行なっている。
        //settingに、先に生成したsettingKeyと、初期値として10を配列として登録する。
        //defaultラベルを指定して登録(配列に名前つけてる)することで、初回にプログラムが実行されたとき値(10)が登録される。
        settings.register(defaults:[settingKey:10])
        
    }
    
    
    @IBOutlet weak var countDownLabel: UILabel!
    
    @IBAction func settingButtonAction(_ sender: Any) {
        //timerをアンラップしてnowTimerに代入 時間できたらリファクタリングでクラス化し、ストップボタンと兼用にする
        if let nowTimer = timer {
        //もしタイマーが、実行中だったら停止
            if nowTimer.isValid == true {
                //タイマー停止
                nowTimer.invalidate()
            }
        }
        //画面遷移を行う
        //performSegueメソッドを利用して、Segueで関連づけた画面に遷移する。
        //withIdentifier:"goSetting"は、storyboardの操作でSegueオブジェクトを追加し、
        //Attribute inspecter内で設定した識別子のことで、これでオブジェクトとの紐付けをしてる
        //ちなみにAttribute inspectorは直訳すると属性の調査
        //sender:nil のsenderは、画面遷移時にデータを渡すときに設定する。
        //今回　特にわたすものがないのでnil(空)としている
        performSegue(withIdentifier: "goSetting", sender: nil)
        
    }
    
    
    @IBAction func startButtonAction(_ sender: Any) {
        
        //timerをアンラップしてnowTimerに代入
        //if let を利用して、timerをアンラップすることで、timerに値がある場合のみ、
        //nowTimer.isValidでタイマーが実行中かどうかを調べている。
        //空の値,イニシャライズされていない変数(=nil)を許容したオプショナル型を非オプショナル型として取り出す、つまりにnilを許容しないようにする
        //こうした処理をアンラップと呼ぶ　(逆にオプショナル型へ帰るときはラップとよぶ)
        //変数に!をつける(例　timer!)と強制的にアンラップさせられるが、変数がnilだとエラーでとまるという仕組み
        //nilの場合は分岐処理で逃がせる　というやり方がif let
        if let nowTimer = timer{
            
            //もしタイマーが実行中だったらスタートしない　という分岐
            if nowTimer.isValid == true {
                //実行中だったら何も処理しない、つまり
                return
            }
        }
        
        //タイマーをスタート(Timerクラスをインスタンス化、引数を渡す)
        //scheduledTimerメソッドは、一定間隔で処理を実行する。このメソッドでは、5つの引数を渡している
        //第一引数 "ti" タイマーを実行させる間隔を設定。単位はsec。0,0001秒まで指定できる
        //第二引数 "target"タイマー実行時の呼び出し先を指定。今回はtimerInterrepuptメソッドを呼び出すが、
        //同じクラス(Timer)中にあるメソッドなのでselfを設定
        //第三引数 タイマー実行時に呼び出すメソッドを指定。今回は selector:#selector(self.timerInterrupt(_:)) と書いて
        //timerInterruptメソッドを指定
        //第四引数 3つ目の引数で設定したメソッドに渡す情報を指定。今回は何もないのでnilを指定
        //第五引数 繰り返しを指定。true(繰り返し)かfalse(一回)か指定。今回は繰り返し実行するのでtrueを指定
        //ちなみに、メソッドに入れる引数をどうすればよいか考える際はoption + クリックでメソッドを押すと一覧が表示される
        
        timer = Timer.scheduledTimer(timeInterval:1.0,
                                     target: self,
                                     selector: #selector(self.timerInterrupt(_:)),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    
    @IBAction func stopButtonAction(_ sender: Any) {
        //timerをアンラップしてnowtimerに代入
        //if let文でtimer(インスタンス化したTimerクラス)をアンラップし、
        //値があればnowTimerに代入し、Timerクラスのinvalidateメソッドを実行して、タイマーを停止する。
        //値がなければ、何の処理も行われない(ifの制御に引っかからない)
        if let nowTimer = timer {
            //もし　タイマーが実行中だったら停止
            if nowTimer.isValid == true{
                //タイマー停止
                nowTimer.invalidate()
            }
        }
    }
    
    
    //画面の更新をする(戻り値 : remainCount:残り時間)
    //displayUpdateメソッド　()なので引数なし、 -> Intで戻り値はInt型データ
    func displayUpdate() -> Int {
        
        //UserDefaults のインスタンスを生成 初期値は10
        //viewDidLoad内のインスタンスは消失しているので、また生成する
        let settings = UserDefaults.standard
        
        //取得した秒数をtimeValueに渡す
        //settingKeyは、「timer_value」という文字列をキーとして保持している。先ほどUserDefaultsの
        //インスタンスとして作成したsettingsに、settingKey変数を渡すことで、データを取得している。
        //このコードで、viewDidLoadで保存した、settingsがsettingKeyというキーに紐づけて保持する値10 を、
        //timerValueにセットしている。この際、forKeyというラベルをつけている。
        //登録されたデータを、変数settingKeyに保持されている文字列「timer_value」で取得している。
        //取得した値を、integerメソッドを利用して整数としてtimerValue変数に代入している。
        let timerValue = settings.integer(forKey: settingKey)
        
        //残り時間(remainCount)を生成
        //残り時間は、設定したタイマーの時間(timerValue)から経過した時間(count)を引いた値
        //countコードは別で書く
        let remainCount = timerValue - count
        
        //remainCount(残り時間)をラベルに表示
        //文字リテラルの中に定数、変数を埋め込むときは\()と指定する。エスケープシーケンス？
        countDownLabel.text = "残り\(remainCount)秒"
        
        //残り時間を戻り値に設定
        return remainCount
    }
    
    
    
    //経過時間の処理
    //timerInterruptは、Timerクラスから利用される。Timerからこのメソッドを呼ぶコードは、後ほど書く。
    //引数に「_ timer:Timer」記述されているが、「_」には本来ラベル名を指定するところ、省略しているという意味。
    //_timer:Timerは、「ラベル変数名:クラス名」を意味している。
    //"@objc"はタイマーのスタート処理。scheduledTimerメソッドの引数 #selector で指定するときに必要な記述。
    //TimerクラスはObjective-Cで書かれているため、Objective-CからSwift4のクラスを利用する場合は"@objc"を
    //明示的に記述する。
    @objc func timerInterrupt(_ timer:Timer){
        
        //count(経過時間)に＋1していく
        count += 1
        
        //remainCount(残り時間)が0以下の時、タイマーを止める
        //displayUpdateの戻り値がremainCount（残り時間）なので、
        //displayUpdate()を実行することで残り時間を取得できる。
         if displayUpdate() <= 0 {
            //初期化処理 経過時間分のタイマーの数値を初期化する
            count = 0
            //タイマー停止
            timer.invalidate()
             
            //カスタマイズ編　ダイアログを作成
            //各引数　title message preferredStyle　のうち、prefferedStyleはAlert(ポップアップ)か
            //ActionSheet(下からスライドして表示されるダイアログ)を選択する。
            let alertController = UIAlertController(title: "終了", message: "タイマー終了時間です", preferredStyle: .alert)
            //ダイアログに表示させるOKボタンを作成
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            //アクションを追加 インスタンス化したdefaultActionをalertControllerに渡す
            alertController.addAction(defaultAction)
            //ダイアログの表示　presentが表示する　というメソッド
            present(alertController, animated: true, completion: nil)
             
        }
    }

    //画面切り替えのタイミングで処理を行う
    override func viewDidAppear(_ animated: Bool) {
        //カウント(経過時間)をゼロにする
        //設定画面から戻ったとき、経過時間を初期化しておかないと、
        //この後実行するタイマーの表示の更新時、表示される秒数がおかしくなる。
        count = 0

        //タイマーの表示を更新する
        //displayUpdateを実行することで、秒数設定画面で設定された秒数で、画面を更新する。
        //displayUpdateの実行により、画面を更新する必要があるが、戻り値(remainCount)は使い道がないので
        //_に代入する（=捨てる）。※適当につかいもしない変数を作成し、代入すると警告が出る
        //戻り値が発生する関数をつかいたい、でも戻り値はいらいないときは_をつかえばよい
        _ = displayUpdate()
        
    }
}




