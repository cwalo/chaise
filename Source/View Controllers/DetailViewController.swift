//
//  DetailViewController.swift
//  chaise
//
//  Created by Corey Walo on 7/31/19.
//  Copyright © 2019 Corey Walo. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, Storyboarded {

    var event: EventEntity!

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        title = event.title

        imageView.setImage(from: event.imageURL)
        dateLabel.text = String(describing: event.date)
        locationLabel.text = event.location
    }
    
}
