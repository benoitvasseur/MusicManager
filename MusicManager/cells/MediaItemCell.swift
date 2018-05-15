//
//  MediaItemCell.swift
//  MusicManager
//
//  Created by Benoit Vasseur on 14/05/2018.
//  Copyright © 2018 bvasseur. All rights reserved.
//

import UIKit
import MediaPlayer

class MediaItemCell: UITableViewCell {
    @IBOutlet weak var mediaLabel: UILabel!
    @IBOutlet weak var mediaImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected {
            backgroundColor = UIColor.lightGray
        } else {
            backgroundColor = UIColor.white
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        mediaLabel.text = ""
        mediaImage.image = nil
    }
    
    func configureWithMediaItem(mediaItem: MPMediaItem) {
        mediaLabel.text = mediaItem.title
        mediaImage.image = mediaItem.artwork?.image(at: mediaImage.bounds.size)
    }

}
