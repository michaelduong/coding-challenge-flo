//
//  ConfigureViewController.swift
//  coding-challenge-flo
//
//  Created by Michael Duong on 5/12/19.
//  Copyright © 2019 Turnt Labs. All rights reserved.
//

import UIKit
import BAFluidView
import IHProgressHUD

final class ConfigureViewController: UIViewController {
    
    private let configurationView = WaterConfigurationView()
    private let notificationFeedback = UINotificationFeedbackGenerator()
    private var bannerIsShowing = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSelf()
        setupSubviews()
        
        self.view.addSubview(configurationView)
        notificationFeedback.prepare()
    }
}

// MARK: - Layout
extension ConfigureViewController {
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let configurationViewHeight = configurationView.sizeThatFits(.zero).height
        
        configurationView.frame = CGRect(x: 0.0,
                                         y: self.view.bounds.height - configurationViewHeight,
                                         width: self.view.bounds.width,
                                         height: configurationViewHeight)
    }
}

// MARK: - Setup
extension ConfigureViewController {
    private func setupSelf() {
        self.view.backgroundColor = UIColor(hex: "B6DCFE")
    }
    
    private func setupSubviews() {
        setupConfigurationView()
        setupWaveAnimation()
    }
    
    private func setupConfigurationView() {
        configurationView.delegate = self
    }
    
    private func setupWaveAnimation() {
        let view = BAFluidView(frame: self.view.frame)
        view.fillColor = UIColor(hex: "2E3AAC")
        view.fillAutoReverse = false
        view.fillRepeatCount = 1
        view.fill(to: 0.65)
        view.startAnimation()
        self.view.addSubview(view)
    }
}

// MARK: - Edge Case Check
extension ConfigureViewController {
    // z has to be a linear combination of x and y
    // any linear combination of x and y has to be a multiple of the gcd of x and y.
    // In addition, z can't contain more than the sum of x and y
    // gcd: greatest common divisor, every integer of the form ax + by is a multiple of the greatest common divisor d.
    // also checks if z can be fitted into one single jug
    private func isSolvable(_ x: Int, _ y: Int, _ z: Int) -> Bool {
        return z == 0 || ((z <= (x > y ? x : y)) && (z.isMultiple(of: gcd(x, y))))
    }
    
    // Find the GCD: greatest common divisor
    private func gcd(_ a: Int, _ b: Int) -> Int {
        return b == 0 ? a : gcd(b, a % b)
    }
}

// MARK: - Error Banner
extension ConfigureViewController {
    private func bannerView(message: String, color: UIColor){
        if !bannerIsShowing {
            bannerIsShowing = true
            
            let bannerViewHeight = self.view.bounds.height/12
            let bannerVewY = 0 - bannerViewHeight
            
            let bannerView = UIView()
            bannerView.frame = CGRect(x: 0, y: bannerVewY, width: self.view.bounds.width, height: bannerViewHeight)
            bannerView.backgroundColor = color
            self.view.addSubview(bannerView)
            
            let bannerLabelWidth = bannerView.bounds.width
            let bannerLabelHeight = bannerView.bounds.height + UIApplication.shared.statusBarFrame.height/2
            
            let bannerLabel = UILabel()
            bannerLabel.frame.size.width = bannerLabelWidth
            bannerLabel.frame.size.height = bannerLabelHeight
            bannerLabel.numberOfLines = 0
            
            bannerLabel.text = message
            bannerLabel.font = UIFont(name: Font.Gotham.bold, size: 18)
            bannerLabel.textColor = .white
            bannerLabel.textAlignment = .center
            
            bannerView.addSubview(bannerLabel)
            
            UIView.animate(withDuration: 0.2, animations: {
                bannerView.frame.origin.y = 0
            }, completion: { (success) in
                if success{
                    UIView.animate(withDuration: 0.1, delay: 2, options: .curveLinear, animations: {
                        bannerView.frame.origin.y = bannerVewY
                    }, completion: { (success) in
                        if success{
                            bannerView.removeFromSuperview()
                            bannerLabel.removeFromSuperview()
                            self.bannerIsShowing = false
                        }
                    })
                }
            })
            
        }
    }
}

// MARK: - WaterConfigurationView delegate
// Extract x, y, z values from the view
// Inject into our function to determine if values are solvable before continuing
extension ConfigureViewController: WaterConfigurationViewDelegate {
    func didTouchCalculateButton(in waterConfigurationView: WaterConfigurationView) {
        IHProgressHUD.show()
        let xJug = Jug(capacity: waterConfigurationView.xJugCapacity, identifier: xJugIdentifier)
        let yJug = Jug(capacity: waterConfigurationView.yJugCapacity, identifier: yJugIdentifier)
        let z = waterConfigurationView.desiredAmount
        
        DispatchQueue.global(qos: .default).async {
            if self.isSolvable(xJug.capacity, yJug.capacity, z) {
                let solver = JugRiddleSolver(firstJug: xJug, secondJug: yJug)
                let states = solver.states(fromDesiredAmount: z)
                DispatchQueue.main.async {
                    IHProgressHUD.dismiss()
                    let resultViewController = ResultViewController(states: states)
                    self.present(resultViewController, animated: true, completion: nil)
                }
            } else {
                DispatchQueue.main.async {
                    self.notificationFeedback.notificationOccurred(.error)
                    self.bannerView(message: "No solution possible.", color: .red)
                    IHProgressHUD.dismiss()
                }
            }
        }
    }
}
