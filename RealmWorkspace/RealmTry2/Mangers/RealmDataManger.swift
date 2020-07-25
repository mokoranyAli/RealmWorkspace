//
//  RealmDataManger.swift
//  RealmWorkspace
//
//  Created by Mohamed Korany Ali on 7/25/20.
//  Copyright © 2020 Mohamed Korany Ali. All rights reserved.
//

import Foundation
import RealmSwift
enum RealmError: Error {
  case eitherRealmIsNilOrNotRealmSpecificModel
}

extension RealmError: LocalizedError {
  public var errorDescription: String? {
    switch self {
    case .eitherRealmIsNilOrNotRealmSpecificModel:
      return NSLocalizedString("eitherRealmIsNilOrNotRealmSpecificModel", comment: "eitherRealmIsNilOrNotRealmSpecificModel")
    }
  }
}

class RealmDataManager {
  
  private let realm: Realm?
  
  init(_ realm: Realm?) {
    self.realm = realm
  }
  
  
  
}


extension RealmDataManager: DataManager {
  func object<T>(_ type: T.Type, key: String) throws -> T? where T : Storable {
     guard let realm = realm, let model = type as? Object.Type else { throw RealmError.eitherRealmIsNilOrNotRealmSpecificModel }
    return realm.object(ofType: model, forPrimaryKey: key) as! T
  }
  
  //MARK: - Methods
  func create<T>(_ model: T.Type, completion: @escaping ((T) -> Void)) throws where T : Storable {
    guard let realm = realm, let model = model as? Object.Type else { throw RealmError.eitherRealmIsNilOrNotRealmSpecificModel }
    try realm.write  {
      let newObject = realm.create(model, value: [], update: .error) as! T
      
      completion(newObject)
    }
  }
  func save(object: Storable) throws {
    guard let realm = realm, let object = object as? Object else { throw RealmError.eitherRealmIsNilOrNotRealmSpecificModel }
    try realm.write {
      realm.add(object)
    }
  }
  func update(object: Storable) throws {
    guard let realm = realm, let object = object as? Object else {
      throw RealmError.eitherRealmIsNilOrNotRealmSpecificModel
    }
    try realm.write {
      realm.add(object,update: .all)
    }
  }
  func delete(object: Storable) throws {
    guard let realm = realm, let object = object as? Object else { print("error.......")
      throw RealmError.eitherRealmIsNilOrNotRealmSpecificModel }
    
    do {
    try realm.write {
      print("Inside write closure delete")
      //let predicate = NSPredicate(format: "UUID == %@", object.uuid)
      realm.delete(object)
      
    }
    }
    catch(let error) {
      print("error ...... is   \(print(error.localizedDescription))")
    }
    
  }
  func deleteAll<T>(_ model: T.Type) throws where T : Storable {
    guard let realm = realm, let model = model as? Object.Type else { throw RealmError.eitherRealmIsNilOrNotRealmSpecificModel }
    try realm.write {
      let objects = realm.objects(model)
      for object in objects {
        realm.delete(object)
      }
    }
  }
  func fetch<T>(_ model: T.Type, predicate: NSPredicate?, sorted: Sorted?, completion: (([T]) -> ())) where T : Storable {
    guard let realm = realm, let model = model as? Object.Type else { return }
    var objects = realm.objects(model)
    if let predicate = predicate {
      objects = objects.filter(predicate)
    }
    if let sorted = sorted {
      objects = objects.sorted(byKeyPath: sorted.key, ascending: sorted.ascending)
    }
    completion(objects.compactMap { $0 as? T })
  }
  
  
}
