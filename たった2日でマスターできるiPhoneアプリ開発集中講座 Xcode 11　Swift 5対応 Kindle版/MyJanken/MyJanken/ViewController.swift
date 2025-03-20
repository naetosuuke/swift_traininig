//
//  ViewController.swift
//  MyJanken
//
//  Created by Daisuke Doi on 2022/11/24.
//  This code is quoted from "たった2日でマスターできるiPhoneアプリ開発集中講座 Xcode 11　Swift 5対応 Kindle版" for my personal training. Not for distribution  https://www.amazon.co.jp/%E3%81%9F%E3%81%A3%E3%81%9F2%E6%97%A5%E3%81%A7%E3%83%9E%E3%82%B9%E3%82%BF%E3%83%BC%E3%81%A7%E3%81%8D%E3%82%8BiPhone%E3%82%A2%E3%83%97%E3%83%AA%E9%96%8B%E7%99%BA%E9%9B%86%E4%B8%AD%E8%AC%9B%E5%BA%A7-Xcode-11-Swift-5%E5%AF%BE%E5%BF%9C-%E8%97%A4%E6%B2%BB%E4%BB%81-ebook/dp/B081FG9J2V/ref=sr_1_3?keywords=%E3%81%9F%E3%81%A3%E3%81%9F2%E6%97%A5%E3%81%A7%E3%83%9E%E3%82%B9%E3%82%BF%E3%83%BC%E3%81%A7%E3%81%8D%E3%82%8Biphone%E3%82%A2%E3%83%97%E3%83%AA%E9%96%8B%E7%99%BA%E9%9B%86%E4%B8%AD%E8%AC%9B%E5%BA%A7&qid=1669637309&qu=eyJxc2MiOiIyLjYwIiwicXNhIjoiMi4xOCIsInFzcCI6IjIuMTIifQ%3D%3D&sprefix=%E3%81%9F%E3%81%A3%E3%81%9F2%E6%97%A5%2Caps%2C184&sr=8-3

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBOutlet weak var answerImageView: UIImageView!
    
    @IBOutlet weak var answerLabel: UILabel!
    
    //じゃんけん（数字）
    var answerNumber = 0
    
    @IBAction func shuffleAction(_ sender: Any) {
       
        
        //新しいジャンケンの結果を一時的に格納する変数を設ける
        var newAnswerNumber = 0
        
        
        //　ランダムに結果を出すが、前回の結果と異なる場合のみ採用
        // repeatは繰り返しを意味する
        repeat {
            
            // 0,1,2の数値をランダムに算出(乱数)
            newAnswerNumber = Int.random(in: 0..<3)
            
            //前回と同じ結果の時は、再度ランダムに数値を出す
            //異なる結果の時は、repeatを抜ける
        } while answerNumber == newAnswerNumber
            
       //新しいジャンケンの検索結果を格納
        answerNumber = newAnswerNumber
        
                    
        if answerNumber == 0 {
            
            //グー
            answerLabel.text = "グー"
            answerImageView.image = UIImage(named:"gu")
            
        } else if answerNumber == 1 {
            
            
            //チョキ
            answerLabel.text = "チョキ"
            answerImageView.image = UIImage(named:"choki")
            
        } else if answerNumber == 2 {
            
            //パー
            answerLabel.text = "パー"
            answerImageView.image = UIImage(named:"pa")
            
        }
        //次のジャンケンへ 変数ランダム化に際して不使用になった
        //answerNumber += 1
    
        
    }
}

