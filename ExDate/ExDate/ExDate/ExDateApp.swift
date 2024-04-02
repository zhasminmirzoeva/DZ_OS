

import SwiftUI

@main
struct ExDateApp: App {
    let dataModel = ProductDataModel()
    var body: some Scene {
        WindowGroup {
            MainScreenView()
                .environment(\.managedObjectContext, dataModel.container.viewContext)
        }
    }
}
