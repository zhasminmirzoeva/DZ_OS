

import Foundation
import SwiftUI
import CodeScanner
import AVFoundation

struct AddByBarcodeView: View {
    @State  var name:String = ""
    @State private var weight:Double = 0
    @State private var expireDate: Date = Date()
    @State var categoryName = ""
    @State private var tagInt = 0
    @State private var isOn = false
    @State private var notDate = Date()
    @State private var save = false
    let not = NotificationHandler()
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Category.name, ascending: true)], animation: .default) private var categories: FetchedResults<Category>
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField( "Название", text: $name)
                        .foregroundColor(Color.gray)
                } header: {
                    Text("Название продукта")
                        .font(.system(size: 26, design: .serif))
                        .foregroundColor(Color.white)
                }
                Section {
                    Picker(selection: $categoryName) {
                        ForEach(categories) {category in
                            Text(category.name!).tag(category.name!)
                        }
                    } label: {
                        Text(categoryName)
                    }
                    .pickerStyle(.menu)
                    .id(categoryName)
                } header: {
                    Text("Категория продукта")
                        .font(.system(size: 26, design: .serif))
                        .foregroundColor(Color.white)
                }
                Section {
                    TextField( "Вес", value: $weight, format: .number)
                        .foregroundColor(Color.gray)
                } header: {
                    Text("Вес продукта")
                        .font(.system(size: 26, design: .serif))
                        .foregroundColor(Color.white)
                }
                
                    Section {
                        DatePicker(selection: $expireDate, in: Date.now..., displayedComponents: .date) {
                            
                            Text("Годен до")
                        }
                        
                        
                    } header: {
                        Text("Срок годности продукта")
                            .font(.system(size: 26, design: .serif))
                            .foregroundColor(Color.white)
                    
                }
                Section {
                    Toggle(" ", isOn: $isOn)
                        .toggleStyle(.switch)
                    if (isOn) {
                        DatePicker("Выберите дату", selection: $notDate, in: Date()...)
                        
                    }
                } header: {
                    Text("Получить уведомление об окончании срока годности")
                        .font(.system(size: 26, design: .serif))
                        .foregroundColor(Color.white)
                }
                
                
            }.scrollContentBackground(.hidden)
                .background(blue)
            Button(action: {
                ProductDataModel().addFood(name: name, weight: weight, expireData: expireDate.formatter(), category: ProductDataModel().getCategory(name: categoryName, context: managedObjectContext) ?? Category(), context: managedObjectContext)
                save.toggle()
                not.askPermission()
                not.sendNotification(date: notDate, type: "date", title: "ExDate", body: "Истекает срок годности у \(name)")
                
                
            }) {
                
                Text("Добавить")
                    .frame(height: 40)
                    .font(.system(size: 30, design: .serif))
                    .foregroundColor(blue)
                
            }.fullScreenCover(isPresented: $save, content: {MainScreenView()})
            
            
        }
        
        
    }
    
}

struct BarcodeScannerView: View {
    @State private var scannedCode: String?
    
    var body: some View {
        NavigationView {
            
            if let code = scannedCode {
                AddByBarcodeView(name: "FruStyle")
            } else {
                ScannerView(scannedCode: $scannedCode)
            }
            
            
        }     .navigationBarTitle("Barcode Scanner")
    }
}

struct ScannerView: View {
    @Binding var scannedCode: String?
    
    var body: some View {
        Scanner(
            code: self.$scannedCode, supportBarcode: .constant([.ean8, .ean13])
        )
    }
}

struct Scanner: UIViewControllerRepresentable {
    @Binding var code: String?
    @Binding var supportBarcode: [CodeType]
    
    class Coordinator: NSObject, AVCaptureMetadataOutputObjectsDelegate {
        var parent: Scanner
        
        init(parent: Scanner) {
            self.parent = parent
        }
        
        func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
            if let metadataObject = metadataObjects.first {
                guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
                guard let stringValue = readableObject.stringValue else { return }
                
                DispatchQueue.main.async {
                    self.parent.code = stringValue
                }
            }
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> UIViewController {
        let vc = UIViewController()
        
        let session = AVCaptureSession()
        
        guard let device = AVCaptureDevice.default(for: .video) else { return vc }
        
        do {
            let input = try AVCaptureDeviceInput(device: device)
            session.addInput(input)
        } catch {
            return vc
        }
        
        let output = AVCaptureMetadataOutput()
        session.addOutput(output)
        
        output.setMetadataObjectsDelegate(context.coordinator, queue: DispatchQueue.main)
        output.metadataObjectTypes = supportBarcode.map { $0.rawValue }
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.frame = vc.view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        vc.view.layer.addSublayer(previewLayer)
        
        session.startRunning()
        
        return vc
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

enum CodeType {
    case ean8
    case ean13
    
    var rawValue: AVMetadataObject.ObjectType {
        switch self {
            case .ean8:
                return AVMetadataObject.ObjectType.ean8
            case .ean13:
                return AVMetadataObject.ObjectType.ean13
        }
    }
}
