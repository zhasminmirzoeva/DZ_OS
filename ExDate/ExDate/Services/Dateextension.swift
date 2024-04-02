

import Foundation
extension Date {
    func formatter()->String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter.string(from: self)
        
    }
}
