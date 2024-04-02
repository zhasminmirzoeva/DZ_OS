//
//  DataModel.swift
//  ExDate
//
//  Created by Zhasmin Mirzoeva on 17/04/24.
//

import Foundation
struct Barcode: Codable {
    var barcode: String
    var name: String
    var category: String
    var weight: Double
    
}
extension Bundle {
    func decode<T: Decodable>(file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Couldn't find \(file) in main bundle")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Couldn't load \(file) from main bundle")
        }
        
        let decoder = JSONDecoder()
        
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("Couldn't parse \(file) as \(T.self):\n\(error)")
        }
    }
    func findQRByCode(code: String) -> Barcode? {
            let qrs: [Barcode] = self.decode(file: "qr.json") // Замените "your_json_file" на имя вашего JSON файла
            
            for qr in qrs {
                if qr.barcode == code {
                    return qr
                }
            }
            return nil
        }
    }

  
