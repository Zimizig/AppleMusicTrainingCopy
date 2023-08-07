//
//  SearchViewController.swift
//  iMusic
//
//  Created by Роман on 02.08.2023.
//

import UIKit
import Alamofire

struct TrackModel {
    var trackName: String
    var artistName: String
}

class SearchMusicViewController: UITableViewController {
    
    var networkServise = NetworkService()
    
    private var timer: Timer?
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var trackList = [Track]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .darkGray
        setupSearchBar()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ID")
        
    }
    
    private func setupSearchBar() {
        navigationItem.searchController = searchController
        navigationItem.searchController?.searchBar.placeholder = "Артисты, песни, тексты и др."
        navigationItem.searchController?.searchBar.tintColor = .systemPink
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trackList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ID", for: indexPath)
        let track = trackList[indexPath.row]
        cell.textLabel?.text = "\(track.trackName)\n\(track.artistName)"
        cell.textLabel?.numberOfLines = 2
        cell.imageView?.image = UIImage(named: "pop3")
        
        
        return cell
    }
        
}

extension SearchMusicViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false, block: { _ in
            self.networkServise.fetchTracks(searchText: searchText) { [weak self] (searchResults) in
                self?.trackList = searchResults?.results ?? []
                self?.tableView.reloadData()
            }
        })
    }
}
