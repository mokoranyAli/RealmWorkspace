//
//  DataManger.swift
//  RealmWorkspace
//
//  Created by Mohamed Korany Ali on 7/24/20.
//  Copyright © 2020 Mohamed Korany Ali. All rights reserved.
//

import Foundation
import RealmSwift
//MARK: - DataManager Protocol

protocol DataManager {
    
    func create<T: Storable>(_ model: T.Type, completion: @escaping ((T) -> Void)) throws
    func save(object: Storable) throws
    func update(object: Storable) throws
    func delete(object: Storable) throws
    func deleteAll<T: Storable>(_ model: T.Type) throws
    func fetch<T: Storable>(_ model: T.Type, predicate: NSPredicate?, sorted: Sorted?, completion: (([T]) -> ()))
    func object<T: Storable>(_ type: T.Type, key: String) throws -> T? 
    
}


//MARK: - Storable Protocol
/*CRUD tasks perform operation on persistence specific object since we are creating generic protocol we need to program to an interface instead of concrete implementation*/
public protocol Storable {
    
}



/*To sort the fetch result common interface is created for this purpose since different persistence framework provides different interface for sorting*/
public struct Sorted {
    var key: String
    var ascending: Bool = true
}


extension Object: Storable {
}
