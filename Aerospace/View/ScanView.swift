import SwiftUI

struct ScanView: View {
    @State private var scannedBarcode: String?
    @State private var isScanning = false

    var body: some View {
        VStack {
            if isScanning {
                QRScannerView(scannedCode: $scannedBarcode, isScanning: $isScanning)
            } else {
                // Display the scanned barcode or a button to start scanning
                if let barcode = scannedBarcode {
                    Text("Scanned Barcode: \(barcode)")
                    // Fetch and display more item details as needed
                } else {
                    Button("Scan QR Code") {
                        isScanning = true
                    }
                }
            }
        }
        .onChange(of: scannedBarcode) { barcode in
            if let barcode = barcode {
                // Fetch item details using the scanned barcode
                print("Scanned Barcode: \(barcode)")
            }
        }
    }
}


#Preview {
    ScanView()
}
