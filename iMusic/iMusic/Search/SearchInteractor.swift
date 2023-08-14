//
//  SearchInteractor.swift
//  iMusic
//
//  Created by Роман on 07.08.2023.

import UIKit

protocol SearchBusinessLogic {
    func makeRequest(request: Search.Model.Request.RequestType)
}

class SearchInteractor: SearchBusinessLogic {
    
    var networkServise = NetworkService()
    var presenter: SearchPresentationLogic?
    var service: SearchService?
    
    func makeRequest(request: Search.Model.Request.RequestType) {
        if service == nil {
            service = SearchService()
        }
        
        switch request {
        case .getTracks (let searchTerm):
            print("interactor .getTracks")
            presenter?.presentData(response: Search.Model.Responce.ResponceType.presentFooterView)
            networkServise.fetchTracks(searchText: searchTerm) { [weak self] (searchResponce) in
                    self?.presenter?.presentData(response: Search.Model.Responce.ResponceType.presentTracks(searchResponce: searchResponce))
            }
        }
        
    }
}
