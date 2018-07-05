//
//  ViewController2.swift
//  TrainingExe6
//
//  Created by Trung Kien on 7/4/18.
//  Copyright © 2018 Trung Kien. All rights reserved.
//

import UIKit

class ViewController2: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout, UIGestureRecognizerDelegate {

    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var isCorrect = false
    var isOpens = [Bool]()
    var count = 30
    
    var timer = Timer()
    var timerIsOn = true
    var arrImage = [Int]()
    var shuffled = [Int]()
    var numberPrev = -1;
    var indexPathPrev : IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gesture = UITapGestureRecognizer(target: self, action: #selector(handleGesture))
        gesture.delegate = self
        self.view.addGestureRecognizer(gesture)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        slider.maximumValue = 30.0
        slider.minimumValue = 0.0
        if timerIsOn {
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self,      selector: #selector(timerRunning), userInfo: nil, repeats: true)
        }
        ranDom()
        
    }

    func ranDom(){
        for i in 0...5{
            arrImage.append(i)
            isOpens.append(false)
        }
        for i in 0...5{
            arrImage.append(i)
            isOpens.append(false)
        }
        
        for i in 0..<arrImage.count
        {
            let rand = Int(arc4random_uniform(UInt32(arrImage.count)))
            shuffled.append(arrImage[rand])
            arrImage.remove(at: rand)
        }
        
        for i in 0..<shuffled.count{
            print(shuffled[i])
        }
        
        collectionView.reloadData()
        
    }
    
    @objc func timerRunning(){
        count = count - 1
        slider.setValue(Float(count), animated: true)
        if count == 0{
            timerIsOn = false
            timer.invalidate()
            let alert = UIAlertController(title: "Thông báo", message: "You Lose", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
                self.timer.invalidate()
                self.dismiss(animated: true, completion: nil)
            })
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
    }
    
    @objc func handleGesture(gesture: UITapGestureRecognizer) -> Void {
        print("Tapp")
        let location = gesture.location(in: collectionView)
        let indexPath : IndexPath? = collectionView.indexPathForItem(at: location as! CGPoint)
        var cell: CollectionViewCell2? = nil
        
        if let aPath = indexPath {
            cell = collectionView.cellForItem(at: aPath) as! CollectionViewCell2
            if isOpens[aPath.row] == false{
                if numberPrev == -1{
                    numberPrev = aPath.row
                    indexPathPrev = aPath
                    isOpens[aPath.row] = true
                    let image =  UIImage(named: "img\(shuffled[aPath.row])")
                    cell?.image.image = image
                    animation(type: TypeAnimation.Right, view: (cell?.image)!)

                }
                else{
                    // chọn bức thứ 2
                    isOpens[aPath.row] = true
                    let image =  UIImage(named: "img\(shuffled[aPath.row])")
                    cell?.image.image = image
                    animation(type: TypeAnimation.Right, view: (cell?.image)!)
                    
                    
                    if shuffled[aPath.row] == shuffled[numberPrev]{
                        print("Correct")
                        isOpens[aPath.row] = true
                        isOpens[numberPrev] = true
                        if checkWin(){
                            let alert = UIAlertController(title: "Thông báo", message: "You Win", preferredStyle: .alert)
                            let action = UIAlertAction(title: "Thông báo", style: .default, handler: { (UIAlertAction) in
                                self.dismiss(animated: true, completion: nil)
                            })
                            alert.addAction(action)
                            present(alert, animated: true, completion: nil)
                        }
                        
                        numberPrev = -1
                        
                    }
                    else{
                        isOpens[aPath.row] = false
                        isOpens[numberPrev] = false
                        let image =  UIImage(named: "default")
                        cell?.image.image = image
                        animation(type: TypeAnimation.Right, view: (cell?.image)!)
                        
                        
                        let cellPrev = collectionView.cellForItem(at: indexPathPrev!) as! CollectionViewCell2
                        cellPrev.image.image = image
                        animation(type: TypeAnimation.Left, view: (cellPrev.image)!)
                        numberPrev = -1
                    }
                }
                
            }
        
        }
        
    }
    
    
    
    func animation(type : TypeAnimation, view: UIView){
        if type == TypeAnimation.Right{
            UIView.transition(with: view, duration : 0.3  , options: .transitionFlipFromRight, animations: nil, completion: nil)
        }
        else if type == TypeAnimation.Left{
            UIView.transition(with: view, duration : 0.3  , options: .transitionFlipFromLeft, animations: nil, completion: nil)
        }
        else if type == TypeAnimation.Top{
            UIView.transition(with: view, duration : 0.3  , options: .transitionFlipFromTop, animations: nil, completion: nil)
        }
        else{
            UIView.transition(with: view, duration : 0.3  , options: .transitionFlipFromBottom, animations: nil, completion: nil)
        }
    }
    
    func checkWin() -> Bool {
        for i in 0..<isOpens.count{
            if !isOpens[i]{
                return false
            }
        }
        return true
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shuffled.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell2", for: indexPath) as! CollectionViewCell2
        cell.image.image = UIImage(named: "default")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width / 3 - 5, height: view.frame.width / 3 - 5)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5.0
    }




}
