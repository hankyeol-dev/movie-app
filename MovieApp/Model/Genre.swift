//
//  Genre.swift
//  MovieApp
//
//  Created by 강한결 on 6/10/24.
//

import Foundation

struct Genre: Decodable {
    let id: Int
    let name: String
    
    var getId: Int {
        self.id
    }
    
    var getName: String {
        self.name
    }
}
