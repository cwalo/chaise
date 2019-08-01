//
//  DetailViewController.swift
//  chaise
//
//  Created by Corey Walo on 7/31/19.
//  Copyright © 2019 Corey Walo. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, Storyboarded {

    var event: EventEntity! {
        didSet {
            navigationItem.rightBarButtonItem?.tintColor = event.isFavorite ? .red : .darkGray
        }
    }
    var favoritesManager: FavoritesManager!

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        assert(event != nil)
        assert(favoritesManager != nil)

        let image = UIImage(named: "like")?.withRenderingMode(.alwaysTemplate)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image,
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(DetailViewController.didPressLikeButton))

        navigationItem.rightBarButtonItem?.tintColor = event.isFavorite ? .red : .darkGray

        title = event.title

        if let imageURL = event.imageURL {
            imageView.setImage(from: imageURL)
        }

        if let date = event.date {
            let formatter = DateFormatter()
            formatter.dateStyle = .short
            dateLabel.text = formatter.string(from: date)
        } else {
            dateLabel.text = "TBD"
        }

        locationLabel.text = event.location
    }

    @objc
    func didPressLikeButton() {
        var eventCopy = event
        eventCopy?.isFavorite = !event.isFavorite
        event = eventCopy

        if event.isFavorite {
            favoritesManager.favorite(event.id)
        } else {
            favoritesManager.unfavorite(event.id)
        }
    }
    
}
