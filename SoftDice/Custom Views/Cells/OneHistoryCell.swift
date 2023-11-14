//
//  OneHistoryCell.swift
//  SoftDice
//
//  Created by Milin Gupta on 7/7/23.
//

import UIKit

class OneHistoryCell: UITableViewCell {

    let diceImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupImageViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupImageViews() {
        // add the image views to the cell's content view
        contentView.addSubview(diceImageView)
        
        // turn off autoresizing masks
        diceImageView.translatesAutoresizingMaskIntoConstraints = false
        
        // constrain the image views
        NSLayoutConstraint.activate([
            diceImageView.widthAnchor.constraint(equalToConstant: 50),
            diceImageView.heightAnchor.constraint(equalToConstant: 50),
            diceImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            diceImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
    }
}
