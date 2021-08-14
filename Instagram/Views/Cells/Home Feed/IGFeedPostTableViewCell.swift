//
//  IGFeedPostTableViewCell.swift
//  Instagram
//
//  Created by JI XIANG on 14/8/21.
//

import UIKit

final class IGFeedPostTableViewCell: UITableViewCell { //final means nobody can subclas this class
    
    static let identifier = "IGFeedPostTableViewCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure() {
        // configure the cell 
    }

}
