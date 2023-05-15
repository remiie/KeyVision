//
//  DoorsView.swift
//  KeyVision
//
//  Created by Роман Васильев on 15.05.2023.
//

import UIKit

final class DoorsView: UIView, DoorsViewProtocol {
    
    var delegate: DoorsViewDelegate?
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTableView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupTableView()
    }
    
    private func setupTableView() {
        backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.register(DoorCell.self, forCellReuseIdentifier: DoorCell.identifier)
        tableView.register(DoorWithCamCell.self, forCellReuseIdentifier: DoorWithCamCell.identifier)
        tableView.separatorStyle = .none
        addSubview(containerView)
        containerView.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            tableView.topAnchor.constraint(equalTo: containerView.topAnchor,constant: 20),
            tableView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }
    
}

extension DoorsView: UITableViewDataSource, UITableViewDelegate {
    
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return delegate?.getItemsCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let delegate = delegate, delegate.doorHasCamera(at: indexPath) {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DoorWithCamCell.identifier, for: indexPath) as?
                    DoorWithCamCell else { return UITableViewCell() }
            cell.configure(with: UIImage(named: "door"), title: "Домофон", status: "В сети")
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: DoorCell.identifier, for: indexPath) as? DoorCell
        cell?.configure(title: "Подъезд 1")
        cell?.selectionStyle = .none
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let delegate = delegate else { return 0.0 }
        let height: CGFloat = delegate.doorHasCamera(at: indexPath) ? 310.0 :80.0
        return height
    }
    
}