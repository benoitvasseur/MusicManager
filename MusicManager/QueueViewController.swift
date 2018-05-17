//
//  QueueViewController.swift
//  MusicManager
//
//  Created by Benoit Vasseur on 17/05/2018.
//  Copyright © 2018 bvasseur. All rights reserved.
//

import UIKit
import MediaPlayer

class QueueViewController: UIViewController {
    let playerController = MPMusicPlayerController.systemMusicPlayer
    
    @IBOutlet weak var artwork: UIImageView!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var endLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var groupLabel: UILabel!
    @IBOutlet weak var volumeSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updatePlayer(item: playerController.nowPlayingItem)
        NotificationCenter.default.addObserver(self, selector: #selector(nowPlayingItemDidChangeNotification), name: NSNotification.Name.MPMusicPlayerControllerNowPlayingItemDidChange, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AppDelegate.appDelegate().window?.sendSubview(toBack: AppDelegate.appDelegate().playerView)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    @IBAction func closeTouched(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

    // MARK: - Update player
    @objc func nowPlayingItemDidChangeNotification() {
        updatePlayer(item: playerController.nowPlayingItem)
    }
    
    func updatePlayer(item: MPMediaItem?) {
        titleLabel.text = item?.title
        artwork.image = item?.artwork?.image(at: artwork.bounds.size)
    }
}
