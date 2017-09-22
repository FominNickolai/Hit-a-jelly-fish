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
    }


    //MARK: - @IBActions
    
    @IBAction func playPressed(_ sender: UIButton) {
        
        
        
    }
    
    @IBAction func resetPressed(_ sender: UIButton) {
        
        
        
    }
}

