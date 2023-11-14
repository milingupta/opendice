//
//  TwoHistoryCell.swift
//  SoftDice
//
//  Created by Milin Gupta on 7/7/23.
//

import UIKit

class TwoHistoryCell: UITableViewCell {

    let diceImageView1 = UIImageView()
    let diceImageView2 = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupImageViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupImageViews() {
        // add the image views to the cell's content view
        contentView.addSubview(diceImageView1)
        contentView.addSubview(diceImageView2)
        
        // turn off autoresizing masks
        diceImageView1.translatesAutoresizingMaskIntoConstraints = false
        diceImageView2.translatesAutoresizingMaskIntoConstraints = false
        
        // constrain the image views
        NSLayoutConstraint.activate([
            diceImageView1.widthAnchor.constraint(equalToConstant: 50),
            diceImageView1.heightAnchor.constraint(equalToConstant: 50),
            diceImageView1.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            diceImageView1.trailingAnchor.constraint(equalTo: diceImageView2.trailingAnchor, constant: -60),
            
            diceImageView2.widthAnchor.constraint(equalToConstant: 50),
            diceImageView2.heightAnchor.constraint(equalToConstant: 50),
            diceImageView2.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            diceImageView2.leadingAnchor.constraint(equalTo: diceImageView1.trailingAnchor, constant: 10),
            diceImageView2.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
    }
}
