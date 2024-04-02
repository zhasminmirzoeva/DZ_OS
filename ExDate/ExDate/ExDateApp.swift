//
//  ExDateApp.swift
//  ExDate
//
//  Created by Zhasmin Mirzoeva on 10/04/24.
//

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
