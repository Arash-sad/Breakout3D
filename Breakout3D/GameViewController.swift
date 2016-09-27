//
//  GameViewController.swift
//  Breakout3D
//
//  Created by Arash Sadeghieh E on 26/09/2016.
//  Copyright © 2016 Treepi. All rights reserved.
//

import UIKit
import SceneKit

class GameViewController: UIViewController {

    var scnView: SCNView!
    var scnScene: SCNScene!
    var game = GameHelper.sharedInstance
    
    var horizontalCameraNode: SCNNode!
    var verticalCameraNode: SCNNode!
    var ballNode:SCNNode!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupScene()
        setupNodes()
        setupSounds()
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func setupScene() {
        scnView = self.view as! SCNView
        scnView.delegate = self
        
        scnScene = SCNScene(named: "Breaker.scnassets/Scenes/Game.scn")
        scnView.scene = scnScene
        
    }
    
    func setupNodes() {
        
        scnScene.rootNode.childNode(withName: "HorizontalCamera", recursively: true)!
        scnScene.rootNode.childNode(withName: "VerticalCamera", recursively: true)!
        scnScene.rootNode.childNode(withName: "Ball", recursively: true)!
        
        scnScene.rootNode.addChildNode(game.hudNode)
    }
    
    func setupSounds() {
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        let deviceOrientation = UIDevice.current.orientation
        
        switch(deviceOrientation) {
        case .portrait:
            scnView.pointOfView = verticalCameraNode
        default:
            scnView.pointOfView = horizontalCameraNode
        }
    }

}

extension GameViewController: SCNSceneRendererDelegate {
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        game.updateHUD()
    }
}
