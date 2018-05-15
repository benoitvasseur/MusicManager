//
//  PlaylistCell.swift
//  MusicManager
//
//  Created by Benoit Vasseur on 14/05/2018.
//  Copyright © 2018 bvasseur. All rights reserved.
//

import UIKit
import MediaPlayer

class PlaylistCell: MediaItemCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureWithMediaItemCollection(mediaItemCollection: MPMediaItemCollection) {
        mediaImage.image = mediaItemCollection.representativeItem?.artwork?.image(at: mediaImage.bounds.size)
        if let text = mediaItemCollection.value(forProperty: MPMediaPlaylistPropertyName) as? String {
            mediaLabel.text = text
        } else {
            mediaLabel.text = "Playlist"
        }
    }

}
