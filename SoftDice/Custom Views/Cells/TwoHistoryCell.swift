//
//  TwoHistoryCell.swift
//  SoftDice
//
//  Created by Milin Gupta on 7/7/23.
//

import UIKit

class TwoHistoryCell: UITableViewCell, HistoryCellProtocol {

    let diceImageView1 = UIImageView()
    let diceImageView2 = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupImageViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupImageViews() {
        contentView.addSubview(diceImageView1)
        contentView.addSubview(diceImageView2)
        
        diceImageView1.translatesAutoresizingMaskIntoConstraints = false
        diceImageView2.translatesAutoresizingMaskIntoConstraints = false
        
        let imageViews = [diceImageView1, diceImageView2]
        imageViews.forEach { imageView in
            NSLayoutConstraint.activate([
                imageView.widthAnchor.constraint(equalToConstant: 50),
                imageView.heightAnchor.constraint(equalToConstant: 50),
                imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            ])
        }
        
        NSLayoutConstraint.activate([
            diceImageView1.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            diceImageView2.trailingAnchor.constraint(equalTo: diceImageView1.leadingAnchor, constant: -10)
        ])
    }
    
}
