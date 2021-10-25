//
//  NewsData+CoreDataClass.swift
//  News
//
//  Created by Bayu Yasaputro on 23/10/21.
//
//

import Foundation
import CoreData

@objc(NewsData)
public class NewsData: NSManagedObject {
    
    class func insert(news: News, context: NSManagedObjectContext) {
        let request: NSFetchRequest<NewsData> = NewsData.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", news.id)
        let entity: NewsData
        if let news = try? context.fetch(request).first {
            entity = news
        }
        else {
            let news = NSEntityDescription.entity(forEntityName: "NewsData", in: context)!
            entity = NSManagedObject(entity: news, insertInto: context) as! NewsData
        }

        entity.id = news.id
        entity.publishedDate = news.publishedDate
        entity.abstract = news.abstract
        entity.url = news.url
        entity.section = news.section
        entity.title = news.title
        entity.thumb = news.media.last?.mediaMetadata.last?.url ?? ""
    }
    
    class func select(context: NSManagedObjectContext) -> [NewsData] {
        let request: NSFetchRequest<NewsData> = NewsData.fetchRequest()
        do {
            let readingList = try context.fetch(request)
            return readingList
        }
        catch {
            return []
        }
    }
    
    class func selectActive(context: NSManagedObjectContext) -> [NewsData] {
        let request: NSFetchRequest<NewsData> = NewsData.fetchRequest()
        request.predicate = NSPredicate(format: "isActive == %d", true)
        do {
            let readingList = try context.fetch(request)
            return readingList
        }
        catch {
            return []
        }
    }
}
