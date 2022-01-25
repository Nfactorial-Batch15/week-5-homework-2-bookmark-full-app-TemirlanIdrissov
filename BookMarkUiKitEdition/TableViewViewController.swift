//
//  TableViewViewController.swift
//  BookMarkUiKitEdition
//
//  Created by Temirlan Idrissov on 25.01.2022.
//

import UIKit
import SnapKit

class TableViewViewController: UIViewController {

    private var links: [LinkModel] = [LinkModel(title: "YouTube", link: "www.yootube.com")]
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.isHidden = true
        return tableView
    }()
    
    private let mainLabel: UILabel = {
       let label = UILabel()
        label.text = "Save your first bookmark"
        label.font = .systemFont(ofSize: 36, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let addButton: UIButton = {
       let button = UIButton()
        button.setTitle("Add bookmark", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 16
        button.backgroundColor = .black
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        tableView.register(LinkTableViewCell.self, forCellReuseIdentifier: "LinkTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
        setUI()
        addButton.addTarget(self, action: #selector(handleAddButton), for: .touchUpInside)
        
    }
    private func setUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalToSuperview().offset(42)
        }
        
        view.addSubview(mainLabel)
        mainLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
        }
        
        view.addSubview(addButton)
        addButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(58)
            make.bottom.equalToSuperview().offset(-50)
        }
    }
    
    @objc private func handleAddButton() {
        // 1.
        let alert = UIAlertController(title: "Change", message: nil, preferredStyle: .alert)
        
        // 2.
        alert.addTextField { (textField) in
            textField.placeholder = "Bookmark Title"
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = "Bookmark Link"
        }
        
        // 3.
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { [weak alert] (_) in
            guard let title = alert?.textFields![0].text, !title.isEmpty else { return }
            guard let link = alert?.textFields![0].text, !link.isEmpty else { return }
            self.addNewLinkToArray(title: title, link: link)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { [weak alert] (_) in
            print("dismissed")
        }))
        
        // 4. Present the alert
        self.present(alert, animated: true , completion: nil)
    }
    
    private func addNewLinkToArray(title: String, link: String) {
        self.links.append(LinkModel(title: title, link: link))
        self.tableView.reloadData()
    }
}

extension TableViewViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.links.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LinkTableViewCell", for: : IndexPath) as? LinkTableViewCell else {return UITableViewCell()}
        return cell
    }
    
    
}
