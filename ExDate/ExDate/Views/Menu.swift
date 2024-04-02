

import SwiftUI

struct MenuView: View {
    var body: some View {
        Menu("m ") {
            Button(action:{}) {
                Text("1")
            }
            Button(action:{}) {
                Text("1")
            }
            Button(action:{}) {
                Text("1")
            }
        }
    }
}

#Preview {
    MenuView()
}
