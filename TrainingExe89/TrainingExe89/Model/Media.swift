//
//  Music.swift
//  TrainingExe89
//
//  Created by Trung Kien on 7/4/18.
//  Copyright © 2018 Trung Kien. All rights reserved.
//

import UIKit

class Media: NSObject {
    var artistName : String?
    var trackName : String?
    var artworkUrl100 : String?
    var trackTimeMillis: Int?
    var image : UIImage?
    
    init(json : [String: Any]){
        if let artistName = json["artistName"]{
            self.artistName = artistName as? String
        }
        if let trackName = json["trackName"]{
            self.trackName = trackName as? String
        }
        if let artworkUrl100 =  json["artworkUrl100"]{
            self.artworkUrl100 = artworkUrl100 as? String
        }
        if let trackTimeMillis = json["trackTimeMillis"]{
            self.trackTimeMillis = trackTimeMillis as? Int
        }
    }
}
