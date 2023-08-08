//
//  SearchRouter.swift
//  iMusic
//
//  Created by Роман on 07.08.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit

protocol SearchRoutingLogic {
    
}
class SearchRouter: NSObject, SearchRoutingLogic {
    
    weak var viewController: SearchViewController?
}
