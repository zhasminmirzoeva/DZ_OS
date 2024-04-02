/// Главный экран

import SwiftUI


struct MainScreenView: View {
    @State private var index = 0
    @State private var showProducts = false
    @State private var date = Date()
    @State private var notDate = Date()
    let not = NotificationHandler()
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .fill(Color(red: 42 / 255, green: 191 / 255, blue: 176 / 255))
                    .cornerRadius(30)
                    .offset(x: 0, y:-50)
                    .frame(width: .infinity, height: 450)
                VStack
                {
                    HStack {
                        Text("Статистика")
                            .font(.system(size: 26, design: .serif))
                            .foregroundColor(Color(red: 242 / 255, green: 242 / 255, blue: 242 / 255))
                            .offset(y:85)
                    }
                    StatisticsView()
                        .offset(x:-55, y:0)
                }
                
                
            }
            
            HStack {
                DatePicker(selection: $date, in: Date()..., displayedComponents: .date) {
                    Text(" ")
                        
                }
                .environment(\.locale, Locale(identifier: "ru"))
                
               
                Button(action: {
                }) {
                    Image(systemName: "calendar")
                        .font(.system(size: 36))
                        .foregroundColor(Color(red: 42 / 255, green: 191 / 255, blue: 176 / 255))
                }
            }
            .offset(x: -100,y:-45)
            Text("Истечет срок годности")
                .font(.system(size: 24, design: .serif))
                .foregroundColor(black)
                .offset(y:-50)
            
            ListView(date: $date)
               .frame(width: UIScreen.screenWidth, height: 300)
               .offset(y: -60)
            .scrollContentBackground(.hidden)
            CustomTabs(index: self.$index)
             .background(Color(red: 242 / 255, green: 242 / 255, blue: 242 / 255))
             .offset(y:-75)
            
        }

    }
    
}
#Preview {
    MainScreenView()
}
