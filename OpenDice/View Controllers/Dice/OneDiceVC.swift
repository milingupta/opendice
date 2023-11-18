//
//  OneDiceVC.swift
//  SoftDice
//
//  Created by Milin Gupta on 7/7/23.
//

import UIKit

class OneDiceVC: UIViewController, DiceVCProtocol {
        
    var rollHistory = RollHistory.shared
    
    let diceImageView = UIImageView()
    
    var imageSize: CGFloat = 120
    
    var impactFeedbackGenerator = UIImpactFeedbackGenerator(style: .medium)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        view.addSubview(diceImageView)
        
        configureDiceImageViews()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "History", style: .plain, target: self, action: #selector(showHistory))
        
        impactFeedbackGenerator.prepare()
    }

    func configureDiceImageViews() {
        diceImageView.translatesAutoresizingMaskIntoConstraints = false
        diceImageView.image = UIImage(named: "dice-1")
        diceImageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        diceImageView.addGestureRecognizer(tapGesture)
        diceImageView.widthAnchor.constraint(equalToConstant: imageSize).isActive = true
        diceImageView.heightAnchor.constraint(equalToConstant: imageSize).isActive = true
        
        view.addSubview(diceImageView)

        NSLayoutConstraint.activate([
            diceImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            diceImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func getDiceRoll() -> Int {
        return Int.random(in: 1...6)
    }
    
    func setDiceImage(result: Int) -> UIImage {
        switch result {
        case 1:
            return UIImage(named: "dice-1")!
        case 2:
            return UIImage(named: "dice-2")!
        case 3:
            return UIImage(named: "dice-3")!
        case 4:
            return UIImage(named: "dice-4")!
        case 5:
            return UIImage(named: "dice-5")!
        default:
            return UIImage(named: "dice-6")!
        }
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        // Make sure the tap is coming from the UIImageView
        guard let _ = tapGestureRecognizer.view as? UIImageView else { return }
        if tapGestureRecognizer.state == .ended {
            let result = getDiceRoll()
            
            if rollHistory.isOldestOneFirst {
                rollHistory.appendOneRoll(result)
            } else {
                rollHistory.prependOneRoll(result)
            }
            
            animateImageView(imageView: diceImageView, toImage: setDiceImage(result: result))
        }
        impactFeedbackGenerator.impactOccurred()
    }
    
    func animateImageView(imageView: UIImageView, toImage: UIImage?) {
        UIView.animate(withDuration: 0.2, animations: {
            // Scale up
            imageView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }) { _ in
            UIView.animate(withDuration: 0.2, animations: {
                // Scale down
                imageView.transform = CGAffineTransform.identity
            }) { _ in
                // Change image after the animation
                imageView.image = toImage
            }
        }
    }
    
    @objc func showHistory() {
        let historyVC = OneHistoryVC()
        navigationController?.pushViewController(historyVC, animated: true)
    }
    
}
