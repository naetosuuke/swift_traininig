import UIKit

var greeting = "Hello, playground"
print (greeting)

//---型---

let constant: Int //変数の宣言
var variable: String

let a: Int = 123 //型アノテーション (注釈)
let b = 123 //型推論

type(of: a) // 実行結果として、変数、定数のTypeを記載する。

//---スコープ---

let c = 1 //グローバルスコープ, その関数にも型宣言にも含まれないスコープ
func someFunction() {
    let c = 2 //ローカルスコープ 関数や制御構文によって定義されるスコープ
    print("local c:", c) //異なるスコープに同一の名前が存在する場合、名前を参照するスコープから最も近い祖先のスコープにあるものが優先される。
}

someFunction() // この場合は c = 2
print("global c:", c) //  この場合は c = 1

//---式---
/*式には3種類ある。

 値の返却のみを行う式
 演算を行う式
 処理を呼び出す式

*/

//変数や定数の値を返却する式
let d = 1 // 1
let e = d + 1 // 2 ←これが該当

//リテラル式
let f = 1 //型推論　Int型
let g = "abc" //型推論　String型
//※配列、辞書、nilなど、デフォルトの方を持たないリテラルもある。

//メンバー式
/*型のメンバーとは、型の値や方自信に紐つく変数、定数、関数型などのこと。
 あたいに火もつく変数や定数をプロパティといい、型に紐つく関数をメソッドと呼ぶ
 式.メンバー式
 */

let h =  "Hello World!"
h.count // String型についてるプロパティ 文字数を値として持つ
h.starts(with: "Hello") //型についてるメソッド　引数から始まるかをboolで判定

//クロージャ式
/*クロージャとは、処理をまとめて呼び出し可能にしたもの。
 クロージャの入力値を引数といい、出力値を戻り値という。
 クロージャ式はクロージャを定義する式で、主に処理を足跡的に定義して他の処理に渡す際に使う。
 式の値は、定義したクロージャとなる。
 
 色々な書き方があるが、代表的なのは下記のもの。
 {引数 in 戻り値を返す式}
 */

let original = [1, 2, 3]
let doubled = original.map( {value in value * 2} ) //map関数を使い、配列の中身すべてにクロージャ内式を行い、配列の値を上書きしている。。
doubled // [2, 4, 6]

//演算を行う式
/*演算を行い、結果の値を返す式。演算子は、配置位置によって3つに区分される
 前置演算子: -a
 中間演算子: a + b
 後置演算子 a!
 */

// 算術演算子
let i = 9 * 2

let int = 27
let double = 0.3
// int * double //←型が違うと算術演算子は使えない。
Double(int) * double //型変換して揃えると可能

// 符号演算子
let j = 7
-j // -7

// 否定演算子
let k = false
!k // true boolを反転させる。

//処理を呼び出す式
/*関数を呼び出す式
 関数とは、処理をまとめて呼び出し可能にしたもの。入力値を引数といい、出力値を戻り値という。
 関数の呼び出しは式であり、式が返す値は関数の戻り値。
 関数名(引数名1:引数1, 引数名2:引数2 ...) 引数には名前をつけることができる。
*/

max(2,7) // 7, 引数のうち一番大きいものを返す関数

/*イニシャライザ
 イニシャライザは、型のインスタンス生成をするための処理をまとめたもの。
 型の実体化
 型名(引数名1:引数1, 引数名2:引数2 ...)
*/
    
String(4) // String型のイニシャライザにInt型 4を渡すと、String型の"4"が式の値として返される。


