

import SwiftUI
import CoreData

struct AddCategoryView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.dismiss) var dismiss
    @State private var name = ""
    var body: some View {
        Form {
            Section {
                TextField("Название категории", text: $name)
            }
            Section {
                Button(action: {
                    ProductDataModel().addCategory(name: name, context: managedObjectContext)
                    dismiss()
                }) {
                    Text("Добавить")
                        .foregroundColor(blue)
                }
            }
        }
    }
}
