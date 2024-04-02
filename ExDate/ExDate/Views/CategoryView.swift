
import SwiftUI
import CoreData

struct CategoryView: View {
    @Environment(\.managedObjectContext) var managedObject
    @FetchRequest(sortDescriptors: [], animation: .default) private var categories: FetchedResults<Category>
    @State private var showAdding = false
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    
                    ForEach(categories) {category in
                        NavigationLink(destination: ProductsView(category: category), label: {Text(category.name!)})
                    }.onDelete(perform: deleteCategory)
                    
                }
                Button(action: {
                    showAdding.toggle()
                }) {
                    Text("Добавить категорию")
                        .font(.system(size: 30, design: .serif))
                        .foregroundColor(blue)
                }
                
                .sheet(isPresented: $showAdding, content: {
                    AddCategoryView()
                })
            }
        }
        
    }
    
    
    private func deleteCategory(offsets: IndexSet) {
        withAnimation {
            offsets.map { categories[$0] }.forEach(managedObject.delete)
            ProductDataModel().save(context: managedObject)
        }
    }
}
