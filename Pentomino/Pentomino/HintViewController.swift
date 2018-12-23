//
//  HintViewController.swift
//  Pentomino
//
//  Created by Jackeline Lee on 9/17/18.
//  Copyright © 2018 Jackeline Lee. All rights reserved.
//

import UIKit

protocol HintDelegate: class {
    func dismissMe()
}
class HintViewController: UIViewController {
    
    @IBOutlet weak var hintBoard: UIImageView!
    weak var delegate : HintDelegate?
//    var hint : UIImageView!
    var index = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //hintBoard.image =
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let image : UIImage = UIImage(named: "Board\(index)")!
        hintBoard.image = image
    }
    
    
    
//    func configure(with hint: UIImageView!){
//        self.hint = hint
//    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
