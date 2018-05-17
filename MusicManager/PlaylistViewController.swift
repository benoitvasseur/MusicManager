//
//  PlaylistViewController.swift
//  MusicManager
//
//  Created by Benoit Vasseur on 14/05/2018.
//  Copyright © 2018 bvasseur. All rights reserved.
//

import UIKit
import MediaPlayer

class PlaylistViewController: PlayerViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableview: UITableView!
    var playlist: MPMediaItemCollection!
    fileprivate var items: [MPMediaItem]!
    
    fileprivate let cellIdentifier = "CellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableview.register(UINib(nibName: "MediaItemCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        
        items = playlist.items.sorted(by: { (mediaItem1, mediaItem2) -> Bool in
            return mediaItem1.dateAdded.compare(mediaItem2.dateAdded) == .orderedDescending
        })
        
        NotificationCenter.default.addObserver(self, selector: #selector(nowPlayingItemDidChangeNotification), name: NSNotification.Name.MPMusicPlayerControllerNowPlayingItemDidChange, object: nil)
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Tableview
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playlist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableview.dequeueReusableCell(withIdentifier: cellIdentifier) as? MediaItemCell {
            let item = items[indexPath.row]
            cell.configureWithMediaItem(mediaItem: item)
            
            return cell
        }
        
        return UITableViewCell(style: .default, reuseIdentifier: "default")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        
        AppDelegate.appDelegate().playerView.playItemFromList(item: item, list: items)
    }
    
    // MARK: - Player
    
    @objc func nowPlayingItemDidChangeNotification() {
        if let selectedIndex = tableview.indexPathForSelectedRow {
            tableview.deselectRow(at: selectedIndex, animated: true)
        }
        if let nowPlayingItem = AppDelegate.appDelegate().playerView.nowPlayingItem(), let index = items.index(of: nowPlayingItem) {
            tableview.selectRow(at: IndexPath(row: index, section: 0), animated: true, scrollPosition: .none)
        }
    }

}
