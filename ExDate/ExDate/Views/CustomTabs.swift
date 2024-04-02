

import SwiftUI
struct CustomTabs: View {
    @Binding var index: Int
    @State var showTypeAdding = false
    @State var byBarcode = false
    @State private var showCategories = false
    var body: some View {
        HStack {
            
        Button(action: {
                self.index = 0
                showTypeAdding.toggle()
            }) {
                VStack
                {
                    Image(systemName: "plus.circle.fill")
                        .font(.system(size: 40))
                        .offset(y:15)
                    Text("Добавить")
                        .offset(y: 25)
                    
                }
            }.foregroundColor(.gray)
                .sheet(isPresented: $showTypeAdding, content: {
                    TypeOfAddingView()
                })
            Spacer(minLength: 0)
            Button(action: {
                self.index = 1
                showCategories.toggle()
            }) {
                VStack
                {
                    
                    Image(systemName: "list.bullet")
                        .font(.system(size: 40))
                        .offset(y:15)
                    Text("Категории")
                        .offset(y:30)
                }
            }.foregroundColor(.gray)
                .sheet(isPresented: $showCategories, content: {
                    CategoryView()
                })
                
        }.padding(.horizontal, 50)
    }
}

#Preview {
    MainScreenView()
}
