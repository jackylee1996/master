//
//  itemInfoViewController.swift
//  KasperCatch
//
//  Created by Jackeline Lee on 11/22/18.
//  Copyright © 2018 Jackeline Lee. All rights reserved.
//

import UIKit

class itemInfoViewController: UIViewController {

    @IBOutlet weak var itemTitle: UILabel!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemInfo: UITextView!
    var aTitle : String?
    var image : String?
    var info: String?
    var category : Bool?
    override func viewDidLoad() {
        super.viewDidLoad()
        itemTitle.text = aTitle
        itemImage.image = UIImage(named: image!)
        itemInfo.text = info
        if category == true {
            view.backgroundColor = UIColor.green
        } else {
            view.backgroundColor = UIColor.red
        }

        // Do any additional setup after loading the view.
    }
    
    func configure(with title: String, image anImage: String, info: String, category: Bool){
        self.aTitle = title
        self.image = anImage
        self.info = info
        self.category = category
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
