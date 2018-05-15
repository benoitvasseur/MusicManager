//
//  ViewController.swift
//  MusicManager
//
//  Created by Benoit Vasseur on 14/05/2018.
//  Copyright © 2018 bvasseur. All rights reserved.
//

import UIKit
import MediaPlayer

class PlaylistsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableview: UITableView!
    var playlists: [MPMediaItemCollection]? = nil
    var selectedPlaylist: MPMediaItemCollection? = nil
    
    let cellIdentifier = "CellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.register(UINib(nibName: "PlaylistCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        
        if MusicImport.shouldRequestAuthorization() {
            MusicImport.requestAuthorization { [unowned self] (status) in
                if status == .authorized {
                    self.fetchPlaylists()
                }
            }
        } else if MusicImport.hasAuthorization() {
            fetchPlaylists()
        }
        
    }

    func fetchPlaylists() {
        playlists = MusicImport.getPlaylists()
        DispatchQueue.main.async {
            self.tableview.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = playlists?.count {
            return count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableview.dequeueReusableCell(withIdentifier: cellIdentifier) as? PlaylistCell, let playlists = playlists {
            cell.configureWithMediaItemCollection(mediaItemCollection: playlists[indexPath.row])
            
            return cell
        }
        
        return UITableViewCell(style: .default, reuseIdentifier: "default")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let playlists = playlists {
            selectedPlaylist = playlists[indexPath.row]
            self.performSegue(withIdentifier: "pushPlaylist", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let playlistVC = segue.destination as? PlaylistViewController {
            playlistVC.playlist = selectedPlaylist
        }
    }
    
}

