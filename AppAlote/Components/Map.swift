import SwiftUI
import SceneKit

class MapViewModel : ObservableObject {
    @Published var tappedNodeName : String?
    @Published var showView = false
}

struct MapSceneView: UIViewRepresentable {
    @State var scene = SCNScene()
    let cameraNode = SCNNode()
    let width: CGFloat = 1000
    let height: CGFloat = 1000
    let minZoom: Float = 300
    let maxZoom: Float = 3000
    @ObservedObject var model: MapViewModel
    let floor: Int
    @EnvironmentObject var userManager: UserManager

    func makeUIView(context: Context) -> SCNView {
        let sceneView = SCNView()
        sceneView.scene = scene
        sceneView.allowsCameraControl = false
        
        let tapGesture = UITapGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.handleTap(_:)))
        sceneView.addGestureRecognizer(tapGesture)

        let panGesture = UIPanGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.handlePan(_:)))
        sceneView.addGestureRecognizer(panGesture)

        let pinchGesture = UIPinchGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.handlePinch(_:)))
        sceneView.addGestureRecognizer(pinchGesture)
        
        setupScene()
        return sceneView
    }

    func updateUIView(_ uiView: SCNView, context: Context) { }

    func makeCoordinator() -> Coordinator {
        Coordinator(scene: scene, cameraNode: cameraNode, minZoom: minZoom, maxZoom: maxZoom, model: model)
    }
    
    func setupScene() {
        let camera = SCNCamera()
        camera.zNear = 1
        camera.zFar = 3000
        cameraNode.camera = camera
        cameraNode.position = SCNVector3(x: Float(width / 2), y: Float(height / 2), z: Float(-max(height, width)))
        cameraNode.eulerAngles = SCNVector3(3.1416, 0, 0)
        scene.rootNode.addChildNode(cameraNode)
        
        let ambientLight = SCNLight()
        ambientLight.type = .ambient
        ambientLight.color = UIColor(white: 0.7, alpha: 1.0)
        let ambientLightNode = SCNNode()
        ambientLightNode.light = ambientLight
        scene.rootNode.addChildNode(ambientLightNode)
        
        let directionalLight = SCNLight()
        directionalLight.type = .directional
        directionalLight.color = UIColor(white: 1.0, alpha: 0.1)
        directionalLight.intensity = 1000
        let directionalLightNode = SCNNode()
        directionalLightNode.light = directionalLight
        directionalLightNode.position = SCNVector3(x: Float(width), y: -Float(height / 2), z: Float(-max(height, width)))
        directionalLightNode.eulerAngles = SCNVector3(3.1416, 0.5, 0.5)
        scene.rootNode.addChildNode(directionalLightNode)

        if floor == 0 {
            setupFloor0(scene, width, height)
        } else {
            setupFloor1(scene, width, height)
        }
    }
    
    class Coordinator: NSObject {
        var scene: SCNScene
        var cameraNode: SCNNode
        let minZoom: Float
        let maxZoom: Float
        private var lastPanLocation: CGPoint = .zero
        private var lastPinchScale: CGFloat = 1.0
        private var previousPanLocation: CGPoint?
        private var pinchCenter: CGPoint?
        var model: MapViewModel

        init(scene: SCNScene, cameraNode: SCNNode, minZoom: Float, maxZoom: Float, model: MapViewModel) {
            self.scene = scene
            self.cameraNode = cameraNode
            self.minZoom = minZoom
            self.maxZoom = maxZoom
            self.model = model
        }
            
        @objc func handleTap(_ gestureRecognizer: UITapGestureRecognizer) {
            guard let sceneView = gestureRecognizer.view as? SCNView else { return }
            let location = gestureRecognizer.location(in: sceneView)
            let hitResults = sceneView.hitTest(location, options: [:])
            
            if let firstHit = hitResults.first, let nodeName = firstHit.node.name {
                if nodeName != "DINO" && nodeName != "GRAY"{
                    model.tappedNodeName = nodeName
                    model.showView = true
                }
            }
        }
            
        @objc func handlePan(_ gestureRecognizer: UIPanGestureRecognizer) {
            guard let view = gestureRecognizer.view else { return }
            let currentLocation = gestureRecognizer.location(in: view)
            
            switch gestureRecognizer.state {
            case .began:
                previousPanLocation = currentLocation
                
            case .changed:
                guard let previousLocation = previousPanLocation else { return }
                
                let deltaX = Float(currentLocation.x - previousLocation.x)
                let deltaY = Float(currentLocation.y - previousLocation.y)
                
                let zoomFactor = abs(cameraNode.position.z) / 1000.0
                let moveSpeed: Float = zoomFactor
                
                cameraNode.position.x -= deltaX * moveSpeed
                cameraNode.position.y -= deltaY * moveSpeed
                
                previousPanLocation = currentLocation
                
            case .ended, .cancelled:
                previousPanLocation = nil
                
            default:
                break
            }
        }
            
        @objc func handlePinch(_ gestureRecognizer: UIPinchGestureRecognizer) {
            guard let view = gestureRecognizer.view else { return }
            
            switch gestureRecognizer.state {
            case .began:
                pinchCenter = gestureRecognizer.location(in: view)
                lastPinchScale = gestureRecognizer.scale
                
            case .changed:
                guard let center = pinchCenter else { return }
                let scale = Float(gestureRecognizer.scale / lastPinchScale)
                
                // Convert pinch center to world coordinates
                let viewSize = view.bounds.size
                let normalizedCenter = CGPoint(
                    x: center.x / viewSize.width - 0.5,
                    y: center.y / viewSize.height - 0.5
                )
                
                // Calculate the offset from the camera to the pinch center
                let zoomFactor = abs(cameraNode.position.z) / 1000.0
                let centerOffsetX = Float(-normalizedCenter.x) * zoomFactor * 2000
                let centerOffsetY = Float(-normalizedCenter.y) * zoomFactor * 2000
                
                let newZ = cameraNode.position.z / scale
                
                if newZ >= -maxZoom && newZ <= -minZoom {
                    cameraNode.position = SCNVector3(
                        x: cameraNode.position.x + centerOffsetX * (1 - scale),
                        y: cameraNode.position.y + centerOffsetY * (1 - scale),
                        z: newZ
                    )
                }
                
                lastPinchScale = gestureRecognizer.scale
                
            case .ended:
                pinchCenter = nil
                lastPinchScale = 1.0
                
            default:
                break
            }
        }
    }
}

extension UISegmentedControl {
  override open func didMoveToSuperview() {
     super.didMoveToSuperview()
     self.setContentHuggingPriority(.defaultLow, for: .vertical)
   }
}

struct Map: View {
    
    let mapping = [
        "SOY": 0,
        "CONECTAR": 1,
        "CONOCER": 1,
        "COMPARAR": 1,
        "SEPARAR": 1,
        "PROTEGER": 1,
        "ACTUAR": 1,
        "DECIDIR": 1,
        "DISMINUIR": 1,
        "DISTRIBUIR": 1,
        "RECICLAR": 1,
        "PEQUEÑOS 1": 0,
        "BARCO": 1,
        "AVES": 1,
        "SUBMARINO": 1,
        "TORTUGANERO": 1,
        "SONIDOS PEQUEÑOS": 1,
        "EXPRESO": 0,
        "LUZ": 1,
        "PALABRAS": 1,
        "PATRONES": 1,
        "RELIEVE": 1,
        "TEXTURAS": 1,
        "INFOLINK": 1,
        "HISTORIAS": 1,
        "MENSAJES": 1,
        "COLOR": 1,
        "ARTE": 1,
        "COMPOSICIÓN": 1,
        "PROPORCIÓN": 1,
        "FIGURAS": 1,
        "SONIDOS EXPRESO": 1,
        "MOVIMIENTO": 1,
        "COMPRENDO": 0,
        "SIMULADOR": 1,
        "EXPLORACIÓN": 1,
        "EVIDENCIAS": 1,
        "ESCENARIOS": 1,
        "FENÓMENOS": 1,
        "INNOVACIÓN": 1,
        "MODELOS": 1,
        "INTERPRETACIÓN": 1,
        "INTERDISCIPLINA": 1,
        "GENERACIÓN": 1,
        "BAYLAB": 1,
        "COMUNICO": 0,
        "TELEPRESENCIA": 1,
        "RADIO": 1,
        "TELEVISIÓN": 1,
        "REDES": 1,
        "PEQUEÑOS 2": 0,
        "PUENTE": 1,
        "INVERNADERO": 1,
        "CASITA": 1,
        "FLORES": 1,
        "TRONCO": 1,
        "SUBMARINO 2": 1,
        "PERTENEZCO": 0,
        "VIENTO": 1,
        "MARIPOSAS": 1,
        "SUCULENTAS": 1,
        "CADENA": 1,
        "ESPECIES": 1,
        "BIODIVERSIDAD": 1,
        "ATMÓSFERA": 1,
        "AIRE": 1,
        "ORGANISMOS": 1,
        "SERVICIOS": 1,
        "LOMBRICOMPOSTA": 1,
        "ROCAS": 1,
        "SUPERFICIE": 1,
        "SUELO": 1,
        "MINERALES": 1,
        "ESTRATOS": 1,
        "NATURALEZA": 1,
        "AGUA": 1,
        "TIENDA": 0,
        "IMAX": 0,
        "EXPOSICIONES TEMPORALES": 0
    ]
    @StateObject var model = MapViewModel()
    @State var floor : Int
    
    
    init(floor: Int) {
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(red: 210/255, green: 223/255, blue: 73/255, alpha: 100)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
        UISegmentedControl.appearance().backgroundColor = UIColor(red: (210 * 0.7)/255, green: (223 * 0.7)/255, blue: (73 * 0.7)/255, alpha: 1)
        UISegmentedControl.appearance().setTitleTextAttributes([
            .font: UIFont.systemFont(ofSize: 20),
            
        ], for: .normal)


        self.floor = floor
    }
    
    var body: some View {
        NavigationStack {
            ZStack{
                if floor == 0 {
                    MapSceneView(model: model, floor: 0)
                        .edgesIgnoringSafeArea(.all)
                        .navigationDestination(isPresented: $model.showView){
                            if let name = model.tappedNodeName {
                                if let type = mapping[name] {
                                    if type == 0{
                                        ZoneView(name: name)
                                    } else {
                                        ExhibitionView(name: name)
                                        
                                    }
                                }
                            }
                        }
                } else {
                    MapSceneView(model: model, floor: 1)
                        .edgesIgnoringSafeArea(.all)
                        .navigationDestination(isPresented: $model.showView){
                            if let name = model.tappedNodeName {
                                if let type = mapping[name] {
                                    if type == 0{
                                        ZoneView(name: name)
                                    } else {
                                        ExhibitionView(name: name)
                                        
                                    }
                                }
                            }
                        }
                }
                VStack {
                    
                    Picker("", selection: $floor) {
                        Text("Planta baja").tag(0)

                        Text("Planta alta").tag(1)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                    .frame(height: 75)

               
                    .padding(.top, 30)
                }
                .frame(width: UIScreen.main.bounds.size.width)
                .padding(.vertical, 31.5)
                .frame(maxHeight: UIScreen.main.bounds.size.height, alignment: .top)
                .ignoresSafeArea()
            }
        }
    }
    
}

#Preview {
    Map(floor: 0).environmentObject(UserManager())
}



