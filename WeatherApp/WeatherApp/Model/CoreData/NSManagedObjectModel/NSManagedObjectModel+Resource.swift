//
//  NSManagedObjectModel+Resource.swift
//  RestraurantPOS
//
//  Created by Vijay A on 17/05/19.
//  Copyright © 2019 Vijay A. All rights reserved.
//


import Foundation
import CoreData

extension NSManagedObjectModel {
    
    // MARK: - Resource
    
    static func managedObjectModel(forResource resource: String) -> NSManagedObjectModel {
        let mainBundle = Bundle.main
        let subdirectory = "WeatherApp.momd"
        
        var omoURL: URL?
        if #available(iOS 11, *) {
            omoURL = mainBundle.url(forResource: resource, withExtension: "omo", subdirectory: subdirectory) // optimized model file
        }
        let momURL = mainBundle.url(forResource: resource, withExtension: "mom", subdirectory: subdirectory)
        
        guard let url = omoURL ?? momURL else {
            fatalError("unable to find model in bundle")
        }
        
        guard let model = NSManagedObjectModel(contentsOf: url) else {
            fatalError("unable to load model in bundle")
        }
        
        return model
    }
}
