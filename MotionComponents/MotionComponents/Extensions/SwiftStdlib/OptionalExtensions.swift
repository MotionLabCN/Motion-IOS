//
//  OptionalExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 3/3/17.
//  Copyright © 2017 SwifterSwift
//

// MARK: - Methods
public extension Optional {

   
}

// MARK: - Methods (Collection)
public extension Optional where Wrapped: Collection {
    
    var hasValue: Bool {
        guard let collection = self else { return false }
        return !collection.isEmpty
    }


}
