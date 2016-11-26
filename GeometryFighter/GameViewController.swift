//
//  GameViewController.swift
//  GeometryFighter
//
//  Created by Todd William Crone on 11/26/16.
//  Copyright © 2016 Todd William Crone. All rights reserved.
//

import UIKit
import SceneKit

class GameViewController: UIViewController {

    var scnView: SCNView!
    var scnScene: SCNScene!
    var cameraNode: SCNNode!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupScene()
        setupCamera()
        spawnShape()
    }

    override var shouldAutorotate: Bool {
        return true
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func setupView() {
        scnView = self.view as! SCNView
        scnView.showsStatistics = true
        scnView.allowsCameraControl = true
        scnView.autoenablesDefaultLighting = true
    }

    func setupScene() {
        scnScene = SCNScene()
        scnView.scene = scnScene
        scnScene.background.contents = "GeometryFighter.scnassets/Textures/Background_Diffuse.png"
    }
    
    func setupCamera() {
        cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 10)
        scnScene.rootNode.addChildNode(cameraNode)
    }
    
    func spawnShape() {
        var geometry: SCNGeometry
        switch ShapeType.random() {
            case ShapeType.torus:
                geometry = SCNTorus()
                break
            case ShapeType.capsule:
                geometry = SCNCapsule()
                break
            case ShapeType.cone:
                geometry = SCNCone()
                break
            case ShapeType.cylinder:
                geometry = SCNCylinder()
                break
            case ShapeType.sphere:
                geometry = SCNSphere(radius: 1.0)
                break
            default:
                geometry = SCNBox(width: 1.0, height: 1.0, length: 1.0, chamferRadius: 0.0)
        }
        let geometryNode = SCNNode(geometry: geometry)
        scnScene.rootNode.addChildNode(geometryNode)
    }
}
