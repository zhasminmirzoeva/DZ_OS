import SwiftUI
import CoreData
struct ListView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.expireDate, order:.reverse)]) private var products: FetchedResults<Product>
    @Binding var date: Date
    @State private var isUsed = false
    @State private var selectedProduct: Product? // Добавляем переменную для хранения выбранного продукта
    
    var body: some View {
        NavigationView {
            List {
                ForEach(products) { product in
                    if product.expireDate == date.formatter() {
                        Button(action: {
                           
                            selectedProduct = product
                        }) {
                            Text(product.name!)
                                .font(.system(size: 28, design: .serif))
                                .foregroundColor(.gray)
                        }
                    }
                }.onDelete(perform: deleteProduct)
                    
            }
        
            .sheet(item: $selectedProduct) { product in
                EditProductView(product: product)
            }
        }
    }

    private func deleteProduct(offsets: IndexSet) {
        withAnimation {
            offsets.map { products[$0] }.forEach(managedObjectContext.delete)
            ProductDataModel().save(context: managedObjectContext)
        }
    }
}



