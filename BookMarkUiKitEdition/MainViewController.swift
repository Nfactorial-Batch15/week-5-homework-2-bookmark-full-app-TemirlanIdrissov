//
//  MainViewController.swift
//  BookMarkUiKitEdition
//
//  Created by Temirlan Idrissov on 25.01.2022.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {

    private let imageView: UIImageView =  {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "BG_Image")
        return imageView
    }()
    
    private let mainLabel: UILabel = {
       let label = UILabel()
        label.text = "Save all interesting link in one app"
        label.font = .systemFont(ofSize: 36, weight: .bold)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private let startButton: UIButton = {
       let button = UIButton()
        button.setTitle("Let's start collecting", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 16
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        setUI()
        startButton.addTarget(self, action: #selector(clickStartButton), for: .touchUpInside)
    }
    
    @objc private func clickStartButton() {
        let vc = TableViewViewController()
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.present(vc, animated: true, completion: nil)
        print("CLICKED")
    }
    
    private func setUI() {
        view.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(614)
        }
        
        view.addSubview(mainLabel)
        mainLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(6)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        view.addSubview(startButton)
        startButton.snp.makeConstraints { make in
            make.top.equalTo(mainLabel.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(58)
        }
    }
    

}
