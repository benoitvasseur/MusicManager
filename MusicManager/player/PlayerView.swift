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

    @IBOutlet fileprivate  weak var imageView: UIImageView!
    @IBOutlet fileprivate weak var playerLabel: UILabel!
    @IBOutlet fileprivate weak var pauseButton: UIBarButtonItem!
    @IBOutlet fileprivate weak var toolbar: UIToolbar!
    @IBOutlet fileprivate weak var touchButton: UIButton!
    private(set) var queueList: [MPMediaItem]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0.5, height: 0.5);
        self.layer.shadowOpacity = 0.5;
        
        updatePlayer(item: playerController.nowPlayingItem)
        NotificationCenter.default.addObserver(self, selector: #selector(nowPlayingItemDidChangeNotification), name: NSNotification.Name.MPMusicPlayerControllerNowPlayingItemDidChange, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func playItemFromCurrentList(item: MPMediaItem) {
        if let index = self.queueList?.index(of: item), let range = Range(NSRange(location: 0, length: index)) {
            self.queueList?.removeSubrange(range)
        }
        playItemFromList(item: item, list: self.queueList)
    }
    
    func playItemFromList(item: MPMediaItem, list: [MPMediaItem]?) {
        playerController.pause()
        if let list = list {
            playerController.setQueue(with: MPMediaItemCollection(items: list))
        }
        self.queueList = list
        playerController.nowPlayingItem = item
        
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
    
    // MARK: - Update player
    @objc func nowPlayingItemDidChangeNotification() {
        updatePlayer(item: playerController.nowPlayingItem)
    }
    
    func updatePlayer(item: MPMediaItem?) {
        playerLabel.text = item?.title
        imageView.image = item?.artwork?.image(at: imageView.bounds.size)
    }
    
    // MARK: - Action
    func addTouchTarget(_ target: Any?, action: Selector, for controlEvents: UIControlEvents) {
        touchButton.addTarget(target, action: action, for: controlEvents)
    }
}
