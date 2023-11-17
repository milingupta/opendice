//
//  ThreeHistoryCell.swift
//  SoftDice
//
//  Created by Milin Gupta on 7/11/23.
//

import UIKit

class ThreeHistoryCell: UITableViewCell, HistoryCellProtocol {

    let diceImageView1 = UIImageView()
    let diceImageView2 = UIImageView()
    let diceImageView3 = UIImageView()

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
        contentView.addSubview(diceImageView3)

        diceImageView1.translatesAutoresizingMaskIntoConstraints = false
        diceImageView2.translatesAutoresizingMaskIntoConstraints = false
        diceImageView3.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            diceImageView1.widthAnchor.constraint(equalToConstant: 50),
            diceImageView1.heightAnchor.constraint(equalToConstant: 50),
            diceImageView1.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            diceImageView1.trailingAnchor.constraint(equalTo: diceImageView2.leadingAnchor, constant: -10),

            diceImageView2.widthAnchor.constraint(equalToConstant: 50),
            diceImageView2.heightAnchor.constraint(equalToConstant: 50),
            diceImageView2.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            diceImageView2.trailingAnchor.constraint(equalTo: diceImageView3.leadingAnchor, constant: -10),
            
            diceImageView3.widthAnchor.constraint(equalToConstant: 50),
            diceImageView3.heightAnchor.constraint(equalToConstant: 50),
            diceImageView3.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            diceImageView3.leadingAnchor.constraint(equalTo: diceImageView2.trailingAnchor, constant: 10),
            diceImageView3.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
    }
    
}
