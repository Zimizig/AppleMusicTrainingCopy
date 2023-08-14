//
//  Nib.swift
//  iMusic
//
//  Created by Роман on 14.08.2023.
//

import UIKit

extension UIView {
    class func loadFromNib<T : UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0]
        as! T
    }
}
