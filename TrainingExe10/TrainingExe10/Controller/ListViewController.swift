//
//  ListViewController.swift
//  TrainingExe10
//
//  Created by Trung Kien on 7/5/18.
//  Copyright © 2018 Trung Kien. All rights reserved.
//

import UIKit
enum TypeMeida : String{
    case MusicVideo
    case Movie
    case Ebook
    case Audiobook
    case Podcast
}

class ListViewController: UIViewController , UITableViewDataSource, UITableViewDelegate, DataDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    var arrMedia = [Media]()
    
    var typeMedia : TypeMeida?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
         NetworkManager.InStance.delegate = self
        if let type = typeMedia{
            switch type{
            case .MusicVideo:
                print("music vieo")
                NetworkManager.InStance.getData(type: "musicVideo" )
                break
            case .Movie:
                print("movie")
                NetworkManager.InStance.getData(type: "movie" )
                break
            case .Ebook:
                NetworkManager.InStance.getData(type: "ebook" )
                break
            case .Audiobook:
                NetworkManager.InStance.getData(type: "audiobook" )
                break
            case .Podcast:
                NetworkManager.InStance.getData(type: "podcast" )
                break
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMedia.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell") as! ListTableViewCell
        cell.lbTrackName.text = arrMedia[indexPath.row].trackName
        cell.lbArtistName.text = arrMedia[indexPath.row].artistName
        
        if let urlImg = arrMedia[indexPath.row].artworkUrl100{
            URLSession.shared.dataTask(with: URL(string: urlImg)!) { data, response, error in
                guard
                    let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                    let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                    let data = data, error == nil,
                    let image = UIImage(data: data)
                    else { return }
                DispatchQueue.main.async() {
                    cell.imgThum.image = image
                }
            }.resume()
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func updateData(list: [Media]) {
        arrMedia = list
        tableView.reloadData()
    }

}
