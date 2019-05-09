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

/// My CoreData interface. Here I save / restore data from CoreData.

class DatabaseManager {
    
    // The AppDelegate. It's required for getting the context.
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    /**
     Store an array of Movies in CoreData.
     
     - Parameters:
     - movies: An array of Movie you want to store.
     - category: The category that Movie belongs to; Popular, TopRated, etc.
     */
    func store(movies: [Movie], for category: String) {
        movies.forEach {
            self.saveMovie($0, category: category)
        }
    }
    
    
    /// Stores a given movie in CD.
    fileprivate func saveMovie(_ movie: Movie, category: String) {
        let context = appDelegate.persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: "MovieObject", in: context) else {
            return
        }
        
        let newMovie = NSManagedObject(entity: entity, insertInto: context)
        newMovie.setValue(category, forKey: "category")
        newMovie.setValue(movie.id, forKey: "id")
        newMovie.setValue(movie.title, forKey: "title")
        newMovie.setValue(movie.posterPath, forKey: "posterPath")
        newMovie.setValue(movie.overview, forKey: "overview")
        newMovie.setValue(movie.releaseDate, forKey: "releaseDate")
        newMovie.setValue(movie.backdrop, forKey: "backdrop")
        newMovie.setValue(movie.rating, forKey: "rating")
        newMovie.setValue(movie.voteCount, forKey: "voteCount")
        newMovie.setValue(movie.originalLanguage, forKey: "originalLanguage")
        
        //Data encoding of the [int]; genres.
        let genresData = try! NSKeyedArchiver.archivedData(withRootObject: movie.genres, requiringSecureCoding: false)
        newMovie.setValue(genresData, forKey: "genres")

        do {
            try context.save()
        } catch {
            print("Failed to save")
        }
    }
    
    
    /**
     Fetch from CoreData all movies whose category matches the one you passed.
     
     - Parameters:
     - completion: code to be executed on a succesful request.
     */
    func fetchMovies(for category: String) -> [Movie] {
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "MovieObject")
        request.predicate = NSPredicate(format: "category = %@", category)
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request) as [AnyObject]
            let movies = result.compactMap { return Movie(data: $0) }
            return movies
        } catch {
            print("failed")
            return []
        }
    }
    
    
    /**
     Store an array of genres in CoreData.
     
     - Parameters:
     - genres: An array of Genre you want to store.
     */
    func store(genres: [Genre]) {
        genres.forEach {
            self.saveGenre($0)
        }
    }
    
    
    /// Stores a single genre object in CD.
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
    
    
    /// Fetch all genres from CoreData.
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
