//
//  CollectionViewController.swift
//  State Parks
//
//  Created by Jackeline Lee on 10/2/18.
//  Copyright © 2018 Jackeline Lee. All rights reserved.
//
import Foundation
import UIKit

private let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController {

    let parkModel = StateParkModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView?.backgroundColor = UIColor.white
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        //self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return parkModel.parkCount()
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return parkModel.imageCount(index: section)
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //self.collectionView!.register(CollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        
        // Configure the cell
        let imageName = parkModel.imageName(index: indexPath.section, index: indexPath.row)
        let parkImage = UIImage(named: imageName)
        cell.parkImage.image = parkImage
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionElementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "parkHeader", for: indexPath) as! CollectionReusableView
            headerView.backgroundColor = UIColor.lightGray
            headerView.headerTitle.text = parkModel.parkName(index: indexPath.section)
            return headerView
        default:
            assert(false, "Unexpected element kind")
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let scrollView = UIScrollView()
        let scrollImage = UIImageView(image: UIImage(named: parkModel.imageName(index: indexPath.section, index: indexPath.row)))
        let frameSize = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2)
        scrollView.backgroundColor = UIColor.white
        scrollView.bounds.size = UIScreen.main.bounds.size
        scrollView.bounds.size.width = UIScreen.main.bounds.size.width
        scrollImage.bounds.size.width = scrollView.bounds.size.width
        scrollImage.contentMode = .scaleAspectFit
        scrollView.center = frameSize
        scrollImage.center = scrollView.center
        scrollView.addSubview(scrollImage)
        self.view.superview?.addSubview(scrollView)
        
//        let tapImage = UITapGestureRecognizer(target: self, action: #selector(TableViewController.onTap(_:)))
//        tapImage.numberOfTapsRequired = 1
//        scrollView.addGestureRecognizer(tapImage)
//        scrollView.isUserInteractionEnabled = true
//
        
        
    }
    @objc func onTap(_ sender: UIGestureRecognizer){
        let tap = sender.view!
        tap.removeFromSuperview()
    }
    
    
    

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
