//
//  extensions.swift
//  KasperCatch
//
//  Created by Jackeline Lee on 11/22/18.
//  Copyright © 2018 Jackeline Lee. All rights reserved.
//

import Foundation

extension String {
    func firstLetter() -> String? {
        let substring =  self[self.startIndex...self.startIndex]
        return String(substring)
    }
}
