//
//  FourHistoryVC.swift
//  SoftDice
//
//  Created by Milin Gupta on 7/11/23.
//

import UIKit

class FourHistoryVC: UITableViewController {

    var rollHistory = RollHistory.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "History"
        tableView.register(FourHistoryCell.self, forCellReuseIdentifier: "cell")
        tableView.rowHeight = 80
        
        let sortButton = UIBarButtonItem(image: UIImage(systemName: "arrow.up.arrow.down"), style: .plain, target: self, action: #selector(sortTapped))
        navigationItem.rightBarButtonItem = sortButton
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rollHistory.fourRollHistory.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FourHistoryCell
        let rollNumber = rollHistory.fourRollHistory[indexPath.row].rollNumber
        let rollValue = rollHistory.fourRollHistory[indexPath.row].rollValue
        cell.textLabel?.text = "Roll \(rollNumber)"
        cell.selectionStyle = .none
        cell.diceImageViews[0].image = UIImage(named: "dice-\(rollValue.0)")
        cell.diceImageViews[1].image = UIImage(named: "dice-\(rollValue.1)")
        cell.diceImageViews[2].image = UIImage(named: "dice-\(rollValue.2)")
        cell.diceImageViews[3].image = UIImage(named: "dice-\(rollValue.3)")
        
        return cell
    }
    
    @objc func sortTapped() {
        rollHistory.reverseFourRollHistory()
        tableView.reloadData()
        
        UIView.transition(with: tableView, duration: 0.35, options: .transitionFlipFromTop, animations: { self.tableView.reloadData() })
    }

}
