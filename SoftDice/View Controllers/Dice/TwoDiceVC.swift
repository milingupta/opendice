//
//  TwoDiceVC.swift
//  SoftDice
//
//  Created by Milin Gupta on 7/7/23.
//

import UIKit

class TwoDiceVC: UIViewController {

    var rollHistory = RollHistory.shared
    
    let diceStackView = UIStackView()
    
    let diceImageView1 = UIImageView()
    let diceImageView2 = UIImageView()
    
    let impactFeedbackGenerator = UIImpactFeedbackGenerator(style: .medium)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureDiceImageViews()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "History", style: .plain, target: self, action: #selector(showHistory))
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleDeviceOrientation), name: UIDevice.orientationDidChangeNotification, object: nil)
        
        impactFeedbackGenerator.prepare()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        handleDeviceOrientation()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        handleDeviceOrientation()
    }
    
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        handleDeviceOrientation()
    }

    func configureDiceImageViews() {
        diceStackView.distribution = .equalSpacing
        diceStackView.spacing = 50
        diceStackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(diceStackView)
        
        diceStackView.addArrangedSubview(diceImageView1)
        diceStackView.addArrangedSubview(diceImageView2)
        
        diceImageView1.translatesAutoresizingMaskIntoConstraints = false
        diceImageView2.translatesAutoresizingMaskIntoConstraints = false
        
        diceImageView1.isUserInteractionEnabled = true
        diceImageView1.image = UIImage(named: "dice-1")
        let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        diceImageView1.addGestureRecognizer(tapGesture1)
        
        diceImageView2.isUserInteractionEnabled = true
        diceImageView2.image = UIImage(named: "dice-1")
        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        diceImageView2.addGestureRecognizer(tapGesture2)
        
        NSLayoutConstraint.activate([
            diceStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            diceStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            diceImageView1.widthAnchor.constraint(equalToConstant: 120),
            diceImageView1.heightAnchor.constraint(equalToConstant: 120),
            diceImageView2.widthAnchor.constraint(equalToConstant: 120),
            diceImageView2.heightAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    func rollDice() -> Int {
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
            let result1 = rollDice()
            let result2 = rollDice()
            
            if rollHistory.isOldestTwoFirst {
                rollHistory.appendTwoRolls((result1, result2))
            } else {
                rollHistory.prependTwoRolls((result1, result2))
            }
            
            animateImageView(imageView: diceImageView1, toImage: setDiceImage(result: result1))
            animateImageView(imageView: diceImageView2, toImage: setDiceImage(result: result2))
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
        let historyVC = TwoHistoryVC()
        navigationController?.pushViewController(historyVC, animated: true)
    }
    
    @objc func handleDeviceOrientation() {
        if view.bounds.width > view.bounds.height {
            diceStackView.axis = .horizontal
        } else {
            diceStackView.axis = .vertical
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIDevice.orientationDidChangeNotification, object: nil)
    }

}
