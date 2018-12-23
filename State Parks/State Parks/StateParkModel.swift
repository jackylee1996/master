//
//  StateParkModel.swift
//  State Parks
//
//  Created by Jackeline Lee on 10/1/18.
//  Copyright © 2018 Jackeline Lee. All rights reserved.
//

import Foundation

struct Photos: Codable {
    let imageName : String
    let caption : String
}
struct StatePark: Codable {
    let name : String
    let photos : [Photos]
//    var collapsed: Bool
//
//    public init(name: String, items: [Photos], collapsed: Bool = false){
//        self.name = name
//        self.photos = items
//        self.collapsed = collapsed
//    }
}
typealias Parks = [StatePark]

class StateParkModel {
    
    let allParks : Parks
    init () {

        let mainBundle = Bundle.main
        let solutionURL = mainBundle.url(forResource: "StateParks", withExtension: "plist")
        
        do {
            let data = try Data(contentsOf: solutionURL!)
            let decoder = PropertyListDecoder()
            allParks = try decoder.decode(Parks.self, from: data)
        } catch {
            print(error)
            allParks = []
        }
    }
    func solution() -> Array<StatePark> {
        return allParks
    }
//
//    func collapsed(index i: Int) -> Bool{
//        return allParks[i].collapsed
//    }
    
    func parkName(index i: Int)-> String{
        return allParks[i].name
    }
    
    func imageName(index i: Int, index j: Int) -> String{
        return allParks[i].photos[j].imageName
    }
    
    func caption(index i: Int, index j: Int) -> String{
        return allParks[i].photos[j].caption
    }
    
    func parkCount() -> Int {
        return allParks.count
    }
    
    func imageCount(index i: Int) -> Int{
        return allParks[i].photos.count
    }
}
