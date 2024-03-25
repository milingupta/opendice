//
//  OneDiceVC.swift
//  OpenDice
//
//  Created by Milin Gupta on 7/7/23.
//

import UIKit

class OneDiceVC: UIViewController, DiceVCProtocol {
        
    var rollHistory = RollHistory.shared
    
    let diceImageView = UIImageView()
    
    var portraitWidthConstraint: NSLayoutConstraint?
    var portraitHeightConstraint: NSLayoutConstraint?
    var landscapeWidthConstraint: NSLayoutConstraint?
    var landscapeHeightConstraint: NSLayoutConstraint?
    
    var impactFeedbackGenerator = UIImpactFeedbackGenerator(style: .medium)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        view.addSubview(diceImageView)
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
        diceImageView.translatesAutoresizingMaskIntoConstraints = false
        diceImageView.image = UIImage(named: "dice-1")
        diceImageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        diceImageView.addGestureRecognizer(tapGesture)
        
        view.addSubview(diceImageView)

        portraitWidthConstraint = diceImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/3)
        portraitHeightConstraint = diceImageView.heightAnchor.constraint(equalTo: diceImageView.widthAnchor)
        
        landscapeWidthConstraint = diceImageView.widthAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/3)
        landscapeHeightConstraint = diceImageView.heightAnchor.constraint(equalTo: diceImageView.widthAnchor)
        
        NSLayoutConstraint.activate([
            diceImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            diceImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        handleDeviceOrientation()
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
    
    @objc func handleDeviceOrientation() {
        if view.bounds.width > view.bounds.height { // landscape
            configureLandscapeOrientation()
        } else { // portrait
            configurePortraitOrientation()
        }
    }
    
    func configureLandscapeOrientation() {
        // Deactivate portrait constraints
        portraitWidthConstraint?.isActive = false
        portraitHeightConstraint?.isActive = false
        
        // Activate landscape constraints
        landscapeWidthConstraint?.isActive = true
        landscapeHeightConstraint?.isActive = true
    }
    
    func configurePortraitOrientation() {
        // Deactivate landscape constraints
        landscapeWidthConstraint?.isActive = false
        landscapeHeightConstraint?.isActive = false
        
        // Activate portrait constraints
        portraitWidthConstraint?.isActive = true
        portraitHeightConstraint?.isActive = true
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
}
