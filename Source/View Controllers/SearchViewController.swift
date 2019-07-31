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

    weak var coordinator: EventSelecting?
    var viewModel: EventSearching!

    let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()

        assert(viewModel != nil, "SearchViewController ViewModel was not initialized!")

        registerCells()
        setupSearchController()
        addViewModelCallbacks()
    }

    func registerCells() {
        let nib = UINib(nibName: SearchResultCell.reuseIdentifier, bundle: Bundle.main)
        tableView.register(nib, forCellReuseIdentifier: SearchResultCell.reuseIdentifier)
    }

    func setupSearchController() {
        searchController.searchBar.placeholder = "Search for an Event"
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }

    func addViewModelCallbacks() {
        viewModel.onStateDidChange = { [weak self] state in
            guard let self = self else { return }

            switch state {
            case .initial:
                print("initial: show empty state")
            case .searching:
                print("searching: show activity indicator")
            case .loaded:
                print("loaded: hide empty state")
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .loadingMore:
                print("loading more")
            case .error(let error):
                print(error)
            }
        }
    }

    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchController.searchBar.resignFirstResponder()
    }

    // MARK: UITableViewControllerDelegate & UITableViewControllerDatasource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.events.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultCell.reuseIdentifier,
                                                       for: indexPath) as? SearchResultCell else {
            fatalError("Falied to dequeue cell: \(SearchResultCell.reuseIdentifier)")
        }

        let row = indexPath.item
        
        if row == viewModel.events.count - 1 &&  viewModel.canFetchMore {
            viewModel.fetchMoreResults()
        }

        let item = viewModel.events[row]

        cell.titleLabel.text = item.title
        cell.locationLabel.text = item.location
        cell.dateLabel.text = item.date.description
        cell.eventImageView.image = nil

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let event = viewModel.events[indexPath.item]
        coordinator?.didSelectEvent(event)
    }

}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.search(for: searchText)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchController.searchBar.resignFirstResponder()
    }
}

