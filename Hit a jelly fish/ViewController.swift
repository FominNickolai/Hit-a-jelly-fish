//
//  ViewController.swift
//  Hit a jelly fish
//
//  Created by Fomin Nickolai on 22.09.17.
//  Copyright © 2017 Fomin Nickolai. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {
    
    //MARK: - @IBOutlets
    
    @IBOutlet weak var sceneView: ARSCNView!
    @IBOutlet weak var playBtn: UIButton!
    
    //MARK: - Properties
    
    let configuration = ARWorldTrackingConfiguration()
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        self.sceneView.autoenablesDefaultLighting = true
        self.sceneView.session.run(configuration, options: [])
        
        //Tap Gesture
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        self.sceneView.addGestureRecognizer(tapGestureRecognizer)
    }


    //MARK: - @IBActions
    
    @IBAction func playPressed(_ sender: UIButton) {
        addNode()
        self.playBtn.isEnabled = false
    }
    
    @IBAction func resetPressed(_ sender: UIButton) {
        
        
        
    }
    
    //MARK: Helpers
    
    func addNode() {
        let jellyFishScene = SCNScene(named: "art.scnassets/Jellyfish.scn")
        let jellyFishNode = jellyFishScene?.rootNode.childNode(withName: "Jellyfish", recursively: false)
        jellyFishNode?.position = SCNVector3(0, 0, -1)
        self.sceneView.scene.rootNode.addChildNode(jellyFishNode!)
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer) {
        
        let sceneViewTappedOn = sender.view as! SCNView
        let touchCoordinates = sender.location(in: sceneViewTappedOn)
        let hitTest = sceneViewTappedOn.hitTest(touchCoordinates, options: nil)
        
        if hitTest.isEmpty {
            print("didn't touch anything")
        } else {
            
            let results = hitTest.first!
            let node = results.node
            if node.animationKeys.isEmpty {
                self.animateNode(node: node)
            }
        }
        
    }
    
    func animateNode(node: SCNNode) {
        let spin = CABasicAnimation(keyPath: "position")
        //presentation - текущая позиция на экране
        spin.fromValue = node.presentation.position
        //от текущей позици минус 0.2 во всех направлениях
        spin.toValue = SCNVector3(node.presentation.position.x - 0.2, node.presentation.position.y - 0.2, node.presentation.position.z - 0.2)
        //длительность анимации
        spin.duration = 0.07
        //autoreverses - возвращается в текущую позицию после анимирования(анимированно)
        spin.autoreverses = true
        //количество повторений анимации
        spin.repeatCount = 5
        //addAnimation - добавление анимации
        node.addAnimation(spin, forKey: "position")
    }
    
}















