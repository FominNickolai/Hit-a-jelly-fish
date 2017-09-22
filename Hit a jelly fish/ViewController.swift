//
//  ViewController.swift
//  Hit a jelly fish
//
//  Created by Fomin Nickolai on 22.09.17.
//  Copyright © 2017 Fomin Nickolai. All rights reserved.
//

import UIKit
import ARKit
import Each

class ViewController: UIViewController {
    
    //MARK: - @IBOutlets
    
    @IBOutlet weak var sceneView: ARSCNView!
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    
    //MARK: - Properties
    
    let configuration = ARWorldTrackingConfiguration()
    var timer = Each(1).seconds
    var countDown = 10
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        self.sceneView.autoenablesDefaultLighting = true
        self.sceneView.session.run(configuration, options: [])
        
        //Tap Gesture
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        self.sceneView.addGestureRecognizer(tapGestureRecognizer)
    }


    //MARK: - @IBActions
    
    @IBAction func playPressed(_ sender: UIButton) {
        setTimer()
        addNode()
        self.playBtn.isEnabled = false
    }
    
    @IBAction func resetPressed(_ sender: UIButton) {
        
        self.timer.stop()
        self.restoreTimer()
        self.playBtn.isEnabled = true
        
        self.sceneView.scene.rootNode.enumerateChildNodes { (node, _) in
            node.removeFromParentNode()
        }
        
    }
    
    //MARK: Helpers
    
    func addNode() {
        let jellyFishScene = SCNScene(named: "art.scnassets/Jellyfish.scn")
        let jellyFishNode = jellyFishScene?.rootNode.childNode(withName: "Jellyfish", recursively: false)
        let x = randomNumbers(fristNum: -1, secondNum: 1)
        let y = randomNumbers(fristNum: -0.5, secondNum: 0.5)
        let z = randomNumbers(fristNum: -1, secondNum: 1)
        jellyFishNode?.position = SCNVector3(x, y, z)
        self.sceneView.scene.rootNode.addChildNode(jellyFishNode!)
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer) {
        
        let sceneViewTappedOn = sender.view as! SCNView
        let touchCoordinates = sender.location(in: sceneViewTappedOn)
        let hitTest = sceneViewTappedOn.hitTest(touchCoordinates, options: nil)
        
        if hitTest.isEmpty {
            print("didn't touch anything")
        } else {
            
            if countDown > 0 {
                let results = hitTest.first!
                let node = results.node
                if node.animationKeys.isEmpty {
                    //Отслеживание окончания анимации
                    SCNTransaction.begin()
                    self.animateNode(node: node)
                    SCNTransaction.completionBlock = {
                        //удаляем после окончания анимации
                        node.removeFromParentNode()
                        self.addNode()
                        self.restoreTimer()
                    }
                    SCNTransaction.commit()
                    
                }
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
    
    func setTimer() {
        
        self.timer.perform { () -> NextStep in
            self.countDown -= 1
            self.timerLabel.text = "\(self.countDown)"
            if self.countDown == 0 {
                self.timerLabel.text = "You Lose!"
                return .stop
            }
            return .continue
        }
        
    }
    
    func restoreTimer() {
        self.countDown = 10
        self.timerLabel.text = "\(self.countDown)"
    }
    
    //Random value in Range
    func randomNumbers(fristNum: CGFloat, secondNum: CGFloat) -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(fristNum - secondNum) + min(fristNum, secondNum)
    }
    
}

















