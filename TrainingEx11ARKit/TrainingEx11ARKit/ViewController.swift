//
//  ViewController.swift
//  TrainingEx11ARKit
//
//  Created by Trung Kien on 7/5/18.
//  Copyright © 2018 Trung Kien. All rights reserved.
//

import UIKit
import ARKit

let kStartingPosition = SCNVector3(0, 0, -0.6)
let kAnimationDurationMoving: TimeInterval = 0.2
let kMovingLengthPerLoop: CGFloat = 0.05
let kRotationRadianPerLoop: CGFloat = 0.2

class ViewController: UIViewController {

    @IBOutlet weak var sceneView: ARSCNView!
    
    
    var drone = Drone()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScene()
        print("load 2")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("load1")
        
        setupConfiguration()
        addDrone()
    }
    
    func addDrone() {
        drone.loadModel()
        drone.position = kStartingPosition
        drone.rotation = SCNVector4Zero
        sceneView.scene.rootNode.addChildNode(drone)
    }
    
    func setupScene() {
        let scene = SCNScene()
        sceneView.scene = scene
    }
    
    func setupConfiguration() {
        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration)
    }
}

