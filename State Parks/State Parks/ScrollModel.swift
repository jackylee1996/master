//
//  ScrollModel.swift
//  State Parks
//
//  Created by Jackeline Lee on 9/23/18.
//  Copyright © 2018 Jackeline Lee. All rights reserved.
//

import Foundation

struct Park : Codable {
    var name: String
    var count: Int
}

typealias ParkPictures = [Park]

class ParkModel {
    
    let allPictures : ParkPictures
    init () {
        let mainBundle = Bundle.main
        let solutionURL = mainBundle.url(forResource: "Parks", withExtension: "plist")
        
        do {
            let data = try Data(contentsOf: solutionURL!)
            let decoder = PropertyListDecoder()
            allPictures = try decoder.decode(ParkPictures.self, from: data)
        } catch {
            print(error)
            allPictures = []
        }
    }
    
}
