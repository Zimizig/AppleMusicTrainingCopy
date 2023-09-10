//
//  UserDefaults .swift
//  iMusic
//
//  Created by Роман on 22.08.2023.
//

import Foundation

extension UserDefaults {
    static let favouriteTrackKey = "favouriteTrackKey"
    
    func savedTracks() -> [SearchViewModel.Cell ] {
        let deafults = UserDefaults.standard
        
        guard let savedTracks = deafults.object(forKey: UserDefaults.favouriteTrackKey) as? Data
        else { return [] }
        guard let decodedTracks = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedTracks) as? [SearchViewModel.Cell] else { return [] }
        return decodedTracks
    }
}
