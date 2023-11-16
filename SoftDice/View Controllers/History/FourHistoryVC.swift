//
//  FourHistoryVC.swift
//  SoftDice
//
//  Created by Milin Gupta on 7/11/23.
//

import UIKit

class FourHistoryVC: UITableViewController {

    var rollHistory = RollHistory.shared
    
    private let placeholderView = UIView()
    private let placeholderLabel = UILabel()
    private let placeholderImageView = UIImageView()
    
    private lazy var sortButton: UIBarButtonItem = {
        return UIBarButtonItem(image: UIImage(systemName: "arrow.up.arrow.down"), style: .plain, target: self, action: #selector(sortTapped))
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "History"
        tableView.register(FourHistoryCell.self, forCellReuseIdentifier: "cell")
        tableView.rowHeight = 80
        
        configurePlaceholderView()
        updatePlaceholderVisibility()
        
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
        UIView.transition(with: tableView, duration: 0.35, options: .transitionCrossDissolve, animations: { self.tableView.reloadData() })
    }

    private func configurePlaceholderView() {
        placeholderView.translatesAutoresizingMaskIntoConstraints = false
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        placeholderImageView.translatesAutoresizingMaskIntoConstraints = false
        
        placeholderLabel.text = "No rolls"
        placeholderLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        placeholderLabel.textColor = .placeholderText
        
        let imageSize: CGFloat = 80
        
        placeholderImageView.image = UIImage(systemName: "dice.fill")
        placeholderImageView.tintColor = .placeholderText
        placeholderImageView.contentMode = .scaleAspectFit
        
        placeholderView.addSubview(placeholderImageView)
        placeholderView.addSubview(placeholderLabel)
        
        view.addSubview(placeholderView)
        
        // Calculate a shift value that visually centers the placeholder
        let shiftUpwards: CGFloat = 100 // Adjust this value as needed
        
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
    
    private func updatePlaceholderVisibility() {
        let rollCount = rollHistory.fourRollHistory.count

        // Show placeholder view only when there are no rolls
        placeholderView.isHidden = rollCount > 0

        // Enable sort button only when there are two or more rolls
        sortButton.isEnabled = rollCount >= 2

        // Enable or disable scrolling based on the presence of rolls
        tableView.isScrollEnabled = rollCount > 0
    }

}
