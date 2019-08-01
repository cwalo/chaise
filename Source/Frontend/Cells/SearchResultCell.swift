//
//  SearchResultCell.swift
//  chaise
//
//  Created by Corey Walo on 7/30/19.
//  Copyright © 2019 Corey Walo. All rights reserved.
//

import UIKit

struct SearchResultCellData {
    let imageURL: URL?
    let title: String
    let location: String
    let date: Date?
    let isFavorite: Bool
}

class SearchResultCell: UITableViewCell, NibLoading {

    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var favoriteIcon: UIImageView!

    static var reuseIdentifier: String {
        return "SearchResultCell"
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        eventImageView.layer.cornerRadius = 10
        favoriteIcon.image = UIImage(named: "like")?.withRenderingMode(.alwaysTemplate)
        favoriteIcon.tintColor = .red
    }

    override func prepareForReuse() {
        titleLabel.text = nil
        locationLabel.text = nil
        dateLabel.text = nil
        eventImageView.image = nil
        favoriteIcon.isHidden = true
    }

    func configure(with data: SearchResultCellData) {
        titleLabel.text = data.title
        locationLabel.text = data.location
        favoriteIcon.isHidden = !data.isFavorite

        if let date = data.date {
            let formatter = DateFormatter()
            formatter.dateStyle = .short
            dateLabel.text = formatter.string(from: date)
        } else {
            dateLabel.text = "TBD"
        }

        if let imageURL = data.imageURL {
            eventImageView.setImage(from: imageURL)
        }
    }
}
