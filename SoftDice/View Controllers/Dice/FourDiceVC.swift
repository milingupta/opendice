//
//  FourDiceVC.swift
//  SoftDice
//
//  Created by Milin Gupta on 7/11/23.
//

import UIKit

class FourDiceVC: UIViewController, DiceVCProtocol {
        
    var rollHistory = RollHistory.shared
    
    let diceStackView = UIStackView()
    let diceStackView1 = UIStackView()
    let diceStackView2 = UIStackView()
    
    let diceImageView1 = UIImageView()
    let diceImageView2 = UIImageView()
    let diceImageView3 = UIImageView()
    let diceImageView4 = UIImageView()
    
    var diceImageViews: [UIImageView] = []
    
    var imageSize: CGFloat = 120
    
    var impactFeedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        view.addSubview(diceStackView)
        diceStackView.addArrangedSubview(diceStackView1)
        diceStackView.addArrangedSubview(diceStackView2)
        
        diceStackView1.addArrangedSubview(diceImageView1)
        diceStackView1.addArrangedSubview(diceImageView2)
        
        diceStackView2.addArrangedSubview(diceImageView3)
        diceStackView2.addArrangedSubview(diceImageView4)
        
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
        diceImageViews = [diceImageView1, diceImageView2, diceImageView3, diceImageView4]
        
        diceImageViews.forEach { diceImageView in
            diceImageView.translatesAutoresizingMaskIntoConstraints = false
            diceImageView.image = UIImage(named: "dice-1")
            diceImageView.isUserInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
            diceImageView.addGestureRecognizer(tapGesture)
            diceImageView.widthAnchor.constraint(equalToConstant: imageSize).isActive = true
            diceImageView.heightAnchor.constraint(equalToConstant: imageSize).isActive = true
        }
        
        diceStackView.axis = .vertical
        diceStackView.distribution = .equalSpacing
        diceStackView.spacing = 50
        diceStackView.translatesAutoresizingMaskIntoConstraints = false
        
        diceStackView1.axis = .horizontal
        diceStackView1.distribution = .fillEqually
        diceStackView1.spacing = 50
        diceStackView1.translatesAutoresizingMaskIntoConstraints = false
        
        diceStackView2.axis = .horizontal
        diceStackView2.distribution = .fillEqually
        diceStackView2.spacing = 50
        diceStackView2.translatesAutoresizingMaskIntoConstraints = false
        
        diceStackView.addArrangedSubview(diceStackView1)
        diceStackView.addArrangedSubview(diceStackView2)
        
        diceStackView1.addArrangedSubview(diceImageView1)
        diceStackView1.addArrangedSubview(diceImageView2)
        
        diceStackView2.addArrangedSubview(diceImageView3)
        diceStackView2.addArrangedSubview(diceImageView4)
        
        view.addSubview(diceStackView)

        NSLayoutConstraint.activate([
            diceStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            diceStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
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
            var results: [Int] = []
            
            for _ in 0..<4 {
                results.append(getDiceRoll())
            }
            
            if rollHistory.isOldestFourFirst {
                rollHistory.appendFourRolls((results[0], results[1], results[2], results[3]))
            } else {
                rollHistory.prependFourRolls((results[0], results[1], results[2], results[3]))
            }
            
            for i in 0..<4 {
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
        let historyVC = FourHistoryVC()
        navigationController?.pushViewController(historyVC, animated: true)
    }
    
    @objc func handleDeviceOrientation() {
        if view.bounds.width > view.bounds.height { // landscape
            configureLandscapeOrientation()
        } else { // portrait
            configurePortraitOrientation()
        }
    }
    
    func configureLandscapeOrientation() {
        // Remove existing constraints to avoid conflicts
        diceStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        // Configure for landscape orientation
        diceStackView.axis = .horizontal
        diceStackView.alignment = .center
        diceStackView.distribution = .fillEqually
        
        // Setup subviews for landscape orientation
        diceStackView1.axis = .horizontal
        diceStackView1.distribution = .fillEqually
        diceStackView1.spacing = 50
        
        diceStackView2.axis = .horizontal
        diceStackView2.distribution = .fillEqually
        diceStackView2.spacing = 50
        
        diceStackView.addArrangedSubview(diceStackView1)
        diceStackView.addArrangedSubview(diceStackView2)
        
        diceStackView1.addArrangedSubview(diceImageView1)
        diceStackView1.addArrangedSubview(diceImageView2)
        
        diceStackView2.addArrangedSubview(diceImageView3)
        diceStackView2.addArrangedSubview(diceImageView4)
        
        NSLayoutConstraint.activate([
            diceStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            diceStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func configurePortraitOrientation() {
        // Remove existing constraints to avoid conflicts
        diceStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        // Configure for portrait orientation
        diceStackView.axis = .vertical
        diceStackView.alignment = .center
        diceStackView.distribution = .fillEqually
        
        // Setup subviews for portrait orientation
        diceStackView1.axis = .horizontal
        diceStackView1.distribution = .fillEqually
        diceStackView1.spacing = 50
        
        diceStackView2.axis = .horizontal
        diceStackView2.distribution = .fillEqually
        diceStackView2.spacing = 50
        
        diceStackView.addArrangedSubview(diceStackView1)
        diceStackView.addArrangedSubview(diceStackView2)
        
        diceStackView1.addArrangedSubview(diceImageView1)
        diceStackView1.addArrangedSubview(diceImageView2)
        
        diceStackView2.addArrangedSubview(diceImageView3)
        diceStackView2.addArrangedSubview(diceImageView4)
        
        NSLayoutConstraint.activate([
            diceStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            diceStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
}
