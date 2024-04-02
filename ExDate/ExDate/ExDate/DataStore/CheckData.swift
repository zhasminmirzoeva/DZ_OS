

import Foundation

extension Product {
    func checkName()->String {
        if (self.name == "") {
            return "Введите название продукта"
        }
        return ""
    }
    func checkWeight()-> String {
        if (self.weight == 0) {
            return "Введите массу продукта"
        }
        return ""
    }
}

