//
//  TableViewViewController.swift
//  BookMarkUiKitEdition
//
//  Created by Temirlan Idrissov on 25.01.2022.
//

import UIKit
import SnapKit

class TableViewViewController: UIViewController {

    private var links: [LinkModel] = Storage.linkModels {
        didSet {
            if links.count > 0 {
                checkLinks()
            }
            
            if links.count == 0 {
                checkLinks()
            }
        }
    }
    
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
        checkLinks()
        view.backgroundColor = .white
        
        addButton.addTarget(self, action: #selector(handleAddButton), for: .touchUpInside)
        
        tableView.register(LinkTableViewCell.self, forCellReuseIdentifier: "LinkTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
        
        
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
    
    private func checkLinks() {
        if links.isEmpty {
            tableView.isHidden = true
            mainLabel.isHidden = false
        } else {
            tableView.isHidden = false
            mainLabel.isHidden = true
        }
    }
    
    @objc private func handleAddButton() {
        
        // 1. Create the alert controller.
        let alert = UIAlertController(title: "Change", message: .none, preferredStyle: .alert)
        
        // 2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.placeholder = "Bookmark Title"
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = "Bookmark Link"
        }
        
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { [weak alert] (_) in
            guard let title = alert?.textFields![0].text, !title.isEmpty else { return }
            guard let link = alert?.textFields![0].text, !link.isEmpty else { return }
            self.addNewLinkToArray(title: title, link: link)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            print("dismissed")
        }))
        
        // 4. Present the alert
        self.present(alert, animated: true , completion: nil)
    }
    
    private func addNewLinkToArray(title: String, link: String) {
        self.links.append(LinkModel(title: title, link: link))
        Storage.linkModels.append(LinkModel(title: title, link: link))
        self.tableView.reloadData()
    }
}

extension TableViewViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.links.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LinkTableViewCell", for: indexPath) as? LinkTableViewCell else {return UITableViewCell()}
        cell.configure(model: links[indexPath.row])
        return cell
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 100
//    }
    
    
}
