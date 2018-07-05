//
//  NetWorkManager.swift
//  TrainingExe10
//
//  Created by Trung Kien on 7/5/18.
//  Copyright © 2018 Trung Kien. All rights reserved.
//

import Foundation
//
//  LoadData.swift
//  TrainingExe89
//
//  Created by Trung Kien on 7/4/18.
//  Copyright © 2018 Trung Kien. All rights reserved.
//

import Foundation

protocol DataDelegate {
    func updateData(list : [Media])
}

class NetworkManager {
    private static let _instance = NetworkManager()
    var delegate : DataDelegate?
    var didLoadData: ((_ list : [Media]) -> Void)?
    
    static var InStance: NetworkManager {
        return _instance
    }
    
    func getData(type: String){
        var arr = [Media]()
        
//        var escapedString = key.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        var urlPath = "https://itunes.apple.com/search?term=?&amp;media=\(type)"
        
        let urlRequest = URLRequest(url: URL(string: urlPath)!)
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            guard error == nil else{ return }
            guard let responseData = data else{ return }
            do{
                if let json = try JSONSerialization.jsonObject(with: responseData, options: .allowFragments) as? [String: Any]{
                    let arrData = json["results"] as? [[String: Any]] ?? []
                    for i in 0..<arrData.count{
                        var m = Media(json: arrData[i])
                        arr.append(m)
                    }
                    DispatchQueue.main.async {
                        self.delegate?.updateData(list: arr)
                    }
                }
            }
            catch{
                
            }
        }
        
        task.resume()
        
    }

}
