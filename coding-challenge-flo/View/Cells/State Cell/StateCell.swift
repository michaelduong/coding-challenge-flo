//
//  StateCell.swift
//  coding-challenge-flo
//
//  Created by Michael Duong on 5/12/19.
//  Copyright © 2019 Turnt Labs. All rights reserved.
//

import UIKit

final class StateCell: UITableViewCell {
    
    let operationNameLabel = UILabel()
    let xWaterAmountView = StateCellWaterAmountView(type: .highlighted)
    let yWaterAmountView = StateCellWaterAmountView(type: .highlighted)
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        self.setupSubviews()
        self.setupSubviewsHierarchy()
    }
}

// MARK: - Layout
extension StateCell {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let horizontalPadding: CGFloat = 24.0
        
        xWaterAmountView.sizeToFit()
        xWaterAmountView.frame.origin.x = horizontalPadding
        xWaterAmountView.center.y = self.contentView.center.y
        
        yWaterAmountView.sizeToFit()
        yWaterAmountView.frame.origin.x = self.contentView.bounds.width - horizontalPadding - yWaterAmountView.bounds.width
        yWaterAmountView.center.y = self.contentView.center.y
        
        let operationNameLabelSpacing: CGFloat = 10.0
        let operationNameLabelWidth = self.contentView.bounds.width - xWaterAmountView.frame.maxX - (self.contentView.bounds.width - yWaterAmountView.frame.minX) - (2 * operationNameLabelSpacing)
        
        operationNameLabel.frame.size.width = operationNameLabelWidth
        operationNameLabel.frame.size.height = operationNameLabel.sizeThatFits(CGSize(width: operationNameLabelWidth, height: .greatestFiniteMagnitude)).height
        operationNameLabel.center = self.contentView.center
    }
}

// MARK: - Setup
extension StateCell {
    private func setupSubviewsHierarchy() {
        self.contentView.addSubview(operationNameLabel)
        self.contentView.addSubview(xWaterAmountView)
        self.contentView.addSubview(yWaterAmountView)
    }
    
    private func setupSubviews() {
        setupOperationNameLabel()
        setupXWaterAmountView()
        setupYWaterAmountView()
    }
    
    private func setupOperationNameLabel() {
        operationNameLabel.font = UIFont(name: Font.Gotham.medium, size: 24.0)
        operationNameLabel.textAlignment = .center
        operationNameLabel.text = " "
        operationNameLabel.numberOfLines = 0
    }
    
    private func setupXWaterAmountView() {
        xWaterAmountView.amountLabel.text = "5"
        xWaterAmountView.nameLabel.text = "X"
    }
    
    private func setupYWaterAmountView() {
        yWaterAmountView.amountLabel.text = "0"
        yWaterAmountView.nameLabel.text = "Y"
    }
}

// MARK: - Configuring
extension StateCell {
    func configure(with state: State) {
        operationNameLabel.text = state.operation.name
        
        waterAmountView(for: state.xJug).configure(with: state.xJug)
        waterAmountView(for: state.yJug).configure(with: state.yJug)
    }
}

// MARK: - Helpers
extension StateCell {
    func waterAmountView(for jug: Jug) -> StateCellWaterAmountView {
        return jug.identifier == xJugIdentifier ? xWaterAmountView : yWaterAmountView
    }
    
    class var identifier: String {
        return "OperationCell"
    }
}
