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

extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false, block: { _ in
            
            let url = "https://itunes.apple.com/search"
            let parametrs = [
                              "term": "\(searchText)",
                             "limit": "10"
                            ]
            AF.request(url,method: .get,parameters: parametrs,encoding: URLEncoding.default, headers: nil).responseData { dataResponse in
                
                if let error = dataResponse.error {
                    print("Error received requesting data: \(error.localizedDescription)")
                    return
                }
                guard let data = dataResponse.data else { return }
                
                let decoder = JSONDecoder()
                do {
                    let objects = try decoder.decode(SearchResponse.self, from: data)
                    print("objects: ", objects)
                    self.trackList = objects.results
                    self.tableView.reloadData()
                } catch let jsonError {
                    print("Failed to decode JSON: \(jsonError)")
                }
            }
        })
    }
}
