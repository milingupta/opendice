//
//  FiveDiceVC.swift
//  SoftDice
//
//  Created by Milin Gupta on 7/11/23.
//

import UIKit

class FiveDiceVC: UIViewController {

    var rollHistory = RollHistory.shared
    
    let diceStackView = UIStackView()
    let diceStackView1 = UIStackView()
    let diceStackView2 = UIStackView()
    
    let diceImageView1 = UIImageView()
    let diceImageView2 = UIImageView()
    let diceImageView3 = UIImageView()
    let diceImageView4 = UIImageView()
    let diceImageView5 = UIImageView()
    
    var diceImageViews: [UIImageView] = []
    
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
        diceImageViews = [diceImageView1, diceImageView2, diceImageView3, diceImageView4, diceImageView5] // Store all dice image views in an array

        diceImageViews.forEach { diceImageView in
            diceImageView.translatesAutoresizingMaskIntoConstraints = false
            diceImageView.image = UIImage(named: "dice-1")
            diceImageView.isUserInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
            diceImageView.addGestureRecognizer(tapGesture)
            diceImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
            diceImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        }

        diceStackView1.distribution = .equalSpacing
        diceStackView1.axis = .vertical
        diceStackView1.spacing = 100
        diceStackView1.translatesAutoresizingMaskIntoConstraints = false
        diceStackView1.addArrangedSubview(diceImageView1)
        diceStackView1.addArrangedSubview(diceImageView2)

        diceStackView2.distribution = .equalSpacing
        diceStackView2.axis = .vertical
        diceStackView2.spacing = 100
        diceStackView2.translatesAutoresizingMaskIntoConstraints = false
        diceStackView2.addArrangedSubview(diceImageView4)
        diceStackView2.addArrangedSubview(diceImageView5)

        view.addSubview(diceStackView1)
        view.addSubview(diceImageView3)
        view.addSubview(diceStackView2)
        
        NSLayoutConstraint.activate([
            diceStackView1.trailingAnchor.constraint(equalTo: diceImageView3.leadingAnchor, constant: -30),
            diceStackView1.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            diceImageView3.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            diceImageView3.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            diceStackView2.leadingAnchor.constraint(equalTo: diceImageView3.trailingAnchor, constant: 30),
            diceStackView2.centerYAnchor.constraint(equalTo: view.centerYAnchor)
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
            var results = [Int]()
            
            for _ in 0..<5 {
                results.append(rollDice())
            }
            
            if rollHistory.isOldestFiveFirst {
                rollHistory.appendFiveRolls((results[0], results[1], results[2], results[3], results[4]))
            } else {
                rollHistory.prependFiveRolls((results[0], results[1], results[2], results[3], results[4]))
            }
            
            for i in 0..<5 {
                animateImageView(imageView: diceImageViews[i], toImage: setDiceImage(result: results[i]))
            }
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
        let historyVC = FiveHistoryVC()
        navigationController?.pushViewController(historyVC, animated: true)
    }
    
    @objc func handleDeviceOrientation() {
        if view.bounds.width > view.bounds.height { // landscape
            diceStackView.axis = .horizontal
            diceStackView.distribution = .equalSpacing
            diceStackView.alignment = .center
        } else { // portrait
            diceStackView.axis = .vertical
            diceStackView.distribution = .fillEqually
            diceStackView.alignment = .fill
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
}
