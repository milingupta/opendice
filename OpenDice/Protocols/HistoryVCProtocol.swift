//
//  HistoryVCProtocol.swift
//  OpenDice
//
//  Created by Milin Gupta on 11/16/23.
//

import UIKit

@objc protocol HistoryVCProtocol {
    var rollHistory: RollHistory { get }
    @objc func sortTapped()
    @objc func clearTapped()
    func configurePlaceholderView()
    func updatePlaceholderVisibility()
    func showSortOrderToast()
}
