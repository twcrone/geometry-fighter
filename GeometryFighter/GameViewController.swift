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
        cameraNode.position = SCNVector3(x: 0, y: 5, z: 10)
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
            
        case ShapeType.tube:
            geometry = SCNTube()
            break

        case ShapeType.pyramid:
            geometry = SCNPyramid()
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
        geometry.materials.first?.diffuse.contents = UIColor.random()
        let geometryNode = SCNNode(geometry: geometry)
        geometryNode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
        let randomX = Float.random(min: -2, max: 2)
        let randomY = Float.random(min: 10, max: 18)
        let force = SCNVector3(x: randomX, y: randomY, z: 0)
        let position = SCNVector3(x: 0.05, y: 0.05, z: 0.05)
        geometryNode.physicsBody?.applyForce(force, at: position, asImpulse: true)
        scnScene.rootNode.addChildNode(geometryNode)
    }
}
