//
//  ViewController.swift
//  ViewComeFromUnder
//
//

import UIKit

class ViewController: UIViewController , UIPickerViewDelegate, UIPickerViewDataSource {
    
    // このNSLayoutConstraintをプロパティにいれるのがポイント
    // 今回はstoryboardで、pikerviewがviewからどこの位置に配置されるかを設定する（topからの高さのcontraintsが設定できればどこでもよい）
    // 配置後、プロパティをこのViewControllerに紐づける
    // storyboard>contraints>picker View Layoutを参考に
    @IBOutlet weak var pickerViewLayout: NSLayoutConstraint!
    
    // コードではなく最初からUIPickerViewをstoryboard上に配置しておく
    @IBOutlet weak var pickerView: UIPickerView!
    
    // 配列
    var array = ["楽天", "ソニー", "APPLE", "amazon", "softbank"]
    
    // 今選択されているもじれつ
    var nowCode : String!
    
    // pickerViewが表示されているかどうか判定
    var showView :Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 背景をタップしたらdismissKeyboardメソッドを呼ぶように設定する
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)
        
        self.pickerView.delegate   = self
        self.pickerView.dataSource = self
        
        // 可読性あげるためにselfいれてるけど別にあってもなくても。クラス変数だということがわかりやすいのでいれてあげると他の人もコードが読みやすい
        self.nowCode = ""
        self.showView = false
        
        // pickerViewを画面外に配置しておく
        self.pickerViewLayout.constant = +self.view.frame.height ;
    }

    @IBAction func addButton(_ sender: Any) {
        // 右上のナビバーぼたん押したもの
        NSLog("ナビバーおした")
        
        // 初期値とpickerviewを押したときにはfalseになる
        if !self.showView {
            // constantの値は適当に
            self.pickerViewLayout.constant = 200+self.pickerView.frame.height;
            self.showView = true
            
            // アニメーションの設定。この処理を削ると下からスッとでてこない
            UIView.animate(withDuration: 0.3, animations: { () -> Void in
                
                // レイアウト更新の時にアニメーションをかける、といういみ。対象はこれだけではなく
                // 普通のviewとかも指定できる
                self.view.layoutIfNeeded()
            })
        }
    }
    
    @objc func dismissKeyboard(){
        // キーボードを閉じる
        view.endEditing(true)
        
        // 下から出てきたviewも見えている状態だったらviewも下に下げる
        if self.showView {
            self.pickerViewLayout.constant = +self.view.frame.height ;
            self.showView = false
            
            // アニメーションの設定
            UIView.animate(withDuration: 0.5, animations: { () -> Void in
                self.view.layoutIfNeeded()
            })
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.array[row]
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.array.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // 現在選択されている文字列
        self.nowCode = self.array[row]
    }
}

