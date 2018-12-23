//
//  MapModel.swift
//  Campus Walk
//
//  Created by Jackeline Lee on 10/14/18.
//  Copyright © 2018 Jackeline Lee. All rights reserved.
//

import Foundation
import MapKit

//class Place : NSObject, MKAnnotation {
//    let coordinate: CLLocationCoordinate2D
//    let title : String?
//    let year : Int
//    init(title:String, coordinate:CLLocationCoordinate2D, year: Int) {
//        self.title = title
//        self.coordinate = coordinate
//        self.year = year
//    }
//    
//    var mapItem : MKMapItem {
//        let placeMark = MKPlacemark(coordinate: coordinate)
//        let item = MKMapItem(placemark: placeMark)
//        return item
//    }
//}

struct Maps: Codable {
    let name : String
    let opp_bldg_code : Int
    let year_constructed : Int
    let latitude: Double
    let longitude: Double
    let photo : String
    var info : String = ""
    
    var full : String {return name + " " + String(year_constructed)}
    
    enum CodingKeys : String, CodingKey {
        case name
        case opp_bldg_code
        case year_constructed
        case latitude
        case longitude
        case photo
    }
}

typealias CampusMap = [Maps]

class MapModel {
    var allBuildings : CampusMap
    var buildings : CampusMap
    fileprivate let buildingByInitial : [String:[Maps]]
    
    static let sharedInstance = MapModel()
    
    fileprivate let buildingKeys : [String]
    
    fileprivate init(){
        
        let mainBundle = Bundle.main
        let solutionURL = mainBundle.url(forResource: "buildings", withExtension: "plist")
        
        do {
            let data = try Data(contentsOf: solutionURL!)
            let decoder = PropertyListDecoder()
            allBuildings = try decoder.decode(CampusMap.self, from: data)
            
            var _buildingByInitial = [String:[Maps]]()
            for building in allBuildings{
                let letter = building.name.firstLetter()!
                if _buildingByInitial[letter]?.append(building) == nil {
                    _buildingByInitial[letter] = [building]
                }
            }
            buildingByInitial = _buildingByInitial
            buildingKeys = buildingByInitial.keys.sorted()
        } catch{
            print(error)
            allBuildings = []
            buildingByInitial = [:]
            buildingKeys = []
        }
        buildings = allBuildings
        
    }
    
    var numberOfBuildings : Int {return allBuildings.count}
    
    var numberOfInitials : Int {return buildingKeys.count}
    
    func numberOfValuesForKey(atIndex index: Int) -> Int{
        let key = buildingKeys[index]
        let buildings = buildingByInitial[key]!
        return buildings.count
    }
    
    func aBuilding(at index: Int)->Maps{
        let building = allBuildings[index]
        return building
    }
    
    func building(at indexPath: IndexPath) -> Maps{
        let key = buildingKeys[indexPath.section]
        let buildings = buildingByInitial[key]!
        let theBuilding = buildings[indexPath.row]
        return theBuilding
    }
    
    func buildingTitle(at index: Int) -> String {
        let theBuilding = aBuilding(at: index)
        return theBuilding.name
    }
    
    func buildingTitle(at indexPath: IndexPath) -> String {
        let theBuilding = building(at: indexPath)
        return theBuilding.name
    }
    
    func buildingCode(at index: Int) -> Int {
        let theBuilding = aBuilding(at: index)
        return theBuilding.opp_bldg_code
    }
    
    func buildingCode(at indexPath: IndexPath) -> Int {
        let theBuilding = building(at: indexPath)
        return theBuilding.opp_bldg_code
    }
    
    func buildingYear(at index: Int) -> Int {
        let theBuilding = aBuilding(at: index)
        return theBuilding.year_constructed
    }
    
    func buildingYear(at indexPath: IndexPath) -> Int {
        let theBuilding = building(at: indexPath)
        return theBuilding.year_constructed
    }
    
    
    func buildingLatitude(at index: Int) -> Double {
        let theBuilding = aBuilding(at: index)
        return theBuilding.latitude
    }
    
    func buildingLatitude(at indexPath: IndexPath) -> Double {
        let theBuilding = building(at: indexPath)
        return theBuilding.latitude
    }
    
    func buildingLongitude(at index: Int) -> Double {
        let theBuilding = aBuilding(at: index)
        return theBuilding.longitude
    }
    
    func buildingLongitude(at indexPath: IndexPath) -> Double {
        let theBuilding = building(at: indexPath)
        return theBuilding.longitude
    }
    
    func buildingPhoto(at index: Int) -> String {
        let theBuilding = aBuilding(at: index)
        return theBuilding.photo
    }
    
    func buildingPhoto(at indexPath: IndexPath) -> String {
        let theBuilding = building(at: indexPath)
        return theBuilding.photo
    }
    
    var buildingIndexTitles : [String] {return buildingKeys}
    func buildingIndexTitle(forIndex index:Int) -> String {
        return buildingKeys[index]
    }
    let initialLocation = CLLocation(latitude: 40.800523, longitude: -77.861700)

    func getBuilding(at indexPath: IndexPath)-> Maps {
        let theBuilding = building(at: indexPath)
        return theBuilding
    }
    
    func updateFilter(filter: (Maps) -> Bool){
        allBuildings = buildings.filter(filter)
    }
}
