import SwiftUI
import Vision
import AVFoundation
import CoreML

struct MLView: View {
    @StateObject private var cameraManager = CameraManager()
    @State private var classificationLabel: String = "Point the camera at an object..."

    var body: some View {
        VStack {
            if cameraManager.isCameraAvailable {
                CameraPreview(cameraManager: cameraManager)
                    .onAppear {
                        cameraManager.setClassificationHandler { result in
                            self.classificationLabel = result
                        }
                    }
            } else {
                Text("Camera not available")
            }

            Text(classificationLabel)
                .font(.title)
                .padding()
        }
        .onAppear {
            cameraManager.checkAndStartSession()
        }
        .onDisappear {
            cameraManager.stopSession()
        }
    }
}

struct CameraPreview: UIViewRepresentable {
    @ObservedObject var cameraManager: CameraManager

    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: UIScreen.main.bounds)
        cameraManager.previewLayer.frame = view.frame
        view.layer.addSublayer(cameraManager.previewLayer)
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}

class CameraManager: NSObject, ObservableObject {
    private let captureSession = AVCaptureSession()
    let previewLayer = AVCaptureVideoPreviewLayer()
    var isCameraAvailable: Bool { AVCaptureDevice.default(for: .video) != nil }
    private var classificationHandler: ((String) -> Void)?

    func setClassificationHandler(handler: @escaping (String) -> Void) {
        self.classificationHandler = handler
    }

    func checkAndStartSession() {
        checkCameraAccess { granted in
            if granted {
                DispatchQueue.main.async {
                    self.setupAndStartCaptureSession()
                }
            } else {
                // Handle camera access denial
            }
        }
    }

    private func setupAndStartCaptureSession() {
        DispatchQueue.global(qos: .userInitiated).async {
            guard let camera = AVCaptureDevice.default(for: .video) else { return }
            
            do {
                let input = try AVCaptureDeviceInput(device: camera)
                
                DispatchQueue.main.async {
                    if self.captureSession.canAddInput(input) {
                        self.captureSession.addInput(input)
                    }
                    
                    let output = AVCaptureVideoDataOutput()
                    output.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
                    if self.captureSession.canAddOutput(output) {
                        self.captureSession.addOutput(output)
                    }
                    
                    self.previewLayer.session = self.captureSession
                    self.previewLayer.videoGravity = .resizeAspectFill
                }
                
                self.captureSession.startRunning()
            } catch {
                print("Error setting up camera: \(error)")
            }
        }
    }
    
    func stopSession() {
        captureSession.stopRunning()
    }

    private func checkCameraAccess(completion: @escaping (Bool) -> Void) {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            completion(true)
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                completion(granted)
            }
        default:
            completion(false)
        }
    }
}

extension CameraManager: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            print("Failed to get image buffer from sample buffer.")
            return
        }

        do {
            let configuration = MLModelConfiguration()
            let model = try VNCoreMLModel(for: AerospaceClassification(configuration: configuration).model)
            let request = VNCoreMLRequest(model: model) { request, error in
                if let error = error {
                    print("Error in classification: \(error.localizedDescription)")
                    return
                }

                if let results = request.results as? [VNClassificationObservation], let topResult = results.first {
                    DispatchQueue.main.async {
                        self.classificationHandler?("Classification: \(topResult.identifier) Confidence: \(topResult.confidence)")
                    }
                } else {
                    print("No results from VNCoreMLRequest.")
                }
            }

            let requestHandler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:])
            try requestHandler.perform([request])
        } catch {
            print("Error initializing VNCoreMLModel or performing VNImageRequestHandler: \(error.localizedDescription)")
        }
    }
}

#Preview {
    MLView()
}
