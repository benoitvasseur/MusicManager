//
//  MusicImport.swift
//  MusicManager
//
//  Created by Benoit Vasseur on 14/05/2018.
//  Copyright © 2018 bvasseur. All rights reserved.
//

import UIKit
import Foundation
import MediaPlayer

class MusicImport: NSObject {
    static func hasAuthorization() -> Bool {
        return MPMediaLibrary.authorizationStatus() == .authorized
    }
    
    static func isDenied() -> Bool {
        return MPMediaLibrary.authorizationStatus() == .restricted || MPMediaLibrary.authorizationStatus() == .denied
    }
    
    static func requestAuthorization(completion: @escaping (MPMediaLibraryAuthorizationStatus) -> Void) {
        MPMediaLibrary.requestAuthorization { (status) in
            completion(status)
        }
    }
    
    static func shouldRequestAuthorization() -> Bool {
        return !self.hasAuthorization() && !self.isDenied()
    }
    
    static func getPlaylists() -> [MPMediaItemCollection]? {
        return MPMediaQuery.playlists().collections
    }
}
