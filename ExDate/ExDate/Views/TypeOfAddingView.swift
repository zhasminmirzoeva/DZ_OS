

import SwiftUI

struct TypeOfAddingView: View {
    @State private var showAddingByName = false
    @State private var showingAddingByBarcode = false
    @State private var saved = false
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        
        Text("Как вы хотите добавить продукт?")
            .font(.system(size: 40, design: .serif))
        
        Button(action: {
            showAddingByName.toggle()
        } ,label: {
            Image(systemName: "highlighter")
            Text("По названию")
            
        })
        .frame(width: UIScreen.screenWidth, height: 200)
        .background(Color(red: 42 / 255, green: 191 / 255, blue: 176 / 255))
        .font(.system(size: 40, design: .serif))
        .foregroundColor(.white)
        .cornerRadius(30)
        .fullScreenCover(isPresented: $showAddingByName, content: {
            AddByNameView()
        })
        
        
        Button(action: {
            showingAddingByBarcode.toggle()
        } ,label: {
            Image(systemName: "barcode.viewfinder")
            Text("По штрихкоду")
            
        })
        .frame(width: UIScreen.screenWidth, height: 200)
        .background(Color(red: 42 / 255, green: 191 / 255, blue: 176 / 255))
        .font(.system(size: 40, design: .serif))
        .foregroundColor(.white)
        .cornerRadius(30)
        .fullScreenCover(isPresented: $showingAddingByBarcode, content: {BarcodeScannerView()})
    }
}
extension UIScreen{
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}
#Preview {
    TypeOfAddingView()
}
