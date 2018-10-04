//
//  ViewController.swift
//  ArKitApps
//
//  Created by zindal on 24/09/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {

    @IBOutlet weak var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBox()
        addTapGestureToSceneView()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration)
        
        /* method, we initialized the an AR configuration called ARWorldTrackingConfiguration. This is a configuration for running world tracking.
         The world tracking configuration tracks the device’s orientation and position. It also detects real-world surfaces seen through the device’s camera.
         
         Now we set the sceneView’s AR session to run the configuration we just initialized. The AR session manages motion tracking and camera image processing for the view’s contents.*/
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
        
/*In the viewWillDisappear(_:) method, we simply tell our AR session to stop tracking motion and processing image for the view’s content.
 
*/
    }
    
    func addBox() {
        let box = SCNBox(width: 0.05, height: 0.05, length: 0.05, chamferRadius: 0)
        
        let boxNode = SCNNode()
        boxNode.geometry = box
        boxNode.position = SCNVector3(0,0, -0.25)
        
        let scene = SCNScene()
        scene.rootNode.addChildNode(boxNode)
        sceneView.scene = scene
        
/*Here’s what we did.
 
 We begin by creating a box shape. 1 Float = 1 meter.
 
 After that, we create a node. A node represents the position and the coordinates of an object in a 3D space. By itself, the node has no visible content.
 
 We can give the node a visible content by giving it a shape. We do this by setting the node’s geometry to the box.
 
 Afterwards, we give our node a position. This position is relative to the camera. Positive x is to the right. Negative x is to the left. Positive y is up. Negative y is down. Positive z is backward. Negative z is forward.
 
 Then we create a scene. This is the SceneKit scene to be displayed in the view. We then add our box node to the root node of the scene. A root node in a scene that defines the coordinate system of the real world rendered by SceneKit.
 
 Basically, our scene now has a box. The box is centered to the device’s camera. It is 0.20 meter forward relative to the camera.
 
 Finally, we set our sceneView’s scene to display the scene we just created.*/
        
        
    }
    
    func addTapGestureToSceneView() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.didTap(withGestureRecognizer:)))
        sceneView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func didTap(withGestureRecognizer recognizer: UIGestureRecognizer) {
        let tapLocation = recognizer.location(in: sceneView)
        let hitTestResults = sceneView.hitTest(tapLocation)
        guard let node = hitTestResults.first?.node else { return }
        node.removeFromParentNode()
    }
}

