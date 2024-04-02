

import Foundation
import SwiftUI

struct StatisticsModel {

    @FetchRequest(sortDescriptors: [SortDescriptor(\.expireDate, order:.reverse)]) private  var products: FetchedResults<Product>
    func size()-> Int {
        return products.count
    }
    static var  usedProducts : Int = 5
    
    static var thrownProducts: Int = 2
    
    
    
  
    
}
