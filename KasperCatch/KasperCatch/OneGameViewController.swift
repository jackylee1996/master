//
//  1PGameViewController.swift
//  KasperCatch
//
//  Created by Jackeline Lee on 11/15/18.
//  Copyright © 2018 Jackeline Lee. All rights reserved.
//

import UIKit
import SpriteKit

class OneGameViewController: UIViewController{

    var dogString : String?
    override func viewDidLoad() {
        super.viewDidLoad()

        let scene = GameSceneOne(size: view.bounds.size, dogName: dogString!)
        let skView = view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        scene.scaleMode = .resizeFill
        skView.presentScene(scene)
    }

    func configure(with dogName: String){
        self.dogString = dogName
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
   
}
