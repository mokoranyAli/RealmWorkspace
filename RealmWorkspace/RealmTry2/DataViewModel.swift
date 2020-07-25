//
//  DataViewModel.swift
//  RealmWorkspace
//
//  Created by Mohamed Korany Ali on 7/25/20.
//  Copyright © 2020 Mohamed Korany Ali. All rights reserved.
//

import Foundation
class ViewModel {
    
    let dbManager: DataManager
    let newsRepo: NewsRepositoryProtocol
    
  init(dbManager: DataManager = RealmDataManager(RealmProvider.default)) {
         self.dbManager = dbManager
         self.newsRepo = NewsRepository(dbManager: dbManager)
    }
    
    func getData() {
      let news1 = News(source: SourceNews(id: "aa", name: "source1"), author: "aaaMohamed", title: "Book", articleDescription: "asdasdsad", url: "oooaooaoaoosdod", urlToImage: "asdlkamsdmasd", publishedAt: "1212", content: "asdasd")
       let news2 = News(source: SourceNews(id: "aas", name: "souarce1"), author: "Mohsamed", title: "Booak", articleDescription: "asdasdsadd", url: "oooaooasdaoaoosdod", urlToImage: "asdlkaaasmsdmasd", publishedAt: "121dd2", content: "asdasaad")
      

//      newsRepo.saveNew(new: news2)
//     newsRepo.saveNew(new: news1)

      newsRepo.getAllNews(on: Sorted(key: "author", ascending: true)) { (news) in
        print(news[0])
      }
      
      
      //newsRepo.deleteAll()
    newsRepo.deleteNews(new: news1)
//      newsRepo.getAllNews(on: Sorted(key: "author", ascending: true)) { (news) in
//        print(news.count)
//           }
      newsRepo.getAllNews(on: Sorted(key: "author", ascending: true)) { (news) in
        print(news[0])
      }
    }
}
  
