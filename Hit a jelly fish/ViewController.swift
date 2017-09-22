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
            let geometry = results.node.geometry
            
            print("touched a box")
        }
        
    }
    
}















