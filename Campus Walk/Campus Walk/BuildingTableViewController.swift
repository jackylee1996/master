//
//  BuildingTableViewController.swift
//  Campus Walk
//
//  Created by Jackeline Lee on 10/15/18.
//  Copyright © 2018 Jackeline Lee. All rights reserved.
//

import UIKit
protocol BuildingDelegate {
    func addPin(indexPath: IndexPath)
    func removePin(indexPath: IndexPath)
    func favorite(indexPath: IndexPath)
}
class BuildingTableViewController: UITableViewController, UISearchControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate {
    
    let mapModel = MapModel.sharedInstance
    var delegate : BuildingDelegate?
    var isFavorite = [Bool](repeating: false, count: 364)
    var favCount = Int()
    var isSearching = false
    var currentlySearching : Bool { return searchController.isActive && !(searchController.searchBar.text?.isEmpty ?? true)}
    
    //Search
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "All Buildings"
        
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        searchController.searchBar.placeholder = "Search Here!"
        self.definesPresentationContext = true
        searchController.searchBar.scopeButtonTitles = ["All","Building","Year"]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        switch selectedScope{
        case 0:
            searchBar.keyboardType = UIKeyboardType.default
        case 1:
            searchBar.keyboardType = UIKeyboardType.default
        case 2:
            searchBar.keyboardType = UIKeyboardType.numberPad
        default:
            break
        }
        
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        let filter = {(building: Maps) in true}
        mapModel.updateFilter(filter: filter)
        tableView.reloadData()
    }
    
    //textViewdidendediting
    
    
    
    func updateSearchResults(for searchController: UISearchController) {
        let text = searchController.searchBar.text!
        if !text.isEmpty {
            let filter = {(building: Maps) in building.name.lowercased().contains(text.lowercased())}
            mapModel.updateFilter(filter: filter)
            tableView.reloadData()
        }
    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        print("Count: \(mapModel.allBuildings.count)")
        if currentlySearching {
            return mapModel.allBuildings.count
        }
        return mapModel.numberOfInitials
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if currentlySearching {
            return mapModel.allBuildings.count
        }
        return mapModel.numberOfValuesForKey(atIndex: section)
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Buildings", for: indexPath) as! BuildingTableViewCell
        
        
        
        let starButton = UIButton(type: .system)
        starButton.setImage(#imageLiteral(resourceName: "star"), for: .normal)
        starButton.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        starButton.tintColor = UIColor.gray
        starButton.tag = favCount
        favCount = favCount + 1
        
        starButton.addTarget(self, action: #selector(markFavorite), for: .touchUpInside)
        if currentlySearching {
            print(mapModel.buildings[indexPath.row].name)
            cell.buildingCell.text = mapModel.buildings[indexPath.row].name
        }else{
            cell.buildingCell.text = mapModel.buildingTitle(at: indexPath)
        }
        cell.accessoryView = starButton
        
        return cell
    }
    
    @objc func markFavorite(_ sender: UIButton){
        if sender.tintColor == UIColor.gray {
            sender.tintColor = UIColor.sexyYellow
        }
        else {
            sender.tintColor = UIColor.gray
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
    
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if currentlySearching {
            return nil
        }
        return mapModel.buildingIndexTitles[section]
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        if currentlySearching {
            return nil
        }
        return mapModel.buildingIndexTitles
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerView = view as? UITableViewHeaderFooterView {
            headerView.contentView.backgroundColor = UIColor.babyPink
            headerView.textLabel?.textColor = UIColor.white
        }
    }
    
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let addPin = UITableViewRowAction(style: .normal, title: "Add") { (rowAction, indexPath) in
            self.delegate?.addPin(indexPath: indexPath)
            
        }
        let removePin = UITableViewRowAction(style: .normal, title: "Remove") { (rowAction, indexPath) in
            self.delegate?.removePin(indexPath: indexPath)
        }
        addPin.backgroundColor = UIColor.blue
        removePin.backgroundColor = UIColor.red
        return [addPin, removePin]
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "showImage"{
            
            if let indexPath = tableView.indexPathForSelectedRow{
                let viewController = (segue.destination as! UINavigationController).topViewController as! imageViewController
                viewController.navigationItem.title = "Back"
                viewController.indexNum = indexPath
                viewController.image = mapModel.buildingPhoto(at: indexPath)
                viewController.imageTitle = mapModel.buildingTitle(at: indexPath)
                viewController.imageYear = mapModel.buildingYear(at: indexPath)
                tableView.deselectRow(at: indexPath, animated: false)
            }
            
        }
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
