

import SwiftUI
import Charts
struct PieView: View {
    var data = [ ProductUsage(color: white, quantity: StatisticsModel.usedProducts),ProductUsage(color: green, quantity: 7)]
    
    var body: some View {
        
        HStack {
            Chart {
                ForEach(data)  {d in
                    SectorMark(angle: .value("Quantity", d.quantity),
                               innerRadius: .ratio(0.7), angularInset: 1)
                    .foregroundStyle(d.color)
                    
                }
            }
            .frame(width: 220)
            .offset(x:50)
            VStack {
                HStack {
                    Rectangle()
                        .foregroundColor(green)
                        .frame(width: 15, height: 15)
                        .cornerRadius(100)
                    Text("Использовано")
                        .font(.system(size: 18, design: .serif))
                        .foregroundColor(Color.white)
                }
                .padding(.vertical, 50)
                HStack {
                    Rectangle()
                        .foregroundColor(white)
                        .frame(width: 15, height: 15)
                        .cornerRadius(100)
                    Text("Выброшено")
                        .font(.system(size: 18, design: .serif))
                        .foregroundColor(Color.white)
                }
            }.offset(x:50, y:-50)
            
           
        }
        
    }
}


#Preview {
    MainScreenView()
}
