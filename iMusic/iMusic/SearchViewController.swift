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

class SearchViewController: UITableViewController {
    
    let searchController = UISearchController(searchResultsController: nil)
    let trackList = [
                  TrackModel(trackName: "First track", artistName: "Noname1"),
                  TrackModel(trackName: "First track", artistName: "Noname1"),
                  TrackModel(trackName: "First track", artistName: "Noname1"),
                  TrackModel(trackName: "First track", artistName: "Noname1"),
                  TrackModel(trackName: "First track", artistName: "Noname1"),
                  TrackModel(trackName: "First track", artistName: "Noname1"),
                  TrackModel(trackName: "First track", artistName: "Noname1"),
                  TrackModel(trackName: "First track", artistName: "Noname1"),
                  TrackModel(trackName: "First track", artistName: "Noname1"),
                  TrackModel(trackName: "First track", artistName: "Noname1"),
                  TrackModel(trackName: "First track", artistName: "Noname1"),
                  TrackModel(trackName: "First track", artistName: "Noname1"),
                  TrackModel(trackName: "First track", artistName: "Noname1"),
                  TrackModel(trackName: "First track", artistName: "Noname1"),
                  TrackModel(trackName: "First track", artistName: "Noname1"),
                  TrackModel(trackName: "First track", artistName: "Noname1"),
                ]
    
    
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

extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let url = "https://itunes.apple.com/search?term=\(searchText)"
        AF.request(url).responseData { dataResponse in
            if let error = dataResponse.error {
                print("Error received requesting data: \(error.localizedDescription)")
                return
            }
            guard let data = dataResponse.data else { return }
            let someString = String(data: data, encoding: .utf8)
            print(someString ?? "")
        }
    }
}
