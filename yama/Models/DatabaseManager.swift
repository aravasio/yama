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
    
    func saveShows(_ shows: [Show], for category: String) {
        shows.forEach {
            self.saveShow($0, category: category)
        }
        
        print("Shows saved to Local Storage.")
    }
    
    func saveShow(_ show: Show, category: String) {
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
}
