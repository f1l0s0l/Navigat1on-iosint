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
    
    var favouritesPosts: [FavouritePost] {
        let fetchRequest = FavouritePost.fetchRequest()
        do {
            return try self.persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            print(error)
        }
        return []
    }
    
    
    // MARK: - Properties
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Navigat1on")
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    
    // MARK: - Public methods
    
    func addFavourite(post: PostView, completion: @escaping (String?) -> Void) {
        self.persistentContainer.performBackgroundTask { contextBackground in
            guard let id = post.id,
                  self.getFavouritePost(by: id, context: contextBackground) == nil
            else {
                return completion("Пост уже добавлен в избранное")
            }
            let favouritePost = FavouritePost(context: contextBackground)
            favouritePost.author = post.author
            favouritePost.descriptionText = post.description
            favouritePost.imageData = post.image?.pngData()
            favouritePost.likes = Int64(post.likes)
            favouritePost.views = Int64(post.views)
            favouritePost.id = post.id
            
            do {
                try contextBackground.save()
            } catch {
                print(error)
                completion("Неизвестная ошибка")
            }
            completion(nil)
        }
    }
    
    func removeFavouritePost(favouritePost: FavouritePost, completion: @escaping () -> Void) {
        self.persistentContainer.viewContext.delete(favouritePost)
        self.saveContext()
        completion()
    }
    
    func removeAllFavourites() {
        self.favouritesPosts.forEach( {persistentContainer.viewContext.delete($0)} )
        self.saveContext()
    }
    
    // MARK: - Methods
    
    private func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
               let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    private func getFavouritePost(by id: String, context: NSManagedObjectContext) -> FavouritePost? {
        let fetchRequest = FavouritePost.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        return (try? context.fetch(fetchRequest))?.first
    }
    
    func getAutorFavouritesPosts(searchString: String) -> [FavouritePost] {
        let fetchRequest = FavouritePost.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "author contains[c] %@", searchString)
        
        do {
            return try self.persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            print(error)
        }
        return []
    }
    
}
