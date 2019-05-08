//
//  DatabaseManager.swift
//  yama
//
//  Created by Alejandro Ravasio on 07/05/2019.
//  Copyright © 2019 Alejandro Ravasio. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class DatabaseManager {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func store(shows: [Show], for category: String) {
        shows.forEach {
            self.saveShow($0, category: category)
        }
    }
    
    fileprivate func saveShow(_ show: Show, category: String) {
        let context = appDelegate.persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: "ShowObject", in: context) else {
            return
        }
        
        let newShow = NSManagedObject(entity: entity, insertInto: context)
        newShow.setValue(category, forKey: "category")
        newShow.setValue(show.id, forKey: "id")
        newShow.setValue(show.title, forKey: "title")
        newShow.setValue(show.posterPath, forKey: "posterPath")
        newShow.setValue(show.videoPath, forKey: "videoPath")
        newShow.setValue(show.overview, forKey: "overview")
        newShow.setValue(show.releaseDate, forKey: "releaseDate")
        newShow.setValue(show.backdrop, forKey: "backdrop")
        newShow.setValue(show.rating, forKey: "rating")
        newShow.setValue(show.voteCount, forKey: "voteCount")
        newShow.setValue(show.originalLanguage, forKey: "originalLanguage")
        
        //Data encoding of the [int]; genres.
        let genresData = try! NSKeyedArchiver.archivedData(withRootObject: show.genres, requiringSecureCoding: false)
        newShow.setValue(genresData, forKey: "genres")

        //Data encoding of the [string]; country of origin/
        let countryOfOriginData = try! NSKeyedArchiver.archivedData(withRootObject: show.countryOfOrigin, requiringSecureCoding: false)
        newShow.setValue(countryOfOriginData, forKey: "countryOfOrigin")
        
        do {
            try context.save()
        } catch {
            print("Failed to save")
        }
    }
    
    func fetchShows(for category: String) -> [Show] {
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ShowObject")
        request.predicate = NSPredicate(format: "category = %@", category)
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request) as [AnyObject]
            let shows = result.compactMap { return Show(data: $0) }
            return shows
        } catch {
            print("failed")
            return []
        }
    }
    
    
    
    
    func store(genres: [Genre]) {
        genres.forEach {
            self.saveGenre($0)
        }
    }
    
    fileprivate func saveGenre(_ genre: Genre) {
        let context = appDelegate.persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: "GenreObject", in: context) else {
            return
        }
        
        let newGenre = NSManagedObject(entity: entity, insertInto: context)
        newGenre.setValue(genre.id, forKey: "id")
        newGenre.setValue(genre.name, forKey: "name")
        
        do {
            try context.save()
        } catch {
            print("Failed to save")
        }
    }
    
    func fetchGenres() -> [Genre] {
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "GenreObject")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request) as [AnyObject]
            let genres = result.compactMap { return Genre(data: $0) }
            return genres
        } catch {
            print("failed")
            return []
        }
    }
}
