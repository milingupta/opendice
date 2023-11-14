//
//  OneHistoryVC.swift
//  SoftDice
//
//  Created by Milin Gupta on 7/7/23.
//

import UIKit

class OneHistoryVC: UITableViewController {

    var rollHistory = RollHistory.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "History"
        tableView.register(OneHistoryCell.self, forCellReuseIdentifier: "cell")
        tableView.rowHeight = 80
        
        let sortButton = UIBarButtonItem(image: UIImage(systemName: "arrow.up.arrow.down"), style: .plain, target: self, action: #selector(sortTapped))
        navigationItem.rightBarButtonItem = sortButton
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rollHistory.oneRollHistory.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! OneHistoryCell
        let rollNumber = rollHistory.oneRollHistory[indexPath.row].rollNumber
        let rollValue = rollHistory.oneRollHistory[indexPath.row].rollValue
        cell.textLabel?.text = "Roll \(rollNumber)"
        cell.selectionStyle = .none
        cell.diceImageView.image = UIImage(named: "dice-\(rollValue)")

        return cell
    }
    
    @objc func sortTapped() {
        rollHistory.reverseOneRollHistory()
        tableView.reloadData()
        
        UIView.transition(with: tableView, duration: 0.35, options: .transitionFlipFromTop, animations: { self.tableView.reloadData() })
    }

}
