//
//  PlayerView.swift
//  MusicManager
//
//  Created by Benoit Vasseur on 15/05/2018.
//  Copyright © 2018 bvasseur. All rights reserved.
//

import UIKit
import MediaPlayer

class PlayerView: UIView {
    let playerController = MPMusicPlayerController.systemMusicPlayer

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var playerLabel: UILabel!
    @IBOutlet weak var pauseButton: UIBarButtonItem!
    @IBOutlet weak var toolbar: UIToolbar!
    
    func playItemFromList(item: MPMediaItem, list: [MPMediaItem]) {
        playerController.setQueue(with: MPMediaItemCollection(items: [item]))
        playerController.append(MPMusicPlayerMediaItemQueueDescriptor(itemCollection: MPMediaItemCollection(items: list)))
        
        if !self.playerController.isPreparedToPlay {
            self.playerController.prepareToPlay()
        }
        playerController.play()
    }
    
    func nowPlayingItem() -> MPMediaItem? {
        return playerController.nowPlayingItem
    }
    
    @IBAction func previousTouched(_ sender: Any) {
        if playerController.currentPlaybackTime < 5 {
            playerController.skipToPreviousItem()
        } else {
            playerController.skipToBeginning()
        }
    }
    
    @IBAction func nextTouched(_ sender: Any) {
        playerController.skipToNextItem()
    }
    
    @IBAction func pauseTouched(_ sender: Any) {
        
        var newItem: UIBarButtonItem! = nil
        
        if playerController.playbackState == .playing {
            playerController.pause()
            newItem = UIBarButtonItem(barButtonSystemItem: .play, target: self, action: #selector(pauseTouched(_:)))
        } else {
            playerController.play()
            newItem = UIBarButtonItem(barButtonSystemItem: .pause, target: self, action: #selector(pauseTouched(_:)))
        }
        
        if var items = toolbar.items {
            newItem.tintColor = items.first?.tintColor
            items[2] = newItem
            toolbar.setItems(items, animated: true)
        }
    }
    
    
}
