//
//  itemsModel.swift
//  KasperCatch
//
//  Created by Jackeline Lee on 11/18/18.
//  Copyright © 2018 Jackeline Lee. All rights reserved.
//

import Foundation

struct Items: Codable{
    let title : String
    let name : String
    let category : Bool
    let information : String
}

typealias Food = [Items]

class itemsModel {
    
    fileprivate let allItems : Food
    fileprivate let itemByInitial : [String:[Items]]
    
    static let sharedInstance = itemsModel()
    
    fileprivate let itemKeys : [String]
    
    fileprivate init() {
        let mainBundle = Bundle.main
        let itemsURL = mainBundle.url(forResource: "items", withExtension: "plist")
        
        do {
            let data = try Data(contentsOf: itemsURL!)
            let decoder = PropertyListDecoder()
            allItems = try decoder.decode(Food.self, from: data)
            
            var _itemByInitial = [String:[Items]]()
            for item in allItems {
                let letter = item.name.firstLetter()!
                if _itemByInitial[letter]?.append(item) == nil{
                    _itemByInitial[letter] = [item]
                }
            }
            itemByInitial = _itemByInitial
            itemKeys = itemByInitial.keys.sorted()
            
        } catch {
            print(error)
            allItems = []
            itemByInitial = [:]
            itemKeys = []
        }
    }
    var numberOfItems : Int {return allItems.count}
    var numberOfInitials : Int {return itemKeys.count}
    var score = 0
    var playerScore = 0
    var opponentScore = 0
    
    func setScore(_ value: Int){
        score = value
    }
    
    func getScore()-> Int{
        return score
    }
    
    func setPlayerScore(_ value: Int){
        playerScore = value
    }
    
    func getPlayerScore()-> Int{
        return playerScore
    }
    
    func setOpponentScore(_ value: Int){
        opponentScore = value
    }
    
    func getOpponentScore()-> Int{
        return opponentScore
    }
    
    func numberOfValuesForKey(atIndex index: Int)-> Int {
        let key = itemKeys[index]
        let items = itemByInitial[key]!
        return items.count
    }
    
    func anItem(at index: Int) -> Items {
        let theItem = allItems[index]
        return theItem
    }
    func item(at indexPath: IndexPath)-> Items{
        let key = itemKeys[indexPath.section]
        let items = itemByInitial[key]!
        let theItem = items[indexPath.row]
        return theItem
    }
    
    func itemTitle(at index: Int) -> String {
        let theItem = anItem(at: index)
        return theItem.title
    }
    
    func itemImage(at index: Int) -> String {
        let theItem = anItem(at: index)
        return theItem.name
    }
    
    func itemCategory(at index: Int) -> Bool {
        let theItem = anItem(at: index)
        return theItem.category
    }
    
    func itemInformation(at index: Int) -> String {
        let theItem = anItem(at: index)
        return theItem.information
    }
    
    //Indexpath
    func itemTitle(at indexPath: IndexPath) -> String {
        let theItem = item(at: indexPath)
        return theItem.title
    }
    
    func itemImage(at indexPath: IndexPath) -> String {
        let theItem = item(at: indexPath)
        return theItem.name
    }
    
    func itemCategory(at indexPath: IndexPath) -> Bool {
        let theItem = item(at: indexPath)
        return theItem.category
    }
    
    func itemInformation(at indexPath: IndexPath) -> String {
        let theItem = item(at: indexPath)
        return theItem.information
    }
    
    var itemIndexTitles : [String] {return itemKeys}
    func itemIndexTitle(forIndex index: Int) -> String{
        return itemKeys[index]
    }
}
