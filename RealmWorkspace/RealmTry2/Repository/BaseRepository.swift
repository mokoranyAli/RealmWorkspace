//
//  BaseRepository.swift
//  RealmWorkspace
//
//  Created by Mohamed Korany Ali on 7/25/20.
//  Copyright © 2020 Mohamed Korany Ali. All rights reserved.
//

import Foundation

//MARK: - BaseRepository
class BaseRepository<T> {
    
    //MARK: - Stored Properties
    var dbManager : DataManager
    
    //MARK: - Init
    required init(dbManager : DataManager) {
        self.dbManager = dbManager
    }
    
    //MARK: - Methods
    func fetch<T>(_ model: T.Type, predicate: NSPredicate? = nil, sorted: Sorted?, completion: (([T]) -> ())) where T : Storable {
        dbManager.fetch(model, predicate: predicate, sorted: sorted, completion: completion)
    }
    
    func deleteAll<T>(_ model: T.Type) throws where T : Storable {
        try dbManager.deleteAll(model)
    }
    
    func delete(object: Storable) throws {
        try dbManager.delete(object: object)
    }
    
    func update(object: Storable) throws {
        
        try dbManager.update(object: object)
    }
    func save(object: Storable) throws {
        try dbManager.save(object: object)
    }
    
    func create<T>(_ model: T.Type, completion: @escaping ((T) -> Void)) throws where T : Storable {
        try dbManager.create(model, completion: completion)
    }
    
}
