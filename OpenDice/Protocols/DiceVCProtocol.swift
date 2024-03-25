//
//  DiceVCProtocol.swift
//  OpenDice
//
//  Created by Milin Gupta on 11/16/23.
//

import UIKit

@objc protocol DiceVCProtocol {
    var rollHistory: RollHistory { get }
    var impactFeedbackGenerator: UIImpactFeedbackGenerator { get }
    func configureDiceImageViews()
    func getDiceRoll() -> Int
    func setDiceImage(result: Int) -> UIImage
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    func animateImageView(imageView: UIImageView, toImage: UIImage?)
    @objc func handleDeviceOrientation()
    func configureLandscapeOrientation()
    func configurePortraitOrientation()
    @objc func showHistory()
}
