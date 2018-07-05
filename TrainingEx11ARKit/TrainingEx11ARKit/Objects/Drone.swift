//
//  Drone.swift
//  TrainingEx11ARKit
//
//  Created by Trung Kien on 7/5/18.
//  Copyright © 2018 Trung Kien. All rights reserved.
//

import Foundation
import ARKit

class Drone: SCNNode {
    func loadModel() {
        guard let virtualObjectScene = SCNScene(named: "Drone.scn") else { return }
        let wrapperNode = SCNNode()
        for child in virtualObjectScene.rootNode.childNodes {
            wrapperNode.addChildNode(child)
        }
        addChildNode(wrapperNode)
    }
    
 
}
