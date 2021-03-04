//
//  CoreDataMigrationVersion.swift
//  WeatherApp
//
//  Created by Vijay A on 10/05/19.
//  Copyright © 2019 Vijay A. All rights reserved.
//

import Foundation
import CoreData

enum CoreDataMigrationVersion: String, CaseIterable {
    case version1 = "WeatherApp"
    
    // MARK: - Current
    
    static var current: CoreDataMigrationVersion {
        guard let latest = allCases.last else {
            fatalError("no model versions found")
        }
        
        return latest
    }
    
    // MARK: - Migration
    
    func nextVersion() -> CoreDataMigrationVersion? {
        switch self {
        case .version1:
            return nil
//        case .version2:
//            return nil
        }
    }
}
