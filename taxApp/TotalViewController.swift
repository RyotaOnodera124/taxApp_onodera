//
//  TotalViewController.swift
//  taxApp
//
//  Created by 小野寺良太 on 2023/09/06.
//

import UIKit

class TotalViewController: UITableViewController {
    
    // UI要素の紐付け
    @IBOutlet weak var totalLabel: UILabel!
    
    // 合計金額を保存する変数
    var totalAmount: Double = 0.0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        totalLabel.text = "¥" + String(format: "%.2f", totalAmount)
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


