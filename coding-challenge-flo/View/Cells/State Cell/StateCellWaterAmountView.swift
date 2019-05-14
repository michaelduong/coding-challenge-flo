//
//  StateCellWaterAmountView.swift
//  coding-challenge-flo
//
//  Created by Michael Duong on 5/12/19.
//  Copyright © 2019 Turnt Labs. All rights reserved.
//

import UIKit

final class StateCellWaterAmountView: UIView {
    
    private let waterImageView = UIImageView()
    let amountLabel = UILabel()
    let nameLabel = UILabel()
    
    let type: OperationCellWaterAmountViewType
    
    enum OperationCellWaterAmountViewType {
        case highlighted
        case normal
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(type: OperationCellWaterAmountViewType) {
        self.type = type
        super.init(frame: .zero)
        
        setupSubviews()
        setupSubviewsHierarchy()
    }
}

// MARK: - Layout
extension StateCellWaterAmountView {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        waterImageView.frame = CGRect(x: 0.0,
                                      y: 0.0,
                                      width: 42.0,
                                      height: 47.0)
        
        amountLabel.sizeToFit()
        amountLabel.frame.origin.y = 18.0
        amountLabel.center.x = waterImageView.center.x
        
        nameLabel.frame = CGRect(x: 0.0,
                                 y: waterImageView.frame.maxY + 2.0,
                                 width: waterImageView.bounds.width,
                                 height: nameLabel.sizeThatFits(.zero).height)
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return CGSize(width: 42.0, height: 47.0 + 2.0 + nameLabel.sizeThatFits(.zero).height)
    }
}

// MARK: - Setup
extension StateCellWaterAmountView {
    private func setupSubviewsHierarchy() {
        self.addSubview(waterImageView)
        self.addSubview(amountLabel)
        self.addSubview(nameLabel)
    }
    
    private func setupSubviews() {
        setupWaterImageView()
        setupAmountLabel()
        setupNameLabel()
    }
    
    private func setupWaterImageView() {
        waterImageView.contentMode = .scaleAspectFit
        
        let color = type == .highlighted
            ? UIColor(hex: "2E3AAB")
            : UIColor(hex: "D2D2D2")
        
        waterImageView.image = waterImage(withColor: color)
    }
    
    private func setupAmountLabel() {
        amountLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        amountLabel.adjustsFontForContentSizeCategory = true
        amountLabel.adjustsFontSizeToFitWidth = true
        amountLabel.numberOfLines = 1
        amountLabel.minimumScaleFactor = 0.1
        amountLabel.textColor = .white
        amountLabel.textAlignment = .center
        amountLabel.text = " "
    }
    
    private func setupNameLabel() {
        nameLabel.font = UIFont(name: Font.Gotham.medium, size: 16.0)
        nameLabel.textAlignment = .center
        nameLabel.text = " "
    }
}

// MARK: - Configuring
extension StateCellWaterAmountView {
    func configure(with jug: Jug) {
        amountLabel.text = String(jug.filledAmount)
        nameLabel.text = jug.identifier
    }
}

// MARK: - Helpers
extension StateCellWaterAmountView {
    private func waterImage(withColor color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 42.0, height: 47.0), false, UIScreen.main.scale)
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 20.89, y: 47))
        path.addCurve(to: CGPoint(x: 4.27, y: 40.33), controlPoint1: CGPoint(x: 14.68, y: 46.83), controlPoint2: CGPoint(x: 8.89, y: 45.03))
        path.addCurve(to: CGPoint(x: 1.7, y: 24.14), controlPoint1: CGPoint(x: -0.35, y: 35.63), controlPoint2: CGPoint(x: -1.25, y: 30))
        path.addCurve(to: CGPoint(x: 13.27, y: 8.12), controlPoint1: CGPoint(x: 4.72, y: 18.21), controlPoint2: CGPoint(x: 8.93, y: 13.11))
        path.addCurve(to: CGPoint(x: 20.26, y: 0.48), controlPoint1: CGPoint(x: 15.54, y: 5.52), controlPoint2: CGPoint(x: 17.95, y: 3.04))
        path.addCurve(to: CGPoint(x: 21.82, y: 0.48), controlPoint1: CGPoint(x: 20.85, y: -0.17), controlPoint2: CGPoint(x: 21.22, y: -0.15))
        path.addCurve(to: CGPoint(x: 38.42, y: 20.71), controlPoint1: CGPoint(x: 27.86, y: 6.81), controlPoint2: CGPoint(x: 33.69, y: 13.31))
        path.addCurve(to: CGPoint(x: 40.09, y: 23.61), controlPoint1: CGPoint(x: 39.03, y: 21.65), controlPoint2: CGPoint(x: 39.57, y: 22.62))
        path.addCurve(to: CGPoint(x: 36.24, y: 41.8), controlPoint1: CGPoint(x: 43.61, y: 30.41), controlPoint2: CGPoint(x: 42.23, y: 36.96))
        path.addCurve(to: CGPoint(x: 20.89, y: 47), controlPoint1: CGPoint(x: 31.83, y: 45.38), controlPoint2: CGPoint(x: 26.71, y: 46.85))
        path.close()
        path.miterLimit = 4;
        
        color.setFill()
        path.fill()
        
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        
        UIGraphicsEndImageContext()
        
        return image
    }
}
