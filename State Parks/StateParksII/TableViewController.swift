//
//  TableViewController.swift
//  State Parks
//
//  Created by Jackeline Lee on 10/1/18.
//  Copyright © 2018 Jackeline Lee. All rights reserved.
//

import Foundation
import UIKit

class TableViewController : UITableViewController {
    let parkModel = StateParkModel()
    let rowHeight = CGFloat(60)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.sectionIndexColor = UIColor.darkGray
        tableView.sectionIndexBackgroundColor = UIColor.lightGray
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return parkModel.parkCount()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return parkModel.collapsed(index: section) ? 0 : parkModel.imageCount(index: section)
        return parkModel.imageCount(index: section)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowHeight
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return parkModel.parkName(index: section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as! TableViewCell
        
        cell.parkTitle.text = parkModel.caption(index: indexPath.section, index: indexPath.row)
        let imageName = parkModel.imageName(index: indexPath.section, index: indexPath.row)
        let parkImage = UIImage(named: imageName)
        cell.parkImage.image = parkImage
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerView = view as? UITableViewHeaderFooterView {
            headerView.contentView.backgroundColor = UIColor.blue
            headerView.textLabel?.textColor = UIColor.white
        }
    }

    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //FOR STATE PARKS II
        performSegue(withIdentifier: "showImage", sender: self)
    }
    
//        let scrollView = UIScrollView()
//        let scrollImage = UIImageView(image: UIImage(named: parkModel.imageName(index: indexPath.section, index: indexPath.row)))
//        let frameSize = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2)
//        scrollView.backgroundColor = UIColor.white
//        scrollView.bounds.size = UIScreen.main.bounds.size
//        scrollView.bounds.size.width = UIScreen.main.bounds.size.width
//        scrollImage.bounds.size.width = scrollView.bounds.size.width
//        scrollImage.contentMode = .scaleAspectFit
//        scrollView.center = frameSize
//        scrollImage.center = scrollView.center
//        scrollView.addSubview(scrollImage)
//        self.view.superview?.addSubview(scrollView)
//
//        let tapImage = UITapGestureRecognizer(target: self, action: #selector(TableViewController.onTap(_:)))
//        tapImage.numberOfTapsRequired = 1
//        scrollView.addGestureRecognizer(tapImage)
//        scrollView.isUserInteractionEnabled = true


//
//    }
//    @objc func onTap(_ sender: UIGestureRecognizer){
//        let tap = sender.view!
//        tap.removeFromSuperview()
//    }
    
//    @objc func headerTouch(_ sender: UIGestureRecognizer){
//        let touch = sender.view! as! UITableViewHeaderFooterView
//
//
//    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "showImage"{
            //navigationItem.title = "Back"

            if let indexPath = tableView.indexPathForSelectedRow{
                let viewController = (segue.destination as! UINavigationController).topViewController as! imageViewController
                viewController.navigationItem.title = "Back"
                viewController.caption = parkModel.caption(index: indexPath.section, index: indexPath.row)
                viewController.imageInfo = parkModel.imageName(index: indexPath.section, index: indexPath.row)
                viewController.pageTitle = parkModel.parkName(index: indexPath.section)
                tableView.deselectRow(at: indexPath, animated: false)
            }

        }
    }

}
//extension TableViewController: CollapsibleTableViewHeaderDelegate {
//
//    func toggleSection(_ header: CollapsibleTableViewHeader, section: Int) {
//        let collapse = !parkModel.collapsed(index: section)
//
//        // Toggle collapse
//        parkModel.collapsed(index: section) = collapse
//
//        tableView.reloadSections(NSIndexSet(index: section) as IndexSet, with: .automatic)
//    }
//
//}
