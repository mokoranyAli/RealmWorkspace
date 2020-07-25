//
//  NewsRepository.swift
//  RealmWorkspace
//
//  Created by Mohamed Korany Ali on 7/25/20.
//  Copyright © 2020 Mohamed Korany Ali. All rights reserved.
//

import Foundation
//MARK: -  NewsRepositoryProtocol
protocol NewsRepositoryProtocol {
  
  //MARK: - Methods
  func getAllNews(on sort: Sorted?,completionHandler: ([News]) -> Void)
  func saveNew(new: News)
  func updateNews(_ new: News)
  func deleteNews(new:News)
  func deleteAll()
}

//MARK: -  NewsRepository
class NewsRepository : BaseRepository<NewsRealm> {
  
}

extension NewsRepository : NewsRepositoryProtocol {
  func deleteAll() {
    do{ try   super.deleteAll(NewsRealm.self) }
    catch { print(error.localizedDescription) }
  }
  
  func getAllNews(on sort: Sorted?, completionHandler: ([News]) -> Void) {
    super.fetch(NewsRealm.self, sorted: sort) { (news) in
           completionHandler(news.map { News.mapFromPersistenceObject($0) } )
    }
  }
  
  func saveNew(new: News) {
    do { try super.save(object: new.mapToPersistenceObject()) }
    catch { print(error.localizedDescription) }
  }
  
  func updateNews(_ new: News) {
    do { try super.update(object: new.mapToPersistenceObject()) }
    catch { print(error.localizedDescription) }
  }
  
  func deleteNews(new: News) {
    do {
      
      let movieWillDelete = try dbManager.object(NewsRealm.self, key: new.title!)
      print(movieWillDelete?.title ?? "h")
      if let news = movieWillDelete {
        try super.delete(object: news)
      }
    }
    catch {
      print("erorr ...... \(error.localizedDescription)")
    }
    
    
//     do { try super.delete(object: new.mapToPersistenceObject()) }
//       catch { print("erorr ...... \(error.localizedDescription)") }
  }
  
  
}
