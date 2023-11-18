//
//  OneHistoryCell.swift
//  OpenDice
//
//  Created by Milin Gupta on 7/7/23.
//

import UIKit

class OneHistoryCell: UITableViewCell, HistoryCellProtocol {

    let diceImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupImageViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupImageViews() {
        contentView.addSubview(diceImageView)
        
        diceImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            diceImageView.widthAnchor.constraint(equalToConstant: 50),
            diceImageView.heightAnchor.constraint(equalToConstant: 50),
            diceImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            diceImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
    }
    
}
