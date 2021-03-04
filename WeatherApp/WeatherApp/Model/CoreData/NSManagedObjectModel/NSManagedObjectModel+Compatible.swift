//
//  NSManagedObjectModel+Compatible.swift
//  RestraurantPOS
//
//  Created by Vijay A on 17/05/19.
//  Copyright © 2019 Vijay A. All rights reserved.
//


import Foundation
import CoreData

extension NSManagedObjectModel {
    
    // MARK: - Compatible
    
    static func compatibleModelForStoreMetadata(_ metadata: [String : Any]) -> NSManagedObjectModel? {
        let mainBundle = Bundle.main
        return NSManagedObjectModel.mergedModel(from: [mainBundle], forStoreMetadata: metadata)
    }
}
