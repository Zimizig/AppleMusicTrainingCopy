//
//  SearchModels.swift
//  iMusic
//
//  Created by Роман on 07.08.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit

enum Search {
    
    enum Model {
        struct Request {
            enum RequestType {
                case some
                case getTracks(searchTerm: String)
            }
        }
        struct Responce {
            enum ResponceType {
                case some
                case presentTracks(searchResponce: SearchResponse?)
            }
        }
        struct ViewModel {
            enum ViewModelData {
                case some
                case displayTracks(searchViewModel: SearchViewModel)
            }
        }
    }
}

struct SearchViewModel {
    struct Cell {
        var iconUrlString: String?
        var trackName: String
        var collectionName: String
        var artistName: String
    }
    let cells: [Cell]
}
