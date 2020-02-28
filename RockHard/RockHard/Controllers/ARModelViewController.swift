//
//  3DModelViewController.swift
//  RockHard
//
//  Created by Anthony Gonzalez on 2/28/20.
//  Copyright © 2020 Rockstars. All rights reserved.
//

import Foundation
import UIKit
import SceneKit
import ARKit

class ARModelViewController: UIViewController, ARSCNViewDelegate {
    
    private var hud: MBProgressHUD!
    var sceneView: ARSCNView!
    
//    @IBOutlet var sceneView: ARSCNView!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView = ARSCNView()

       
        self.view.addSubview(sceneView)

        sceneView.translatesAutoresizingMaskIntoConstraints = false
        sceneView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        sceneView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        sceneView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        sceneView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        sceneView.contentMode = .scaleAspectFill
        
    
        self.hud = MBProgressHUD.showAdded(to: self.sceneView, animated: true)
        
        self.hud.label.text = "Detecting plane..."
        
        sceneView.autoenablesDefaultLighting = true
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        let scene = SCNScene()
        
        //        let gymModelScene = SCNScene(named: "testModel.scn")
        //        guard let gymModelNode = gymModelScene?.rootNode.childNode(withName: "testModel", recursively: true) else { fatalError("Model not found")}
        //
        //
        //
        //        gymModelNode.position = SCNVector3(0, -2, -3.0)
        //        scene.rootNode.addChildNode(gymModelNode)
        
        // Set the scene to the view
        sceneView.scene = scene
        
        registerGestureRecognizers()
    }
    
    private func registerGestureRecognizers(){
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapped))
        self.sceneView.addGestureRecognizer(tapGestureRecognizer)
        
        let pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(pinched))
        self.sceneView.addGestureRecognizer(pinchGestureRecognizer)
        
//        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panned))
//        self.sceneView.addGestureRecognizer(panGestureRecognizer)
        
        let rotationGestureRecognizer = UIRotationGestureRecognizer(target: self, action: #selector(rotated))
        self.sceneView.addGestureRecognizer(rotationGestureRecognizer)
    }
    
    @objc private func rotated(recognizer: UIRotationGestureRecognizer) {
        let rotation = Float(recognizer.rotation)
        var currentAngleY: Float = 0.0
        var gymModelNode = SCNNode()

        if recognizer.state == .changed {
            guard let sceneView = recognizer.view as? ARSCNView else { return }
            let touch = recognizer.location(in: sceneView)
            let hitTestResults = self.sceneView.hitTest(touch, options: nil)

            if let hitTest = hitTestResults.first {
                gymModelNode = hitTest.node

                gymModelNode.eulerAngles.y = currentAngleY + rotation
            }

            if recognizer.state == .ended {
                currentAngleY = gymModelNode.eulerAngles.y
            }
        }
    }
    
//    @objc private func panned(recognizer: UIPanGestureRecognizer){
//
//        var currentAngleY: Float = 0.0
//        if recognizer.state == .changed {
//            guard let sceneView = recognizer.view as? ARSCNView else { return }
//
//            let touch = recognizer.location(in: sceneView)
//            let hitTestResults = self.sceneView.hitTest(touch, options: nil)
//
//            if let hitTest = hitTestResults.first {
//                let gymModelNode = hitTest.node
//
//                let translation = recognizer.translation(in: recognizer.view!)
//                     var newAngleY = (Float)(translation.x)*(Float)(Double.pi)/180.0
//                     newAngleY += currentAngleY
//
//                     gymModelNode.eulerAngles.y = newAngleY
//
//                     if(recognizer.state == .ended) { currentAngleY = newAngleY }
//
//                     print(gymModelNode.eulerAngles)
//            }
//        }
//    }
    
    
    @objc private func pinched(recognizer: UIPinchGestureRecognizer){
        
        if recognizer.state == .changed {
            guard let sceneView = recognizer.view as? ARSCNView else { return }
            
            let touch = recognizer.location(in: sceneView)
            
            let hitTestResults = self.sceneView.hitTest(touch, options: nil)
            //The object is already placed in the view, so the .existingPlane initializer isn't used.
            
            if let hitTest = hitTestResults.first {
                let gymModelNode = hitTest.node
                //Creates reference to existing object
                
                let pinchScaleX = Float(recognizer.scale) * gymModelNode.scale.x
                let pinchScaleY = Float(recognizer.scale) * gymModelNode.scale.y
                let pinchScaleZ = Float(recognizer.scale) * gymModelNode.scale.z
                
                gymModelNode.scale = SCNVector3(pinchScaleX, pinchScaleY, pinchScaleZ)
                
                recognizer.scale = 1
                //The original scale must be reset because all the other scales are dependent on this.
            }
        }
        //Runs when pinch zoom/unzooms
    }
    
    @objc private func tapped(recognizer: UITapGestureRecognizer) {
        guard let sceneView = recognizer.view as? ARSCNView else { return }
        
        let touch = recognizer.location(in: sceneView)
        //Coordinate system for iPhone screen (X/Y axis) using a CGPoint.
        
        let hitTestResults = sceneView.hitTest(touch, types: .existingPlane)
        //Uses a hitTest against an existing plane to find out the horizontal surface intersection with where the finger tapped.
        
        if let hitTest = hitTestResults.first {
            let gymModelScene = SCNScene(named: "testModel.scn")
            guard let gymModelNode = gymModelScene?.rootNode.childNode(withName: "testModel", recursively: true) else { fatalError("Model not found") }
            
            gymModelNode.position = SCNVector3(hitTest.worldTransform.columns.3.x, hitTest.worldTransform.columns.3.y, hitTest.worldTransform.columns.3.z)
            //Position of touch in 3D coordinate.
            
            self.sceneView.scene.rootNode.addChildNode(gymModelNode)
        }
        //In order for the method to work as it should, there must be a check to see if the user tapped on a section on the plane.
    }
    //This method is responsible for determining the point the user tapped, and sets the 3D model in that space.
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        DispatchQueue.main.async {
            if anchor is ARPlaneAnchor {
                self.hud.label.text = "Plane detected"
                self.hud.hide(animated: true, afterDelay: 1.0)
            }
        }
    }
    //Method that is run when plane is detected.
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        //Looks for a horizontal surface to detect. Denotes that a virtual object is able to be placed here.
        
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
}

