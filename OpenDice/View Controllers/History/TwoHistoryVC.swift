//
//  TwoHistoryVC.swift
//  OpenDice
//
//  Created by Milin Gupta on 7/7/23.
//

import UIKit
import Toast

class TwoHistoryVC: UITableViewController, HistoryVCProtocol {

    var rollHistory = RollHistory.shared
    
    let placeholderView = UIView()
    let placeholderLabel = UILabel()
    let placeholderImageView = UIImageView()
    
    lazy var sortButton: UIBarButtonItem = {
        return UIBarButtonItem(image: UIImage(systemName: "arrow.up.arrow.down"), style: .plain, target: self, action: #selector(sortTapped))
    }()
    
    lazy var clearButton: UIBarButtonItem = {
        return UIBarButtonItem(image: UIImage(systemName: "clear"), style: .plain, target: self, action: #selector(clearTapped))
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "History"
        tableView.register(TwoHistoryCell.self, forCellReuseIdentifier: "cell")
        tableView.rowHeight = 80
        
        configurePlaceholderView()
        updatePlaceholderVisibility()
        
        navigationItem.rightBarButtonItems = [sortButton, clearButton]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rollHistory.twoRollHistory.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TwoHistoryCell
        let rollNumber = rollHistory.twoRollHistory[indexPath.row].rollNumber
        let rollValue = rollHistory.twoRollHistory[indexPath.row].rollValue
        cell.textLabel?.text = "Roll \(rollNumber)"
        cell.selectionStyle = .none
        cell.diceImageView1.image = UIImage(named: "dice-\(rollValue.0)")
        cell.diceImageView2.image = UIImage(named: "dice-\(rollValue.1)")
        
        return cell
    }

    @objc func sortTapped() {
        rollHistory.reverseTwoRollHistory()
        showSortOrderToast()
        UIView.transition(with: tableView, duration: 0.35, options: .transitionCrossDissolve, animations: { self.tableView.reloadData() })
    }
    
    @objc func clearTapped() {
        let alertController = UIAlertController(title: "Clear History", message: "Are you sure you want to clear the roll history for rolling 2 dice?", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { _ in
            self.rollHistory.clearTwoRollHistory()
            UIView.transition(with: self.tableView, duration: 0.35, options: .transitionCrossDissolve, animations: { self.tableView.reloadData() })
            self.updatePlaceholderVisibility()
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func configurePlaceholderView() {
        placeholderView.translatesAutoresizingMaskIntoConstraints = false
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        placeholderImageView.translatesAutoresizingMaskIntoConstraints = false
        
        placeholderLabel.text = "No Rolls"
        placeholderLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        placeholderLabel.textColor = .placeholderText
        
        let imageSize: CGFloat = 100
        
        placeholderImageView.image = UIImage(systemName: "dice.fill")
        placeholderImageView.tintColor = .placeholderText
        placeholderImageView.contentMode = .scaleAspectFit
        
        placeholderView.addSubview(placeholderImageView)
        placeholderView.addSubview(placeholderLabel)
        
        view.addSubview(placeholderView)
        
        // Shift value that visually centers the placeholder
        let shiftUpwards: CGFloat = 100
        
        NSLayoutConstraint.activate([
            placeholderView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            placeholderView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -shiftUpwards),
            placeholderImageView.centerXAnchor.constraint(equalTo: placeholderView.centerXAnchor),
            placeholderImageView.centerYAnchor.constraint(equalTo: placeholderView.centerYAnchor),
            placeholderImageView.widthAnchor.constraint(equalToConstant: imageSize),
            placeholderImageView.heightAnchor.constraint(equalToConstant: imageSize),
            placeholderLabel.topAnchor.constraint(equalTo: placeholderImageView.bottomAnchor, constant: 12),
            placeholderLabel.centerXAnchor.constraint(equalTo: placeholderView.centerXAnchor)
        ])
    }
    
    func updatePlaceholderVisibility() {
        let rollCount = rollHistory.twoRollHistory.count

        // Show placeholder view only when there are no rolls
        placeholderView.isHidden = rollCount > 0

        // Enable sort button only when there are two or more rolls
        sortButton.isEnabled = rollCount >= 2

        // Enable clear button only when there are one or more rolls
        clearButton.isEnabled = rollCount > 0
        
        // Enable or disable scrolling based on the presence of rolls
        tableView.isScrollEnabled = rollCount > 0
    }
    
    func showSortOrderToast() {
        let ascendingToast = Toast.default(image: UIImage(systemName: "arrow.down.circle.fill")!, title: "Oldest First", config: ToastConfiguration(direction: .top, dismissBy: [.time(time: 1.0), .swipe(direction: .natural)], animationTime: 0.25))
        let descendingToast = Toast.default(image: UIImage(systemName: "arrow.up.circle.fill")!, title: "Newest First", config: ToastConfiguration(direction: .top, dismissBy: [.time(time: 1.0), .swipe(direction: .natural)], animationTime: 0.25))
        
        let toast = rollHistory.isOldestTwoFirst ? ascendingToast : descendingToast
        toast.show()
    }
    
}
