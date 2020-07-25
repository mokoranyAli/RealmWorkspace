//
//  News.swift
//  RealmWorkspace
//
//  Created by Mohamed Korany Ali on 7/25/20.
//  Copyright © 2020 Mohamed Korany Ali. All rights reserved.
//

import Foundation
import RealmSwift


struct News: Codable {
  let source: SourceNews?
  let author: String?
  let title, articleDescription: String?
  let url: String?
  let urlToImage: String?
  var publishedAt: String?
  let content: String?
  
  enum CodingKeys: String, CodingKey {
    case source, author, title
    case articleDescription = "description"
    case url, urlToImage, publishedAt, content
  }
}

// MARK: - Source
struct SourceNews: Codable {
  let id: String?
  let name: String?
}

extension News : MappableProtocol {
  static func mapFromPersistenceObject(_ object: NewsRealm) -> News {
    return News(source: SourceNews(id: object.sourceNewsID, name: object.sourceNewsName), author: object.author, title: object.title, articleDescription: object.articleDescription, url: object.url, urlToImage: object.urlToImage, publishedAt: object.publishedAt, content: object.content)
  }
  
 

  typealias PersistenceType = NewsRealm
  func mapToPersistenceObject() -> PersistenceType {
    let news = NewsRealm()
    news.author = author!
    news.articleDescription = articleDescription!
    news.content = content!
    news.publishedAt = publishedAt!
    news.title = title!
    news.url = url!
    news.urlToImage = urlToImage!
    news.sourceNewsID = (source?.id!)!
    news.sourceNewsName = (source?.name!)!
    
    return news
  }
  
  
  
}





final class NewsRealm:Object {
  @objc dynamic var  author: String = ""
  @objc dynamic var  title: String = ""
  @objc dynamic var  articleDescription: String = ""
  @objc dynamic var  url: String = ""
  @objc dynamic var  urlToImage: String = ""
  @objc dynamic var  publishedAt: String = ""
  @objc dynamic var  content: String = ""
  @objc dynamic var  sourceNewsID: String = ""
  @objc dynamic var  sourceNewsName: String = ""
  
     override static func primaryKey() -> String? {
         return "title"
     }
  
  
}
