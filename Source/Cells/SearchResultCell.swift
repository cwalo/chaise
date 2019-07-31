//
//  SearchResultCell.swift
//  chaise
//
//  Created by Corey Walo on 7/30/19.
//  Copyright © 2019 Corey Walo. All rights reserved.
//

import UIKit

struct SearchResultCellData {
    let imageURL: URL
    let title: String
    let location: String
    let date: Date
}

class SearchResultCell: UITableViewCell {

    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    static var reuseIdentifier: String {
        return "SearchResultCell"
    }

    override func prepareForReuse() {
        titleLabel.text = ""
        locationLabel.text = ""
        dateLabel.text = ""
        eventImageView.image = nil
    }

    func configure(with data: SearchResultCellData) {
        titleLabel.text = data.title
        locationLabel.text = data.location
        dateLabel.text = data.date.description
        eventImageView.setImage(from: data.imageURL)
    }
}
