//
//  FiveHistoryCell.swift
//  SoftDice
//
//  Created by Milin Gupta on 7/11/23.
//

import UIKit

class FiveHistoryCell: UITableViewCell, HistoryCellProtocol {

    let diceImageView1 = UIImageView()
    let diceImageView2 = UIImageView()
    let diceImageView3 = UIImageView()
    let diceImageView4 = UIImageView()
    let diceImageView5 = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupImageViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupImageViews() {
        // add the image views to the cell's content view
        contentView.addSubview(diceImageView1)
        contentView.addSubview(diceImageView2)
        contentView.addSubview(diceImageView3)
        contentView.addSubview(diceImageView4)
        contentView.addSubview(diceImageView5)
        
        // turn off autoresizing masks
        diceImageView1.translatesAutoresizingMaskIntoConstraints = false
        diceImageView2.translatesAutoresizingMaskIntoConstraints = false
        diceImageView3.translatesAutoresizingMaskIntoConstraints = false
        diceImageView4.translatesAutoresizingMaskIntoConstraints = false
        diceImageView5.translatesAutoresizingMaskIntoConstraints = false
        
        // constrain the image views
        let imageViews = [diceImageView1, diceImageView2, diceImageView3, diceImageView4, diceImageView5]
        imageViews.forEach { imageView in
            NSLayoutConstraint.activate([
                imageView.widthAnchor.constraint(equalToConstant: 50),
                imageView.heightAnchor.constraint(equalToConstant: 50),
                imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            ])
        }
        
        NSLayoutConstraint.activate([
            diceImageView1.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            diceImageView2.trailingAnchor.constraint(equalTo: diceImageView1.leadingAnchor, constant: -10),
            diceImageView3.trailingAnchor.constraint(equalTo: diceImageView2.leadingAnchor, constant: -10),
            diceImageView4.trailingAnchor.constraint(equalTo: diceImageView3.leadingAnchor, constant: -10),
            diceImageView5.trailingAnchor.constraint(equalTo: diceImageView4.leadingAnchor, constant: -10)
        ])
    }
    
}
