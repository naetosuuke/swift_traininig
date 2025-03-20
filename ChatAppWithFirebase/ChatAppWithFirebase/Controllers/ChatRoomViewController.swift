//
//  ChatRoomViewController.swift
//  ChatAppWithFirebase
//
//  Created by Daisuke Doi on 2022/12/09.
//

import UIKit

class ChatRoomViewController: UIViewController{
    
    
    
    @IBOutlet weak var chatRoomTableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chatRoomTableView.backgroundColor = .green
        
    }
    
    
    
    
}
