//
//  DataManger1.swift
//  RealmWorkspace
//
//  Created by Mohamed Korany Ali on 7/23/20.
//  Copyright © 2020 Mohamed Korany Ali. All rights reserved.
//

import Foundation
import RealmSwift


class GenericDAOImpl <T:Object> : GenericDAO {

  //  MARK: setup

  var realm: Realm?
  init() {
    do {
      realm = try Realm()
    } catch {
      print("Realm Initialization Error: \(error)")
    }
  }

  //   MARK: protocol implementation

  func save(_ object: T) -> Bool {
    guard let `realm` = realm else {
      return false
    }

    do {
      try realm.write {
        realm.add(object)
      }
    } catch {
      return false
    }

    return true
  }

  func saveAll(_ objects: [T]) -> Int {
    var count = 0
    for obj in objects {
      if save(obj) { count += 1 }
    }
    return count
  }

  private func findAllResults() -> Results<T>? {
    return realm?.objects(T.self)
  }

  func findAll() -> [T] {
    guard let res = findAllResults() else { return [] }
    return Array(res)
  }

  func findByPrimaryKey(_ id: Any) -> T? {
    return self.realm?.object(ofType: T.self, forPrimaryKey: id)
  }

  func deleteAll() {
    guard let res = findAllResults() else { return }

    do {
      try realm?.write {
        self.realm?.delete(res)
      }
    } catch {
      print("Realm Error Deleting Objects: \(error)")
      return
    }
  }

}
