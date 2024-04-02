

import SwiftUI
import CoreData

struct EditProductView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Category.name, ascending: true)], animation: .default) private var categories: FetchedResults<Category>
    @State var product: Product
    @State private var isEdited = false
    @State private var name:String = ""
    @State private var weight:Double = 0
    @State private var expireDate: Date = Date()
    @State private var categoryName = ""
    @State private var showingAlert = false
    @State private var alertMessage = ""
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField(product.name!, text: $name)
                        .foregroundColor(Color.gray)
                } header: {
                    Text("Название продукта")
                        .font(.system(size: 26, design: .serif))
                        .foregroundColor(Color.white)
                }
                Section {
                    Picker(selection: $categoryName) {
                        ForEach(categories) {category in
                            Text(category.name!).tag(category.name!)
                        }
                    } label: {
                        Text(product.category?.name! ?? " ")
                            .foregroundColor(.gray)
                    }
                    .pickerStyle(.menu)
                    .id(product.category?.name!)
                } header: {
                    Text("Категория продукта")
                        .font(.system(size: 26, design: .serif))
                        .foregroundColor(Color.white)
                }
                Section {
                    TextField("\(product.weight)", value: $weight, format: .number)
                        .foregroundColor(Color.gray)
                } header: {
                    Text("Вес продукта")
                        .font(.system(size: 26, design: .serif))
                        .foregroundColor(Color.white)
                }
                
                Section {
                    DatePicker(selection: $expireDate, in: Date.now..., displayedComponents: .date) {
                        Text("Годен до")
                    }
                    
                    
                } header: {
                    Text("Срок годности продукта")
                        .font(.system(size: 26, design: .serif))
                        .foregroundColor(Color.white)
                    
                }
                
                
            }.scrollContentBackground(.hidden)
                .background(blue)
            Button(action: {
                ProductDataModel().editProduct(product: product, name: name, weight: weight, expireData: expireDate.formatter(), context: managedObjectContext)
                
                if (product.checkName() != "") {
                    showingAlert.toggle()
                    alertMessage = product.checkName()
                }
                else if (product.checkWeight() != "") {
                    showingAlert.toggle()
                    alertMessage = product.checkWeight()
                } else {
                    isEdited.toggle()
                }
                
            })

            {
                
                Text("Сохранить")
                    .frame(height: 40)
                    .font(.system(size: 30, design: .serif))
                    .foregroundColor(blue)
                
            }
            .alert(alertMessage, isPresented: $showingAlert) {
                Button("OK", role: .cancel){}
            }
            .fullScreenCover(isPresented: $isEdited, content: {
                MainScreenView()
            })
        }
    }
}
