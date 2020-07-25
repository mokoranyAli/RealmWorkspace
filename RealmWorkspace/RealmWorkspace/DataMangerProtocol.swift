//
//  DataMangerProtocol.swift
//  RealmWorkspace
//
//  Created by Mohamed Korany Ali on 7/23/20.
//  Copyright © 2020 Mohamed Korany Ali. All rights reserved.
//

import Foundation
import RealmSwift
protocol GenericDAO {
  associatedtype T:Object

  func save(_ object: T) -> Bool

  func saveAll(_ objects: [T]) -> Int

  func findAll() -> [T]

  func findByPrimaryKey(_ id: Any) -> T?

  func deleteAll()

}
//let movieDAO = GenericDAOImpl<Movie>()
