//
//  Pieces.swift
//  Pentomino
//
//  Created by Jackeline Lee on 9/10/18.
//  Copyright © 2018 Jackeline Lee. All rights reserved.
//

import Foundation

class Pieces{
    private let piecesCount = 12
    private var pieces :[String] = ["F","I","L","N","P","T","U","V","W","X","Y","Z"]
    private var nameOfPiece : [String]
    
    init(){
        var _nameOfPiece = [String]()
        
        for i in 0..<piecesCount {
            _nameOfPiece.append("Piece\(pieces[i])")
        }
        nameOfPiece = _nameOfPiece
    }
    
    func pieceName(index i: Int) -> String {
        return nameOfPiece[i%piecesCount]
    }
    
    func pieceLetter(index i: Int) -> String {
        return pieces[i%piecesCount]
    }
}

