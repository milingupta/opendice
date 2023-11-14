//
//  ThreeHistoryVC.swift
//  SoftDice
//
//  Created by Milin Gupta on 7/11/23.
//

import UIKit

class ThreeHistoryVC: UITableViewController {

    var rollHistory = RollHistory.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "History"
        tableView.register(ThreeHistoryCell.self, forCellReuseIdentifier: "cell")
        tableView.rowHeight = 80
        
        let sortButton = UIBarButtonItem(image: UIImage(systemName: "arrow.up.arrow.down"), style: .plain, target: self, action: #selector(sortTapped))
        navigationItem.rightBarButtonItem = sortButton
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rollHistory.threeRollHistory.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ThreeHistoryCell
        let rollNumber = rollHistory.threeRollHistory[indexPath.row].rollNumber
        let rollValue = rollHistory.threeRollHistory[indexPath.row].rollValue
        cell.textLabel?.text = "Roll \(rollNumber)"
        cell.selectionStyle = .none
        cell.diceImageView1.image = UIImage(named: "dice-\(rollValue.0)")
        cell.diceImageView2.image = UIImage(named: "dice-\(rollValue.1)")
        cell.diceImageView3.image = UIImage(named: "dice-\(rollValue.2)")
        
        return cell
    }

    @objc func sortTapped() {
        rollHistory.reverseThreeRollHistory()
        tableView.reloadData()
        
        UIView.transition(with: tableView, duration: 0.35, options: .transitionFlipFromTop, animations: { self.tableView.reloadData() })
    }
}
