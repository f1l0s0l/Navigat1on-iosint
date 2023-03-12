//
//  CoreDataManager.swift
//  Navigat1on
//
//  Created by Илья Сидорик on 06.03.2023.
//

import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    
    // MARK: - Public properties
    
    lazy var fetchResultsController: NSFetchedResultsController<FavouritePost> = {
        let fetchRequest = FavouritePost.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "dateCreate", ascending: false)]
        let frc = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: persistentContainer.viewContext,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        return frc
    }()
    
    
    // MARK: - Properties
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Navigat1on")
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
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
            favouritePost.uid = post.id
            
            do {
                try contextBackground.save()
                completion(nil)
            } catch {
                print(error)
                completion("Неизвестная ошибка")
            }
        }
    }
    
    func removeFavouritePost(favouritePost: FavouritePost) {
        self.persistentContainer.viewContext.delete(favouritePost)
        try? self.persistentContainer.viewContext.save()
    }
    
    func removeAllFavourites() {
        self.fetchResultsController.fetchedObjects?.forEach({ persistentContainer.viewContext.delete($0) })
        try? self.persistentContainer.viewContext.save()
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
        fetchRequest.predicate = NSPredicate(format: "uid == %@", id)
        return (try? context.fetch(fetchRequest))?.first
    }
    
}
