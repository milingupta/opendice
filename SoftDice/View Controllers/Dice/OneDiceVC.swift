//
//  OneDiceVC.swift
//  SoftDice
//
//  Created by Milin Gupta on 7/7/23.
//

import UIKit

class OneDiceVC: UIViewController {
    
    var rollHistory = RollHistory.shared
    let diceImageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureDiceImageView()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "History", style: .plain, target: self, action: #selector(showHistory))
    }

    func configureDiceImageView() {
        view.addSubview(diceImageView)
        diceImageView.translatesAutoresizingMaskIntoConstraints = false
        
        diceImageView.isUserInteractionEnabled = true
        diceImageView.image = UIImage(named: "dice-1")
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        diceImageView.addGestureRecognizer(tapGesture)
        
        NSLayoutConstraint.activate([
            diceImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            diceImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            diceImageView.widthAnchor.constraint(equalToConstant: 120),
            diceImageView.heightAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    func getDiceRoll() -> Int {
        return Int.random(in: 1...6)
    }
    
    func setDiceImage() {
        let result = getDiceRoll()
        switch result {
        case 1:
            diceImageView.image = UIImage(named: "dice-1")
        case 2:
            diceImageView.image = UIImage(named: "dice-2")
        case 3:
            diceImageView.image = UIImage(named: "dice-3")
        case 4:
            diceImageView.image = UIImage(named: "dice-4")
        case 5:
            diceImageView.image = UIImage(named: "dice-5")
        default:
            diceImageView.image = UIImage(named: "dice-6")
        }
        
        if rollHistory.isOldestOneFirst {
            rollHistory.appendOneRoll(result)
        } else {
            rollHistory.prependOneRoll(result)
        }
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        // Make sure the tap is coming from the UIImageView
        guard let tappedImageView = tapGestureRecognizer.view as? UIImageView else { return }
        if tapGestureRecognizer.state == .ended {
            UIView.animate(withDuration: 0.2, animations: {
                // Scale up
                tappedImageView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            }) { _ in
                UIView.animate(withDuration: 0.2, animations: {
                    // Scale down
                    tappedImageView.transform = CGAffineTransform.identity
                }) { _ in
                    // Change image after the animation
                    self.setDiceImage()
                }
            }
        }
    }
    
    @objc func showHistory() {
        let historyVC = OneHistoryVC()
        navigationController?.pushViewController(historyVC, animated: true)
    }
    
}

