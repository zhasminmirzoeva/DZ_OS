
import SwiftUI
import AVFoundation

struct AddByBarcodeView: View {
    @State  var name:String = ""
    @State var weight:Double = 0
    @State var categoryName = ""
    @State private var expireDate: Date = Date()
    @State private var tagInt = 0
    @State private var isOn = false
    @State private var notDate = Date()
    @State private var save = false
    let not = NotificationHandler()
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Category.name, ascending: true)], animation: .default) private var categories: FetchedResults<Category>
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField( "Название", text: $name)
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
                        Text(categoryName)
                    }
                    .pickerStyle(.menu)
                    .id(categoryName)
                } header: {
                    Text("Категория продукта")
                        .font(.system(size: 26, design: .serif))
                        .foregroundColor(Color.white)
                }
                Section {
                    TextField( "Вес", value: $weight, format: .number)
                        .foregroundColor(Color.gray)
                } header: {
                    Text("Вес продукта (в граммах)")
                        .font(.system(size: 26, design: .serif))
                        .foregroundColor(Color.white)
                }
                
                    Section {
                        DatePicker(selection: $expireDate, in: Date.now..., displayedComponents: .date) {
                            
                            Text("Годен до")
                        }
                        .environment(\.locale, Locale(identifier: "ru"))
                        
                        
                    } header: {
                        Text("Срок годности продукта")
                            .font(.system(size: 26, design: .serif))
                            .foregroundColor(Color.white)
                    
                }
                Section {
                    Toggle(" ", isOn: $isOn)
                        .toggleStyle(.switch)
                    if (isOn) {
                        DatePicker("Выберите дату", selection: $notDate, in: Date()...)
                            .environment(\.locale, Locale(identifier: "ru"))
                        
                    }
                } header: {
                    Text("Получить уведомление об окончании срока годности")
                        .font(.system(size: 26, design: .serif))
                        .foregroundColor(Color.white)
                }
                
                
            }.scrollContentBackground(.hidden)
                .background(blue)
            Button(action: {
                ProductDataModel().addFood(name: name, weight: weight, expireData: expireDate.formatter(), category: ProductDataModel().getCategory(name: categoryName, context: managedObjectContext) ?? Category(), context: managedObjectContext)
                save.toggle()
                not.askPermission()
                not.sendNotification(date: notDate, type: "date", title: "ExDate", body: "Истекает срок годности у \"\(name)\"")
            }) {
                
                Text("Добавить")
                    .frame(height: 40)
                    .font(.system(size: 30, design: .serif))
                    .foregroundColor(blue)
                
            }.fullScreenCover(isPresented: $save, content: {MainScreenView()})
        }
    }
    
}






