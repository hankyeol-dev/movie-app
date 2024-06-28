//
//  ValidateService.swift
//  MovieApp
//
//  Created by 강한결 on 6/28/24.
//

import Foundation

class ValidateService {
    private init() {}
    
    static let manager = ValidateService()
    
    enum errors: Error {
        case isEmpty
        case isStartWhiteSpace
    }
    
    func validateSearch(_ search: String) throws {
        if self.isEmptyString(search) {
            throw errors.isEmpty
        }
        
        if self.isStartWhiteSpace(search) {
            throw errors.isStartWhiteSpace
        }
    }
    
    private func isEmptyString(_ t: String) -> Bool {
        return t.isEmpty
    }
    
    private func isStartWhiteSpace(_ t:String) -> Bool {
        return Array(t)[0].isWhitespace
    }
}
