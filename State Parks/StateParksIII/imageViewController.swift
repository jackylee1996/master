//
//  imageViewController.swift
//  State Parks
//
//  Created by Jackeline Lee on 10/8/18.
//  Copyright © 2018 Jackeline Lee. All rights reserved.
//

import UIKit

class imageViewController: UIViewController {
    

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var imageTitle: UILabel!
    
    var imageInfo = String()
    var caption = String()
    var pageTitle = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = pageTitle
        configure()

        // Do any additional setup after loading the view.
    }

    func configure(){
        image.image = UIImage(named: imageInfo)
        imageTitle.text = caption
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
