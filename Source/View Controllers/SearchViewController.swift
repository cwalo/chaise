//
//  SearchViewController.swift
//  chaise
//
//  Created by Corey Walo on 7/30/19.
//  Copyright © 2019 Corey Walo. All rights reserved.
//

import UIKit

class SearchViewController: UITableViewController, Storyboarded {

    // MARK: View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        registerCells()
    }

    func registerCells() {
        let nib = UINib(nibName: SearchResultCell.reuseIdentifier, bundle: Bundle.main)
        tableView.register(nib, forCellReuseIdentifier: SearchResultCell.reuseIdentifier)
    }

    // MARK: UITableViewControllerDelegate

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: SearchResultCell.reuseIdentifier, for: indexPath)
    }

}

