//
//  LoadData.swift
//  TrainingExe89
//
//  Created by Trung Kien on 7/4/18.
//  Copyright © 2018 Trung Kien. All rights reserved.
//

import Foundation

protocol DataDelegate {
    func updateData(list : [Music])
}

class NetworkManager {
    private static let _instance = NetworkManager()
    var delegate : DataDelegate?
    var didLoadData: ((_ list : [Music]) -> Void)?
    
    static var InStance: NetworkManager {
        return _instance
    }
    
    func getData(key: String){
        var arrMusic = [Music]()
        
        var escapedString = key.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        var urlPath = "https://itunes.apple.com/search?term=\(escapedString!)&media=music"
        
        let urlRequest = URLRequest(url: URL(string: urlPath)!)
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            guard error == nil else{ return }
            guard let responseData = data else{ return }
            do{
                if let json = try JSONSerialization.jsonObject(with: responseData, options: .allowFragments) as? [String: Any]{
                    let arrMusicData = json["results"] as? [[String: Any]] ?? []
                    for i in 0..<arrMusicData.count{
                        var music = Music(json: arrMusicData[i])
                       
                        arrMusic.append(music)
                    }
                    DispatchQueue.main.async {
                        self.delegate?.updateData(list: arrMusic)
                    }
                }
            }
            catch{
                
            }
        }
        
        task.resume()
        
    }
    
    func getDataWithClosure(key : String) {
        var arrMusic = [Music]()
    
        var escapedString = key.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        var urlPath = "https://itunes.apple.com/search?term=\(escapedString!)&media=music"
    
        let urlRequest = URLRequest(url: URL(string: urlPath)!)
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
        guard error == nil else{ return }
        guard let responseData = data else{ return }
        do{
            if let json = try JSONSerialization.jsonObject(with: responseData, options: .allowFragments) as? [String: Any]{
                let arrMusicData = json["results"] as? [[String: Any]] ?? []
                for i in 0..<arrMusicData.count{
                    var music = Music(json: arrMusicData[i])
                    arrMusic.append(music)
                }
                
                DispatchQueue.main.async {
                    print("count : ")
                    self.didLoadData!(arrMusic)
                    
                }
            }
        }
        catch{
    
            }
        }
    
    task.resume()
    }
    
    func getDataWithNotification(key : String) {
        var arrMusic = [Music]()
        
        var escapedString = key.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        var urlPath = "https://itunes.apple.com/search?term=\(escapedString!)&media=music"
        
        let urlRequest = URLRequest(url: URL(string: urlPath)!)
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            guard error == nil else{ return }
            guard let responseData = data else{ return }
            do{
                if let json = try JSONSerialization.jsonObject(with: responseData, options: .allowFragments) as? [String: Any]{
                    let arrMusicData = json["results"] as? [[String: Any]] ?? []
                    for i in 0..<arrMusicData.count{
                        var music = Music(json: arrMusicData[i])
                        arrMusic.append(music)
                    }
                    
                    DispatchQueue.main.async {
                        let name = Notification.Name(rawValue: "SENDDATA")
                        NotificationCenter.default.post(name: name, object: arrMusic)
                       
                    }
                }
            }
            catch{
                
            }
        }
        
        task.resume()
    }
    
    
   
}
