//
//  ViewController.swift
//  TrainingExe89
//
//  Created by Trung Kien on 7/4/18.
//  Copyright © 2018 Trung Kien. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate , UISearchBarDelegate, DataDelegate{
    
    
    func updateData(list: [Music]) {
        arrMusic = list
        tableView.reloadData()
    }
    

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var arrMusic = [Music]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        
         let name = Notification.Name(rawValue: "SENDDATA")
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: name, object: nil)
        
//        NetworkManager.InStance.delegate = self
//        NetworkManager.InStance.didLoadData = {
//            self.tableView.reloadData()
//        }
        
           NetworkManager.InStance.didLoadData = { (list: [Music]) -> Void in
            self.arrMusic = list
            self.tableView.reloadData()
        }
        

    }
    
    @objc func reload(sender : Notification){
        let list = sender.object as! [Music]
        arrMusic = list
        tableView.reloadData()
        
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMusic.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListMusicViewCell") as! ListMusicViewCell
        cell.lbArtist.text = arrMusic[indexPath.row].artistName
        cell.lbName.text = arrMusic[indexPath.row].trackName
        cell.lbTime.text = "\(arrMusic[indexPath.row].trackTimeMillis!)"
        if let urlImg = arrMusic[indexPath.row].artworkUrl100{
            URLSession.shared.dataTask(with: URL(string: urlImg)!) { data, response, error in
                guard
                    let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                    let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                    let data = data, error == nil,
                    let image = UIImage(data: data)
                    else { return }
                DispatchQueue.main.async() {
                    cell.imageThum.image = image
                }
                }.resume()
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func getData(key: String){
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
                        print(music.artistName)
                        self.arrMusic.append(music)
                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }

                }
            }
            catch{

            }
        }

        task.resume()

    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
//        getData(key: searchBar.text!) // gọi load bình thườnh
//        NetworkManager.InStance.getData(key: searchBar.text!) // sử dụng delegate
//        NetworkManager.InStance.getDataWithClosure(key: searchBar.text!) // sử dụng closeure
        NetworkManager.InStance.getDataWithNotification(key: searchBar.text!)
        view.endEditing(false)
    }
    



}

