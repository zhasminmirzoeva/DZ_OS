
import SwiftUI
struct BarcodeScannerView: View {
    @State private var scannedCode: String?
    @State private var isBarcodeFound = false
    @State private var isTapped = false
    let barcodes:[Barcode] = Bundle.main.decode(file: "qr.json")
    var body: some View {
       
            
                   
        NavigationView {
            if let code = scannedCode {
                ForEach(barcodes, id: \.barcode) { barcode in
                    if barcode.barcode == code {
                        AddByBarcodeView(name: barcode.name, weight: barcode.weight, categoryName: barcode.category)
                    }
                }
                
            } else {
                ScannerView(scannedCode: $scannedCode)
            }
            
            
        }
            .navigationBarTitle("Barcode Scanner")
        
    }
}

struct ScannerView: View {
    @Binding var scannedCode: String?
    
    var body: some View {
        Scanner(
            code: self.$scannedCode, supportBarcode: .constant([.ean13])
        )
    }
}
