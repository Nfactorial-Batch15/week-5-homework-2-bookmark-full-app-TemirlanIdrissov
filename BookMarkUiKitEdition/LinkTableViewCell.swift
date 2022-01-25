//
//  LinkTableViewCell.swift
//  BookMarkUiKitEdition
//
//  Created by Temirlan Idrissov on 25.01.2022.
//

import UIKit

class LinkTableViewCell: UITableViewCell {
    
    private let lineView: UIView = {
        let view = UIView()
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() {
        self.addSubview(lineView)
        lineView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.height.equalToSuperview()
            
        }
    }

}
