//
//  ChatListViewController.swift
//  ChatAppWithFirebase
//
//  Created by Daisuke Doi on 2022/12/08.
//

import UIKit

//画面に対するクラス
class ChatListViewController: UIViewController{
    
    private let cellId = "cellId"
    
    @IBOutlet weak var chatListTableView: UITableView!
    
    //起動時の宣言　通知周り
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chatListTableView.delegate = self
        chatListTableView.dataSource = self
        
        //navigation barの各種内容を修正
        //バグって動かないので差し替え
        //ref.https://developer.apple.com/forums/thread/122100
        //navigationController?.navigationBar.barTintColor = .blue
        navigationController?.navigationBar.backgroundColor = .rgb(red: 39, green: 49, blue: 69)
        navigationItem.title = "トーク"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
    }
    
}
    
//MARK: - UITableViewDelegate, UITableViewDataSource
extension ChatListViewController: UITableViewDelegate, UITableViewDataSource{
    
    //セルの高さを規定
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) ->CGFloat {
        return 80
    }
    
    //テーブル内セルの数を規定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    //上の回数分　繰り返し使うセル(cellIdってIdentifierもってるやつ)のインスタンス生成
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = chatListTableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath )
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print ("tapped table view") // セル押下確認
        let storyboard = UIStoryboard.init(name: "ChatRoom", bundle: nil) //UIStoryboardクラスをインスタンス生成 名前で呼び出し
        let chatRoomViewController = storyboard.instantiateViewController(withIdentifier: "ChatRoomViewController")  //遷移先のViewController情報を取得
        navigationController?.pushViewController(chatRoomViewController, animated: true) //画面遷移する　NavigationBarでも次の画面扱いになり、戻るボタンとかがついてくる

    }
    
    
}
                                        
//セルの中身クラス
class ChatListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var latestMessageLabel: UILabel!
    @IBOutlet weak var partnerLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib() //何かわからん
        userImageView.layer.cornerRadius = 35 //アイコンを丸くしてる
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
        
        
 
 
}
