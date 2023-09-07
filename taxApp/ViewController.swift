//
//  ViewController.swift
//  taxApp
//
//  Created by 小野寺良太 on 2023/09/06.
//

import UIKit

class ViewController: UITableViewController {
    //UI要素の紐付け
    @IBOutlet weak var priceTextField: UITextField!
    
    @IBOutlet weak var taxSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var taxResultLabel: UILabel!
    
    // 税込価格と税率
    var prices: [(price: Double, taxRate: Double)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "PriceCell")
    }
    
    // 原価が変更された時の動作指示
    @IBAction func priceChanged(_ sender: UITextField) {
        updateTaxIncludedPrice()
    }
    
    // 税率が変更された時の動作指示
    @IBAction func taxRateChanged(_ sender: UISegmentedControl) {
        updateTaxIncludedPrice()
    }
    
    // 追加ボタンが押された時の動作指示
    @IBAction func addButtonTapped(_ sender: UIButton) {
        if let price = Double(taxResultLabel.text?.replacingOccurrences(of: "¥", with: "") ?? "") {
            
            if price == 0.0 {
                return
            }
            
            let taxRate = taxSegmentedControl.selectedSegmentIndex == 0 ? 0.10 : 0.08
            prices.append((price: price, taxRate: taxRate))
            self.tableView.reloadData()
        }
    }
    
    // 画面推移の前にデータを渡す指示
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("Destination ViewController: \(segue.destination)")
        if let totalVC = segue.destination as? TotalViewController {
            totalVC.totalAmount = prices.reduce(0) { $0 + $1.price }
            print("Total Amount in prepare: \(totalVC.totalAmount)")  
        }
    }
    
    // 税込価格を計算してラベルに表示する
    func updateTaxIncludedPrice() {
        if let price = Double(priceTextField.text ?? "") {
            let taxRate = taxSegmentedControl.selectedSegmentIndex == 0 ? 0.10 : 0.08
            let taxIncludedPrice = price * (1 + taxRate)
            taxResultLabel.text = "¥" + String(format: "%.2f", taxIncludedPrice)
        } else {
            taxResultLabel.text = "¥0.00"
        }
    }
    
    // テーブルビューの行数を返す
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return prices.count
    }
    
    // 各行の内容を設定
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PriceCell", for: indexPath)
        let priceInfo = prices[indexPath.row]
        cell.textLabel?.text = "¥\(priceInfo.price) (\(priceInfo.taxRate * 100)%)"
        return cell
    }
    
    
}

