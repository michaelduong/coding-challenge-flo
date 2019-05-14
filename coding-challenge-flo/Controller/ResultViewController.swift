//
//  ResultViewController.swift
//  coding-challenge-flo
//
//  Created by Michael Duong on 5/12/19.
//  Copyright © 2019 Turnt Labs. All rights reserved.
//

import UIKit

final class ResultViewController: UIViewController {
    
    private let states: [State]
    private let tableView = UITableView()
    private let newConfigButton = UIButton(type: .system)
    private let impact = UIImpactFeedbackGenerator()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(states: [State]) {
        self.states = states
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupSubviews()
        self.setupSubviewsHierarchy()
        impact.prepare()
    }
}

// MARK: - Layout
extension ResultViewController {
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = self.view.bounds
        
        let horizontalPadding: CGFloat = 16.0
        let newConfigButtonHeight: CGFloat = 56.0
        
        newConfigButton.frame = CGRect(x: horizontalPadding,
                                       y: self.view.bounds.height - 42.0 - newConfigButtonHeight,
                                       width: self.view.bounds.width - 2 * horizontalPadding,
                                       height: newConfigButtonHeight)
    }
}

// MARK: - Setup
extension ResultViewController {
    private func setupSubviewsHierarchy() {
        self.view.addSubview(tableView)
        self.view.addSubview(newConfigButton)
    }
    
    private func setupSubviews() {
        setupTableView()
        setupNewConfigButton()
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor(hex: "B6DCFE")
        tableView.separatorColor = UIColor(hex: "B6DCFE")
        tableView.separatorInset = .zero
        tableView.rowHeight = 80.0
        tableView.contentInset.bottom = 108
    }
    
    private func setupNewConfigButton() {
        newConfigButton.setTitle("New Config", for: .normal)
        newConfigButton.setTitleColor(.black, for: .normal)
        newConfigButton.titleLabel!.font = UIFont(name: Font.Gotham.bold, size: 16.0)
        newConfigButton.backgroundColor = .white
        newConfigButton.layer.cornerRadius = 8.0
        newConfigButton.layer.shadowColor = UIColor(white: 0.0, alpha: 0.5).cgColor
        newConfigButton.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        newConfigButton.layer.shadowRadius = 4.0
        newConfigButton.layer.shadowOpacity = 1.0
        newConfigButton.addTarget(self, action: #selector(didTouchNewConfigButton), for: .touchUpInside)
    }
}

// MARK: - UITableView Data Source
extension ResultViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return states.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: StateCell.identifier) as? StateCell
        
        if cell == nil {
            cell = StateCell()
        }
        
        cell!.configure(with: states[indexPath.row])
        
        return cell!
    }
}

// MARK: - Actions
extension ResultViewController {
    @objc private func didTouchNewConfigButton() {
        impact.impactOccurred()
        self.dismiss(animated: true, completion: nil)
    }
}
