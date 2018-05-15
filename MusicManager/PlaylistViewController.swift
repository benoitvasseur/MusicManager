//
//  PlaylistViewController.swift
//  MusicManager
//
//  Created by Benoit Vasseur on 14/05/2018.
//  Copyright © 2018 bvasseur. All rights reserved.
//

import UIKit
import MediaPlayer

class PlaylistViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableview: UITableView!
    var playlist: MPMediaItemCollection!
    var items: [MPMediaItem]!
    let playerController = MPMusicPlayerController.systemMusicPlayer
    
    let cellIdentifier = "CellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableview.register(UINib(nibName: "MediaItemCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        
        items = playlist.items.sorted(by: { (mediaItem1, mediaItem2) -> Bool in
            return mediaItem1.dateAdded.compare(mediaItem2.dateAdded) == .orderedDescending
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playlist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableview.dequeueReusableCell(withIdentifier: cellIdentifier) as? MediaItemCell {
            let item = items[indexPath.row]
            cell.configureWithMediaItem(mediaItem: item)
            
            if let isEqual = playerController.nowPlayingItem?.isEqual(item), isEqual {
                cell.setSelected(true, animated: true)
            } else {
                cell.setSelected(false, animated: true)
            }
            return cell
        }
        
        return UITableViewCell(style: .default, reuseIdentifier: "default")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        
        playerController.setQueue(with: MPMediaItemCollection(items: [item]))
        playerController.append(MPMusicPlayerMediaItemQueueDescriptor(itemCollection: MPMediaItemCollection(items: items)
        
        if !self.playerController.isPreparedToPlay {
            self.playerController.prepareToPlay()
        }
        playerController.play()
        
        tableView.reloadRows(at: [indexPath], with: .none)
    }

}
