//
//  NetworkService.swift
//  iMusic
//
//  Created by Роман on 06.08.2023.
//

import Foundation
import Alamofire

class NetworkService {
    
    func fetchTracks(searchText: String, competion: @escaping(SearchResponse?) -> Void) {
        let url = "https://itunes.apple.com/search"
        let parametrs = [
                          "term": "\(searchText)",
                         "limit": "10",
                          "media": "music"
                        ]
        AF.request(url,method: .get,parameters: parametrs,encoding: URLEncoding.default, headers: nil).responseData { dataResponse in
            
            if let error = dataResponse.error {
                print("Error received requesting data: \(error.localizedDescription)")
                competion(nil)
                return
            }
            guard let data = dataResponse.data else { return }
            
            let decoder = JSONDecoder()
            do {
                let objects = try decoder.decode(SearchResponse.self, from: data)
                print("objects: ", objects)
                competion(objects)
                
                
            } catch let jsonError {
                print("Failed to decode JSON: \(jsonError)")
                competion(nil)
            }
        }
    }
    
}
