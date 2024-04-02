
import SwiftUI

struct ProductsView: View {
    @State var category: Category
    
    var body: some View {
        NavigationView {
            List {
                ForEach(category.productsArray) { product in
                    NavigationLink(destination: EditProductView(product: product), label: {Text(product.name!)})
                }
            }
        }
        
    }
}


