//
//  CMTime + extension.swift
//  iMusic
//
//  Created by Роман on 13.08.2023.
//

import Foundation
import AVKit

extension CMTime {
    
    func toDisplayString() -> String {
        
        guard !CMTimeGetSeconds(self).isNaN else { return "" }
        let totalSecond = Int(CMTimeGetSeconds(self))
        let seconds = totalSecond % 60
        let minutes = totalSecond / 60
        let timeFormatString = String(format: "%02d:%02d", minutes, seconds)
        
        return timeFormatString
    }
}
