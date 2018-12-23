//
//  ViewController.swift
//  KasperCatch
//
//  Created by Jackeline Lee on 10/28/18.
//  Copyright © 2018 Jackeline Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func back(segue:UIStoryboardSegue) {
        dismiss(animated: true, completion: nil)
    }

}

