//
//  CoreDataManager.swift
//  Navigat1on
//
//  Created by Илья Сидорик on 06.03.2023.
//

import Foundation
import CoreData
import UIKit

final class CoreDataManager {
    static let shared = CoreDataManager()
    
    
    // MARK: - Public properties
    
//    var favouritesPosts: [FavouritePost] = []
    var favouritesPosts: [FavouritePost] {
        let fetch = FavouritePost.fetchRequest()
        do {
            return try self.persistentComtainer.viewContext.fetch(fetch)
        } catch {
            print(error)
        }
        return []
    }
    
    
    // MARK: - Properties
    
    private lazy var persistentComtainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Navigat1on")
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    
    // MARK: - Life cycle
    
//    init() {
//        self.reloadFavouritesPosts()
//    }
    
    
    // MARK: - Public methods
    
//    func reloadFavouritesPosts() {
//        let fetchRequest = FavouritePost.fetchRequest()
//        self.favouritesPosts =  (try? self.persistentComtainer.viewContext.fetch(fetchRequest)) ?? []
//    }
    
    func addFavourite(post: PostView) {
        let favouritePost = FavouritePost(context: persistentComtainer.viewContext)
        favouritePost.author = post.author
        favouritePost.descriptionText = post.description
        favouritePost.imageData = post.image?.pngData()
        favouritePost.likes = Int64(post.likes)
        favouritePost.views = Int64(post.views)
        self.saveContext()
    }
    
    func removeAllFavourites() {
        self.favouritesPosts.forEach( {persistentComtainer.viewContext.delete($0)} )
        self.saveContext()
    }
    
    // MARK: - Methods
    
    private func saveContext() {
        let context = persistentComtainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
               let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}
