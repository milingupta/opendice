//
//  FourHistoryCell.swift
//  SoftDice
//
//  Created by Milin Gupta on 7/11/23.
//

import UIKit

class FourHistoryCell: UITableViewCell, HistoryCellProtocol {

    let diceImageViews = (0..<4).map { _ in UIImageView() }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupImageViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupImageViews() {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(stackView)
        
        for imageView in diceImageViews {
            imageView.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview(imageView)
        }
        
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ] + diceImageViews.flatMap { [
            $0.widthAnchor.constraint(equalToConstant: 50),
            $0.heightAnchor.constraint(equalToConstant: 50)
        ]})
    }
    
}
