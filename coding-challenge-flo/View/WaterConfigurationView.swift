//
//  WaterConfigurationView.swift
//  coding-challenge-flo
//
//  Created by Michael Duong on 5/12/19.
//  Copyright © 2019 Turnt Labs. All rights reserved.
//

import UIKit
import fluid_slider

protocol WaterConfigurationViewDelegate: class {
    func didTouchCalculateButton(in waterConfigurationView: WaterConfigurationView) -> Void
}

final class WaterConfigurationView: UIView {
    private let titleLabel = UILabel()
    private let xSliderHeaderLabel = UILabel()
    private let ySliderHeaderLabel = UILabel()
    private let zSliderHeaderLabel = UILabel()
    private let xSlider = Slider()
    private let ySlider = Slider()
    private let zSlider = Slider()
    private let calculateButton = UIButton(type: .system)
    private let selectionFeedback = UISelectionFeedbackGenerator()
    private let impactFeedback = UIImpactFeedbackGenerator()
    
    weak var delegate: WaterConfigurationViewDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setupSelf()
        setupSubviews()
        setupSubviewsHierachy()
    }
}

// MARK: - Layout
extension WaterConfigurationView {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let backgroundPath = UIBezierPath(roundedRect: self.bounds,
                                          byRoundingCorners: [.topLeft, .topRight],
                                          cornerRadii: CGSize(width: 25.0, height: 25.0))
        
        let backgroundMask = CAShapeLayer()
        backgroundMask.path = backgroundPath.cgPath
        self.layer.mask = backgroundMask
        
        let horizontalPadding: CGFloat = 16.0
        let contentWidth = self.bounds.width - horizontalPadding * 2
        
        titleLabel.frame = CGRect(x: horizontalPadding,
                                  y: 16.0,
                                  width: contentWidth,
                                  height: titleLabel.sizeThatFits(.zero).height)
        
        xSliderHeaderLabel.frame = CGRect(x: horizontalPadding,
                                          y: titleLabel.frame.maxY + 20.0,
                                          width: contentWidth,
                                          height: xSliderHeaderLabel.sizeThatFits(.zero).height)
        
        xSlider.frame = CGRect(x: horizontalPadding,
                               y: xSliderHeaderLabel.frame.maxY + 1.0,
                               width: contentWidth,
                               height: 42.0)
        
        ySliderHeaderLabel.frame = CGRect(x: horizontalPadding,
                                          y: xSlider.frame.maxY + 16.0,
                                          width: contentWidth,
                                          height: ySliderHeaderLabel.sizeThatFits(.zero).height)
        
        ySlider.frame = CGRect(x: horizontalPadding,
                               y: ySliderHeaderLabel.frame.maxY + 1.0,
                               width: contentWidth,
                               height: 42.0)
        
        zSliderHeaderLabel.frame = CGRect(x: horizontalPadding,
                                          y: ySlider.frame.maxY + 16.0,
                                          width: contentWidth,
                                          height: zSliderHeaderLabel.sizeThatFits(.zero).height)
        
        zSlider.frame = CGRect(x: horizontalPadding,
                               y: zSliderHeaderLabel.frame.maxY + 1.0,
                               width: contentWidth,
                               height: 42.0)
        
        calculateButton.frame = CGRect(x: horizontalPadding,
                                       y: zSlider.frame.maxY + 24.0,
                                       width: contentWidth,
                                       height: 56.0)
        
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        self.layoutIfNeeded()
        
        return CGSize(width: size.width,
                      height: calculateButton.frame.maxY + 34.0)
    }
}

// MARK: - Setup
extension WaterConfigurationView {
    private func setupSelf() {
        self.backgroundColor = .white
        selectionFeedback.prepare()
        impactFeedback.prepare()
    }
    
    private func setupSubviewsHierachy() {
        self.addSubview(titleLabel)
        self.addSubview(xSliderHeaderLabel)
        self.addSubview(ySliderHeaderLabel)
        self.addSubview(zSliderHeaderLabel)
        self.addSubview(xSlider)
        self.addSubview(ySlider)
        self.addSubview(zSlider)
        self.addSubview(calculateButton)
    }
    
    private func setupSubviews() {
        setupTitleLabel()
        setupXSliderHeaderLabel()
        setupYSliderHeaderLabel()
        setupZSliderHeaderLabel()
        setupXSlider()
        setupYSlider()
        setupZSlider()
        setupCalculateButton()
    }
    
    private func setupTitleLabel() {
        titleLabel.font = UIFont(name: Font.Gotham.bold, size: 20.0)
        titleLabel.text = "Water Jug Config"
        titleLabel.textAlignment = .center
    }
    
    private func setupXSliderHeaderLabel() {
        setupSliderHeaderLabel(xSliderHeaderLabel, withText: "Water Jug #1 (X):")
    }
    
    private func setupYSliderHeaderLabel() {
        setupSliderHeaderLabel(ySliderHeaderLabel, withText: "Water Jug #2 (Y):")
    }
    
    private func setupZSliderHeaderLabel() {
        setupSliderHeaderLabel(zSliderHeaderLabel, withText: "Desired Water Amount (Z):")
    }
    
    private func setupSliderHeaderLabel(_ sliderHeaderLabel: UILabel, withText text: String) {
        sliderHeaderLabel.font = UIFont(name: Font.Gotham.medium, size: 16.0)
        sliderHeaderLabel.text = text
    }
    
    private func setupXSlider() {
        setupSlider(xSlider, withBackgroundColor: UIColor(hex: "3B44B7"))
    }
    
    private func setupYSlider() {
        setupSlider(ySlider, withBackgroundColor: UIColor(hex: "5A5CDA"))
    }
    
    private func setupZSlider() {
        setupSlider(zSlider, withBackgroundColor: UIColor(hex: "6A8BE2"))
    }
    
    private func setupSlider(_ slider: Slider, withBackgroundColor backgroundColor: UIColor) {
        let attributes = [
            NSAttributedString.Key.font: UIFont(name: Font.Gotham.medium, size: 16.0),
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        
        slider.setMinimumLabelAttributedText(NSAttributedString(string: "0", attributes: attributes))
        slider.setMaximumLabelAttributedText(NSAttributedString(string: String(Constant.maxCapacity), attributes: attributes))
        slider.contentViewColor = backgroundColor
        slider.valueViewColor = .white
        
        slider.attributedTextForFraction = { fraction in
            NSAttributedString(string: String(Int(fraction * CGFloat(Constant.maxCapacity))))
        }
        
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
    }
    
    private func setupCalculateButton() {
        calculateButton.setTitle("Calculate", for: .normal)
        calculateButton.setTitleColor(.white, for: .normal)
        calculateButton.titleLabel!.font = UIFont(name: Font.Gotham.medium, size: 16.0)
        calculateButton.backgroundColor = UIColor(hex: "2E3AAC")
        calculateButton.layer.cornerRadius = 8.0
        calculateButton.addTarget(self, action: #selector(didTouchCalculateButton), for: .touchUpInside)
    }
}

// MARK: - Actions
extension WaterConfigurationView {
    @objc private func didTouchCalculateButton() {
        impactFeedback.impactOccurred()
        delegate?.didTouchCalculateButton(in: self)
    }
    
    @objc private func sliderValueChanged() {
        selectionFeedback.selectionChanged()
    }
}

// MARK - Accessors
extension WaterConfigurationView {
    var xJugCapacity: Gallon {
        return gallonFromSlider(slider: xSlider)
    }
    
    var yJugCapacity: Gallon {
        return gallonFromSlider(slider: ySlider)
    }
    
    var desiredAmount: Gallon {
        return gallonFromSlider(slider: zSlider)
    }
}

// MARK: - Helpers
extension WaterConfigurationView {
    private func gallonFromSlider(slider: Slider) -> Gallon {
        return Gallon(slider.fraction * CGFloat(Constant.maxCapacity))
    }
}

// MARK: - Constants
extension WaterConfigurationView {
    // Change the slider max amount here
    private struct Constant {
        static let maxCapacity: Gallon = 100000
    }
}
