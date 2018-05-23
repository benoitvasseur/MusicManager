//
//  QueueViewController.swift
//  MusicManager
//
//  Created by Benoit Vasseur on 17/05/2018.
//  Copyright © 2018 bvasseur. All rights reserved.
//

import UIKit
import MediaPlayer

class PlayerCell: UITableViewCell {
    let playerController = MPMusicPlayerController.systemMusicPlayer
    
    @IBOutlet weak var artwork: UIImageView!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var endLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var groupLabel: UILabel!
    @IBOutlet weak var volumeSlider: UISlider!
    
    static var identifier = "PlayerCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        updatePlayer(item: playerController.nowPlayingItem)
        NotificationCenter.default.addObserver(self, selector: #selector(nowPlayingItemDidChangeNotification), name: NSNotification.Name.MPMusicPlayerControllerNowPlayingItemDidChange, object: nil)
    }
    
    // MARK: - Update player
    @objc func nowPlayingItemDidChangeNotification() {
        updatePlayer(item: playerController.nowPlayingItem)
    }
    
    func updatePlayer(item: MPMediaItem?) {
        titleLabel.text = item?.title
        artwork.image = item?.artwork?.image(at: artwork.bounds.size)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

class QueueViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let playerController = MPMusicPlayerController.systemMusicPlayer
    
    @IBOutlet weak var tableview: UITableView!
    fileprivate let cellIdentifier = "CellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableview.register(UINib(nibName: "MediaItemCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        
        AppDelegate.appDelegate().window?.sendSubview(toBack: AppDelegate.appDelegate().playerView)
        
        tableview.reloadData()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    @IBAction func closeTouched(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = AppDelegate.appDelegate().playerView.queueList?.count {
            return count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            // Player
            if let cell = tableview.dequeueReusableCell(withIdentifier: PlayerCell.identifier) as? PlayerCell {
                return cell
            }
            
            return UITableViewCell(style: .default, reuseIdentifier: "default")
        } else {
            if let cell = tableview.dequeueReusableCell(withIdentifier: cellIdentifier) as? MediaItemCell,
                let items = AppDelegate.appDelegate().playerView.queueList {
                
                let item = items[indexPath.row]
                cell.configureWithMediaItem(mediaItem: item)
                
                return cell
            }
            
            return UITableViewCell(style: .default, reuseIdentifier: "default")
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return self.view.frame.size.height
        }
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let item = AppDelegate.appDelegate().playerView.queueList?[indexPath.row] {
            AppDelegate.appDelegate().playerView.playItemFromCurrentList(item: item)
            tableview.reloadData()
            tableview.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        }
    }
    
}
