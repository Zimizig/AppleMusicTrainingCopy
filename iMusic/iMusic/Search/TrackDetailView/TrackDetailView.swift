//
//  TrackDetailView.swift
//  iMusic
//
//  Created by Роман on 13.08.2023.
//

import UIKit

class TrackDetailView: UIView {
    
    
    @IBOutlet weak var trackImageView: UIImageView!
    @IBOutlet weak var currentTimeSlider: UISlider!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var trackTitleLabel: UILabel!
    @IBOutlet weak var autorTitleLabel: UILabel!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var volumeSlider: UISlider!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        trackImageView.backgroundColor = .systemRed
    }
    @IBAction func dragDownButtonTapped(_ sender: Any) {
        self.removeFromSuperview()
    }
    
    @IBAction func hundleCurrentTimeSlider(_ sender: Any) {
    }
    @IBAction func handleVolumeSlider(_ sender: Any) {
    }
    @IBAction func previousTrack(_ sender: Any) {
    }
    @IBAction func nextTrack(_ sender: Any) {
    }
    @IBAction func playPauseAction(_ sender: Any) {
    }
}
