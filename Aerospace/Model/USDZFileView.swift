import SwiftUI
import RealityKit
import ARKit

struct ARViewContainer: UIViewRepresentable {
    var data: Data
    @Binding var selectedRotationAxis: Axis

    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)

        // Set up AR session with world tracking
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal, .vertical]
        arView.session.run(configuration)

        // Set up gestures
        setUpGestures(in: arView, context: context)

        return arView
    }

    func updateUIView(_ uiView: ARView, context: Context) {}

    private func setUpGestures(in arView: ARView, context: Context) {
        let tapGesture = UITapGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handleTap))
        let pinchGesture = UIPinchGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handlePinch))
        let rotationGesture = UIRotationGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handleRotation))

        arView.addGestureRecognizer(tapGesture)
        arView.addGestureRecognizer(pinchGesture)
        arView.addGestureRecognizer(rotationGesture)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(data: data, selectedRotationAxis: $selectedRotationAxis)
    }

    class Coordinator: NSObject {
        var data: Data
        private var modelEntity: ModelEntity?
        private var isModelPlaced = false
        @Binding var selectedRotationAxis: Axis

        init(data: Data, selectedRotationAxis: Binding<Axis>) {
            self.data = data
            self._selectedRotationAxis = selectedRotationAxis
        }

        @objc func handleTap(_ gesture: UITapGestureRecognizer) {
            guard let arView = gesture.view as? ARView, !isModelPlaced else { return }

            let location = gesture.location(in: arView)
            let raycastQuery = arView.makeRaycastQuery(from: location, allowing: .estimatedPlane, alignment: .any)
            if let raycastQuery = raycastQuery, let raycastResult = arView.session.raycast(raycastQuery).first {
                placeModel(at: raycastResult, in: arView)
            }
        }

        private func placeModel(at raycastResult: ARRaycastResult, in arView: ARView) {
            let anchorEntity = AnchorEntity(world: raycastResult.worldTransform)
            if let modelEntity = createModelEntity() {
                self.modelEntity = modelEntity
                anchorEntity.addChild(modelEntity)
                arView.scene.addAnchor(anchorEntity)
                isModelPlaced = true
            } else {
                print("Failed to create a model entity.")
            }
        }

        private func createModelEntity() -> ModelEntity? {
            do {
                let tempURL = try writeToTemporaryFile(data: data)
                let modelEntity = try ModelEntity.loadModel(contentsOf: tempURL)
                modelEntity.scale = SIMD3<Float>(0.025, 0.025, 0.025) // Adjust scale as needed
                return modelEntity
            } catch {
                print("Error loading model: \(error)")
                return nil
            }
        }

        @objc func handlePinch(_ gesture: UIPinchGestureRecognizer) {
            guard let modelEntity = modelEntity else { return }

            switch gesture.state {
            case .changed:
                let scale = Float(gesture.scale)
                modelEntity.scale *= SIMD3<Float>(repeating: scale)
                gesture.scale = 1
            default:
                break
            }
        }

        @objc func handleRotation(_ gesture: UIRotationGestureRecognizer) {
            guard let modelEntity = modelEntity else { return }

            let rotationAxis: SIMD3<Float> = selectedRotationAxis == .x ? SIMD3<Float>(1, 0, 0) : SIMD3<Float>(0, 1, 0)

            switch gesture.state {
            case .changed:
                let rotation = Float(gesture.rotation)
                modelEntity.transform.rotation *= simd_quatf(angle: rotation, axis: rotationAxis)
                gesture.rotation = 0
            default:
                break
            }
        }

        private func writeToTemporaryFile(data: Data) throws -> URL {
            let tempDir = FileManager.default.temporaryDirectory
            let fileURL = tempDir.appendingPathComponent("model.usdz")
            try data.write(to: fileURL)
            return fileURL
        }
    }
}

enum Axis {
    case x
    case y
}
