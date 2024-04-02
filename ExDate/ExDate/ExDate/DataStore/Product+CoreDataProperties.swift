
import Foundation
import CoreData


extension Product {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product")
    }

    @NSManaged public var name: String?
    @NSManaged public var weight: Double
    @NSManaged public var expireDate: String?
    @NSManaged public var category: Category?
    
    public var wrappedName: String {
        name ?? " "
    }
    public var wrappedExpireDate: String {
        expireDate ?? " "
    }
    public var wrappedWeight: Double {
        weight ?? 0.0
    }

}

extension Product : Identifiable {

}
