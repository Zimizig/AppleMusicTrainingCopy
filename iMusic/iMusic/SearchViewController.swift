//
//  SearchViewController.swift
//  iMusic
//
//  Created by Роман on 02.08.2023.
//

import UIKit

struct TrackModel {
    var trackName: String
    var artistName: String
}

class SearchViewController: UITableViewController {
    
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
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ID")
        
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
