

import Foundation
import CoreData

class ProductDataModel: ObservableObject {
    let container = NSPersistentContainer(name: "ExDate")
    
    init() {
        container.loadPersistentStores { desc, error in
            if let error = error {
                print("Failed to load the data\(error.localizedDescription)")
            }
            
        }
    }
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("Data saved")
        } catch {
            print("We could not saved the data...")
        }
    }
    
    func addFood(name: String, weight: Double, expireData: String, category: Category, context: NSManagedObjectContext) {
        let product = Product(context: context)
        product.name = name
        product.weight = weight
        product.expireDate = expireData
        category.addToProducts(product)
        save(context: context)
    }
    
    func editProduct(product: Product, name: String, weight: Double, expireData: String,  context: NSManagedObjectContext) {
        product.name = name
        product.weight = weight
        product.expireDate = expireData
        save(context: context)
    }
    
    func addCategory(name: String, context: NSManagedObjectContext) {
        let category = Category(context: context)
        category.name = name
        save(context: context)
    }
    
    func getCategory(name: String, context: NSManagedObjectContext) -> Category? {
        let request = Category.fetchRequest()
        
        let predicate =  NSPredicate(format: "name = %@", name)
        request.predicate = predicate
        do {
            let category = try context.fetch(request)
            return category.first
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func getProductsByDate(expireDate: Date, context: NSManagedObjectContext) -> [Product] {
        let date = expireDate.formatter()
        let fetchRequest: NSFetchRequest<Product> = Product.fetchRequest()
        let predicate = NSPredicate(format: "expireDate == %@", date)
        fetchRequest.predicate = predicate
        
        do {
            let products = try context.fetch(fetchRequest)
            
            return products
        } catch {
            print("Ошибка при получении объектов Product: \(error)")
            return []
        }
    }

    
}
