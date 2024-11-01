import SceneKit
import SwiftUI

class MapViewModel: ObservableObject {
    @Published var scene = SCNScene()
    @Published var sceneView: SCNView?
    @Published var selectedText: String?
    @Published var selected = false
    @Published var offset: CGSize = .zero
    @Published var lastOffset: CGSize = .zero
    @Published var scale: CGFloat = 1.0
    @Published var lastScale: CGFloat = 1.0
    @Published var currentFloor: Int = 1
    @Published var savedOffset: CGSize = .zero
    
    func saveCurrentOffset() {
        savedOffset = offset
    }
    
    func restoreOffset() {
        offset = savedOffset
        lastOffset = savedOffset
    }
    
    func restartScene() {
        let newScene = SCNScene()
        scene = newScene
        sceneView?.scene = scene
    }
}

struct Map: View {
    let width = CGFloat(2000)
    let height = CGFloat(2000)
    @State var focused: String
    
    
    // name : (x, y, floor, type)
    // floor: 1 or 2
    // type: "Zone", "Exhibition" or "Floor"
    
    let mapping = [
        "Planta baja": (-550, -553, 1, "Floor", ""),
        "Planta alta": (-550, -553, 2, "Floor", ""),
        "SOY": (-550, -553, 1, "Zone", ""),
        "CONECTAR": (1, 1, 1, "Exhibition", "SOY"),
        "CONOCER": (1, 1, 1, "Exhibition", "SOY"),
        "COMPARAR": (1, 1, 1, "Exhibition", "SOY"),
        "SEPARAR": (1, 1, 1, "Exhibition", "SOY"),
        "PROTEGER": (1, 1, 1, "Exhibition", "SOY"),
        "ACTUAR": (1, 1, 1, "Exhibition", "SOY"),
        "DECIDIR": (1, 1, 1, "Exhibition", "SOY"),
        "DISMINUIR": (1, 1, 1, "Exhibition", "SOY"),
        "DISTRIBUIR": (1, 1, 1, "Exhibition", "SOY"),
        "RECICLAR": (1, 1, 1, "Exhibition", "SOY"),
        "PEQUEÑOS 1": (-550, -553, 1, "Zone", ""),
        "BARCO": (1, 1, 1, "Exhibition", "PEQUEÑOS 1"),
        "AVES": (1, 1, 1, "Exhibition", "PEQUEÑOS 1"),
        "SUBMARINO": (1, 1, 1, "Exhibition", "PEQUEÑOS 1"),
        "TORTUGANERO": (1, 1, 1, "Exhibition", "PEQUEÑOS 1"),
        "SONIDOS PEQUEÑOS": (1, 1, 1, "Exhibition", "PEQUEÑOS 1"),
        "EXPRESO": (-550, -553, 1, "Zone", ""),
        "LUZ": (1, 1, 1, "Exhibition", "EXPRESO"),
        "PALABRAS": (1, 1, 1, "Exhibition", "EXPRESO"),
        "PATRONES": (1, 1, 1, "Exhibition", "EXPRESO"),
        "RELIEVE": (1, 1, 1, "Exhibition", "EXPRESO"),
        "TEXTURAS": (1, 1, 1, "Exhibition", "EXPRESO"),
        "INFOLINK": (1, 1, 1, "Exhibition", "EXPRESO"),
        "HISTORIAS": (1, 1, 1, "Exhibition", "EXPRESO"),
        "MENSAJES": (1, 1, 1, "Exhibition", "EXPRESO"),
        "COLOR": (1, 1, 1, "Exhibition", "EXPRESO"),
        "ARTE": (1, 1, 1, "Exhibition", "EXPRESO"),
        "COMPOSICIÓN": (1, 1, 1, "Exhibition", "EXPRESO"),
        "PROPORCIÓN": (1, 1, 1, "Exhibition", "EXPRESO"),
        "FIGURAS": (1, 1, 1, "Exhibition", "EXPRESO"),
        "SONIDOS EXPRESO": (1, 1, 1, "Exhibition", "EXPRESO"),
        "MOVIMIENTO": (1, 1, 1, "Exhibition", "EXPRESO"),
        "COMPRENDO": (-550, -553, 1, "Zone", ""),
        "SIMULADOR": (1, 1, 1, "Exhibition", "COMPRENDO"),
        "EXPLORACIÓN": (1, 1, 1, "Exhibition", "COMPRENDO"),
        "EVIDENCIAS": (1, 1, 1, "Exhibition", "COMPRENDO"),
        "ESCENARIOS": (1, 1, 1, "Exhibition", "COMPRENDO"),
        "FENÓMENOS": (1, 1, 1, "Exhibition", "COMPRENDO"),
        "INNOVACIÓN": (1, 1, 1, "Exhibition", "COMPRENDO"),
        "MODELOS": (1, 1, 1, "Exhibition", "COMPRENDO"),
        "INTERPRETACIÓN": (1, 1, 1, "Exhibition", "COMPRENDO"),
        "INTERDISCIPLINA": (1, 1, 1, "Exhibition", "COMPRENDO"),
        "GENERACIÓN": (1, 1, 1, "Exhibition", "COMPRENDO"),
        "BAYLAB": (1, 1, 1, "Exhibition", "COMPRENDO"),
        "COMUNICO": (-550, -553, 2, "Zone", ""),
        "TELEPRESENCIA": (1, 1, 2, "Exhibition", "COMUNICO"),
        "RADIO": (1, 1, 2, "Exhibition", "COMUNICO"),
        "TELEVISIÓN": (1, 1, 2, "Exhibition", "COMUNICO"),
        "REDES": (1, 1, 2, "Exhibition", "COMUNICO"),
        "PEQUEÑOS 2": (-550, -553, 2, "Zone", ""),
        "PUENTE": (1, 1, 2, "Exhibition", "PEQUEÑOS 2"),
        "INVERNADERO": (1, 1, 2, "Exhibition", "PEQUEÑOS 2"),
        "CASITA": (1, 1, 2, "Exhibition", "PEQUEÑOS 2"),
        "FLORES": (1, 1, 2, "Exhibition", "PEQUEÑOS 2"),
        "TRONCO": (1, 1, 2, "Exhibition", "PEQUEÑOS 2"),
        "SUBMARINO 2": (1, 1, 2, "Exhibition", "PEQUEÑOS 2"),
        "PERTENEZCO": (-550, -553, 2, "Zone", ""),
        "VIENTO": (1, 1, 2, "Exhibition", "PERTENEZCO"),
        "MARIPOSAS": (1, 1, 2, "Exhibition", "PERTENEZCO"),
        "SUCULENTAS": (1, 1, 2, "Exhibition", "PERTENEZCO"),
        "CADENA": (1, 1, 2, "Exhibition", "PERTENEZCO"),
        "ESPECIES": (1, 1, 2, "Exhibition", "PERTENEZCO"),
        "BIODIVERSIDAD": (1, 1, 2, "Exhibition", "PERTENEZCO"),
        "ATMÓSFERA": (1, 1, 2, "Exhibition", "PERTENEZCO"),
        "AIRE": (1, 1, 2, "Exhibition", "PERTENEZCO"),
        "ORGANISMOS": (1, 1, 2, "Exhibition", "PERTENEZCO"),
        "SERVICIOS": (1, 1, 2, "Exhibition", "PERTENEZCO"),
        "LOMBRICOMPOSTA": (1, 1, 2, "Exhibition", "PERTENEZCO"),
        "ROCAS": (1, 1, 2, "Exhibition", "PERTENEZCO"),
        "SUPERFICIE": (1, 1, 2, "Exhibition", "PERTENEZCO"),
        "SUELO": (1, 1, 2, "Exhibition", "PERTENEZCO"),
        "MINERALES": (1, 1, 2, "Exhibition", "PERTENEZCO"),
        "ESTRATOS": (1, 1, 2, "Exhibition", "PERTENEZCO"),
        "NATURALEZA": (1, 1, 2, "Exhibition", "PERTENEZCO"),
        "AGUA": (1, 1, 2, "Exhibition", "PERTENEZCO")
        
    ]
    @StateObject public var viewModel = MapViewModel()

    var body: some View {
        NavigationStack {
            ZStack {
                ZStack {
                    SceneView(
                        scene: viewModel.scene,
                        options: [.autoenablesDefaultLighting]
                    )
                    .onAppear {
                        if let (x, y, floor, _, _) = mapping[focused] {
                            let focusOffset = CGSize(
                                width: CGFloat(x),
                                height: CGFloat(y)
                            )
                            if viewModel.savedOffset == .zero {
                                viewModel.offset = focusOffset
                                viewModel.lastOffset = focusOffset
                            } else {
                                viewModel.restoreOffset()
                            }
                            viewModel.currentFloor = floor
                            addAssets(in: viewModel.scene)
                        }
                    }
                    .background(GeometryReader { geometry in
                        Color.clear.onAppear {
                            viewModel.sceneView = SCNView(frame: geometry.frame(in: .local))
                            viewModel.sceneView?.scene = viewModel.scene
                        }
                    })
                    .gesture(
                        TapGesture(count: 2)
                            .sequenced(before:
                                DragGesture(minimumDistance: 0)
                                    .onEnded { gesture in
                                        guard let sceneView = viewModel.sceneView else {
                                            print("SceneView not initialized")
                                            return
                                        }
                                        let hitResults = sceneView.hitTest(gesture.location, options: [:])
                                        if let firstHit = hitResults.first, let nodeName = firstHit.node.name {
                                            viewModel.selectedText = nodeName
                                            viewModel.saveCurrentOffset()
                                            viewModel.selected = true
                                            
                                            
                                            
                                        }
                                    }
                            )
                    )
                    .frame(width: width, height: height)
                }
                .offset(viewModel.offset)
                .scaleEffect(viewModel.scale)
                .gesture(
                    SimultaneousGesture(
                        DragGesture()
                            .onChanged { value in
                                viewModel.offset = CGSize(
                                    width: viewModel.lastOffset.width + value.translation.width,
                                    height: viewModel.lastOffset.height + value.translation.height
                                )
                                print(viewModel.offset)
                            }
                            .onEnded { _ in
                                viewModel.lastOffset = viewModel.offset
                            },
                        MagnificationGesture()
                            .onChanged { value in
                                let delta = value / viewModel.lastScale
                                viewModel.lastScale = value
                                let newScale = viewModel.scale * delta
                                viewModel.scale = min(max(newScale, 0.5), 3.0)
                            }
                            .onEnded { _ in
                                viewModel.lastScale = 1.0
                            }
                    )
                )
                
                .navigationDestination(isPresented: $viewModel.selected) {
                    if let (_, _, floor, type, zone) = mapping[viewModel.selectedText ?? "Pertenezco"] {
                            
                            if type == "Zone"{
                                ZoneView(name: viewModel.selectedText ?? "PERTENEZCO")
                            } else {
                                ExhibitionView(name: viewModel.selectedText ?? "ATRATOS", zone: zone, floor: floor)
                            }
                        }
                        // Text(viewModel.selectedText ?? "No text available")
                    }
                
                if focused == "Planta baja" || focused == "Planta alta" {
                    VStack {
                        HStack {
                            Spacer()
                            Text(focused)
                                .font(.system(size: 33))
                                .fixedSize(horizontal: true, vertical: false)
                            Spacer()
                            Button {
                                

                                if focused == "Planta baja" {
                                    focused = "Planta alta"
                                    viewModel.currentFloor = 2
                                } else {
                                    focused = "Planta baja"
                                    viewModel.currentFloor = 1
                                }
                                viewModel.restartScene()
                                addAssets(in: viewModel.scene)

                            } label: {
                                Text("Cambiar piso")
                                    .font(.system(size: 25))
                                    .foregroundStyle(Color.black)
                                    .fixedSize(horizontal: true, vertical: false)
                            }
                            .padding(15)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color(red: 210/255, green: 223/255, blue: 73/255))
                            )
                            Spacer()
                        }
                        .padding(.top, 40)
                    }
                    .frame(width: UIScreen.main.bounds.size.width)
                    .padding(.vertical, 33)
                    .background(Color.purple)
                    .frame(maxHeight: UIScreen.main.bounds.size.height, alignment: .top)
                    .ignoresSafeArea()
                }
            }
        }
    }
    

    func addAssets(in scene: SCNScene) {
        
        let width: CGFloat = 1000
        let height: CGFloat = 1000
        var color: UIColor
        
        // IMAX
        if viewModel.currentFloor == 1 {
            
            let backgroundPath = UIBezierPath()
            backgroundPath.move(to: CGPoint(x: 0, y: 0.07822 * height))
            backgroundPath.addLine(to: CGPoint(x: 0, y: 0.37779 * height))
            backgroundPath.addLine(to: CGPoint(x: 0.03722 * width, y: 0.37752 * height))
            backgroundPath.addLine(to: CGPoint(x: 0.03722 * width, y: 0.38767 * height))
            backgroundPath.addLine(to: CGPoint(x: 0.05034 * width, y: 0.38741 * height))
            backgroundPath.addLine(to: CGPoint(x: 0.05025 * width, y: 0.37707 * height))
            backgroundPath.addLine(to: CGPoint(x: 0.09445 * width, y: 0.37707 * height))
            backgroundPath.addLine(to: CGPoint(x: 0.09463 * width, y: 0.38678 * height))
            backgroundPath.addLine(to: CGPoint(x: 0.10298 * width, y: 0.3866 * height))
            backgroundPath.addLine(to: CGPoint(x: 0.10298 * width, y: 0.37707 * height))
            backgroundPath.addLine(to: CGPoint(x: 0.13907 * width, y: 0.37689 * height))
            backgroundPath.addLine(to: CGPoint(x: 0.13907 * width, y: 0.38013 * height))
            backgroundPath.addLine(to: CGPoint(x: 0.1474 * width, y: 0.37987 * height))
            backgroundPath.addLine(to: CGPoint(x: 0.14734 * width, y: 0.37689 * height))
            backgroundPath.addLine(to: CGPoint(x: 0.1602 * width, y: 0.37689 * height))
            backgroundPath.addLine(to: CGPoint(x: 0.56024 * width, y: 0.93621 * height))
            backgroundPath.addCurve(to: CGPoint(x: 0.58241 * width, y: 0.94896 * height), controlPoint1: CGPoint(x: 0.5638 * width, y: 0.94173 * height), controlPoint2: CGPoint(x: 0.57519 * width, y: 0.94757 * height))
            backgroundPath.addLine(to: CGPoint(x: 0.74682 * width, y: 0.94896 * height))
            backgroundPath.addCurve(to: CGPoint(x: 0.76504 * width, y: 0.94146 * height), controlPoint1: CGPoint(x: 0.75257 * width, y: 0.94777 * height), controlPoint2: CGPoint(x: 0.76182 * width, y: 0.94484 * height))
            backgroundPath.addCurve(to: CGPoint(x: 0.7725 * width, y: 0.9335 * height), controlPoint1: CGPoint(x: 0.76712 * width, y: 0.9396 * height), controlPoint2: CGPoint(x: 0.77085 * width, y: 0.93561 * height))
            backgroundPath.addLine(to: CGPoint(x: 0.86637 * width, y: 0.74373 * height))
            backgroundPath.addLine(to: CGPoint(x: 0.97266 * width, y: 0.68535 * height))
            backgroundPath.addLine(to: CGPoint(x: 0.98311 * width, y: 0.67425 * height))
            backgroundPath.addCurve(to: CGPoint(x: 0.98833 * width, y: 0.65314 * height), controlPoint1: CGPoint(x: 0.98595 * width, y: 0.66919 * height), controlPoint2: CGPoint(x: 0.98903 * width, y: 0.65891 * height))
            backgroundPath.addLine(to: CGPoint(x: 0.96182 * width, y: 0.48075 * height))
            backgroundPath.addCurve(to: CGPoint(x: 0.94512 * width, y: 0.46509 * height), controlPoint1: CGPoint(x: 0.9585 * width, y: 0.47504 * height), controlPoint2: CGPoint(x: 0.95098 * width, y: 0.46658 * height))
            backgroundPath.addLine(to: CGPoint(x: 0.60466 * width, y: 0.39729 * height))
            backgroundPath.addLine(to: CGPoint(x: 0.60486 * width, y: 0.10918 * height))
            backgroundPath.addLine(to: CGPoint(x: 0.55083 * width, y: 0.10918 * height))
            backgroundPath.addLine(to: CGPoint(x: 0.55083 * width, y: 0.14039 * height))
            backgroundPath.addCurve(to: CGPoint(x: 0.54616 * width, y: 0.14579 * height), controlPoint1: CGPoint(x: 0.55062 * width, y: 0.14271 * height), controlPoint2: CGPoint(x: 0.54814 * width, y: 0.14524 * height))
            backgroundPath.addLine(to: CGPoint(x: 0.32501 * width, y: 0.22969 * height))
            backgroundPath.addLine(to: CGPoint(x: 0.21686 * width, y: 0.07822 * height))
            backgroundPath.addLine(to: CGPoint(x: 0.14734 * width, y: 0.07822 * height))
            backgroundPath.addLine(to: CGPoint(x: 0.14734 * width, y: 0.07508 * height))
            backgroundPath.addLine(to: CGPoint(x: 0.13907 * width, y: 0.07508 * height))
            backgroundPath.addLine(to: CGPoint(x: 0.13907 * width, y: 0.07782 * height))
            backgroundPath.addLine(to: CGPoint(x: 0.10298 * width, y: 0.07822 * height))
            backgroundPath.addLine(to: CGPoint(x: 0.10298 * width, y: 0.06868 * height))
            backgroundPath.addLine(to: CGPoint(x: 0.09445 * width, y: 0.06868 * height))
            backgroundPath.addLine(to: CGPoint(x: 0.09445 * width, y: 0.07812 * height))
            backgroundPath.addLine(to: CGPoint(x: 0.05034 * width, y: 0.07751 * height))
            backgroundPath.addLine(to: CGPoint(x: 0.05025 * width, y: 0.06777 * height))
            backgroundPath.addLine(to: CGPoint(x: 0.03722 * width, y: 0.06777 * height))
            backgroundPath.addLine(to: CGPoint(x: 0.03722 * width, y: 0.07782 * height))
            backgroundPath.addLine(to: CGPoint(x: 0, y: 0.07822 * height))
            let backgroundShape = SCNShape(path: backgroundPath, extrusionDepth: 80)
            let backgroundMaterial = SCNMaterial()
            backgroundMaterial.diffuse.contents = UIColor.gray
            backgroundShape.materials = [backgroundMaterial]
            let backgroundNode = SCNNode(geometry: backgroundShape)
            backgroundNode.position = SCNVector3(0, 0, 0)
            backgroundNode.name = "background"
            backgroundNode.eulerAngles = SCNVector3(-0.5, Float(Double.pi), Float(Double.pi))
            scene.rootNode.addChildNode(backgroundNode)
            
            var textGeometry = SCNText(string: "IMAX", extrusionDepth: 0)
            textGeometry.font = UIFont.boldSystemFont(ofSize: 11)
            textGeometry.firstMaterial?.diffuse.contents = UIColor.black
            var textNode = SCNNode(geometry: textGeometry)
            textNode.position = SCNVector3(200, -240, 500)
            
            textNode.name = "IMAX"
            scene.rootNode.addChildNode(textNode)
            
            var path = UIBezierPath()
            path.move(to: CGPoint(x: 0.00579 * width, y: 0.08299 * height))
            path.addLine(to: CGPoint(x: 0.21474 * width, y: 0.08299 * height))
            path.addLine(to: CGPoint(x: 0.34668 * width, y: 0.2682 * height))
            path.addLine(to: CGPoint(x: 0.2147 * width, y: 0.31849 * height))
            path.addCurve(to: CGPoint(x: 0.20183 * width, y: 0.34455 * height), controlPoint1: CGPoint(x: 0.20944 * width, y: 0.32324 * height), controlPoint2: CGPoint(x: 0.20314 * width, y: 0.33638 * height))
            path.addLine(to: CGPoint(x: 0.20183 * width, y: 0.37217 * height))
            path.addLine(to: CGPoint(x: 0.00579 * width, y: 0.37238 * height))
            path.addLine(to: CGPoint(x: 0.00579 * width, y: 0.08299 * height))
            var foregroundShape = SCNShape(path: path, extrusionDepth: 15)
            var foregroundMaterial = SCNMaterial()
            foregroundMaterial.diffuse.contents = UIColor.blue
            foregroundShape.materials = [foregroundMaterial]
            var foregroundNode = SCNNode(geometry: foregroundShape)
            foregroundNode.position = SCNVector3(0, 20, 40)
            foregroundNode.eulerAngles = SCNVector3(-0.50, Float(Double.pi), Float(Double.pi))
            foregroundNode.name = "IMAX"
            scene.rootNode.addChildNode(foregroundNode)
            
            
            // SOY
            color = UIColor(red: 214 / 255, green: 41 / 255, blue: 45 / 255, alpha: 1)
            path = UIBezierPath()
            path.move(to: CGPoint(x: 0.76876*width, y: 0.90085*height))
            path.addCurve(to: CGPoint(x: 0.74271*width, y: 0.90948*height), controlPoint1: CGPoint(x: 0.76566*width, y: 0.90625*height), controlPoint2: CGPoint(x: 0.75299*width, y: 0.9104*height))
            path.addLine(to: CGPoint(x: 0.57354*width, y: 0.90906*height))
            path.addCurve(to: CGPoint(x: 0.55309*width, y: 0.90078*height), controlPoint1: CGPoint(x: 0.56387*width, y: 0.90917*height), controlPoint2: CGPoint(x: 0.55723*width, y: 0.90415*height))
            path.addLine(to: CGPoint(x: 0.3793*width, y: 0.65741*height))
            path.addLine(to: CGPoint(x: 0.43287*width, y: 0.55201*height))
            path.addCurve(to: CGPoint(x: 0.44381*width, y: 0.54195*height), controlPoint1: CGPoint(x: 0.4384*width, y: 0.54336*height), controlPoint2: CGPoint(x: 0.44242*width, y: 0.54289*height))
            path.addCurve(to: CGPoint(x: 0.52477*width, y: 0.5608*height), controlPoint1: CGPoint(x: 0.4452*width, y: 0.54101*height), controlPoint2: CGPoint(x: 0.47234*width, y: 0.54667*height))
            path.addLine(to: CGPoint(x: 0.54696*width, y: 0.5547*height))
            path.addLine(to: CGPoint(x: 0.55309*width, y: 0.55201*height))
            path.addLine(to: CGPoint(x: 0.57124*width, y: 0.61564*height))
            path.addCurve(to: CGPoint(x: 0.55309*width, y: 0.68309*height), controlPoint1: CGPoint(x: 0.5396*width, y: 0.62358*height), controlPoint2: CGPoint(x: 0.52727*width, y: 0.65614*height))
            path.addLine(to: CGPoint(x: 0.64898*width, y: 0.73922*height))
            path.addCurve(to: CGPoint(x: 0.70865*width, y: 0.74706*height), controlPoint1: CGPoint(x: 0.66346*width, y: 0.74462*height), controlPoint2: CGPoint(x: 0.69329*width, y: 0.74858*height))
            path.addLine(to: CGPoint(x: 0.75629*width, y: 0.83354*height))
            path.addLine(to: CGPoint(x: 0.76876*width, y: 0.90085*height))
            foregroundShape = SCNShape(path: path, extrusionDepth: 25)
            foregroundMaterial = SCNMaterial()
            foregroundMaterial.diffuse.contents = color
            foregroundShape.materials = [foregroundMaterial]
            foregroundNode = SCNNode(geometry: foregroundShape)
            foregroundNode.position = SCNVector3(0, 30, 40)
            foregroundNode.eulerAngles = SCNVector3(-0.50, Float(Double.pi), Float(Double.pi))
            foregroundNode.name = "SOY"
            scene.rootNode.addChildNode(foregroundNode)
            
            
            textGeometry = SCNText(string: "SOY", extrusionDepth: 0)
            textGeometry.font = UIFont.boldSystemFont(ofSize: 11)
            textGeometry.firstMaterial?.diffuse.contents = UIColor.black
            textNode = SCNNode(geometry: textGeometry)
            textNode.position = SCNVector3(580, -630, 500)
            textNode.eulerAngles = SCNVector3(0, 0, 25)
            textNode.name = "SOY"
            scene.rootNode.addChildNode(textNode)
            
            
            // SOY / MODULES
            color = UIColor(red: 162 / 255, green: 31 / 255, blue: 36 / 255, alpha: 1)
            
            
            // SOY / MODULES / CONECTAR
            path = UIBezierPath()
            path.move(to: CGPoint(x: 0.38164*width, y: 0.65483*height))
            path.addLine(to: CGPoint(x: 0.38926*width, y: 0.63743*height))
            path.addLine(to: CGPoint(x: 0.40359*width, y: 0.63556*height))
            path.addCurve(to: CGPoint(x: 0.41223*width, y: 0.6387*height), controlPoint1: CGPoint(x: 0.40604*width, y: 0.63524*height), controlPoint2: CGPoint(x: 0.4103*width, y: 0.63606*height))
            path.addCurve(to: CGPoint(x: 0.42688*width, y: 0.66023*height), controlPoint1: CGPoint(x: 0.4176*width, y: 0.64633*height), controlPoint2: CGPoint(x: 0.42528*width, y: 0.657*height))
            path.addCurve(to: CGPoint(x: 0.42374*width, y: 0.66955*height), controlPoint1: CGPoint(x: 0.42799*width, y: 0.66268*height), controlPoint2: CGPoint(x: 0.42708*width, y: 0.6668*height))
            path.addQuadCurve(to: CGPoint(x: 0.40739*width, y: 0.68961*height), controlPoint: CGPoint(x: 0.42323*width, y: 0.67026*height))
            path.addLine(to: CGPoint(x: 0.38164*width, y: 0.65483*height))
            
            foregroundShape = SCNShape(path: path, extrusionDepth: 25)
            foregroundMaterial = SCNMaterial()
            foregroundMaterial.diffuse.contents = color
            foregroundShape.materials = [foregroundMaterial]
            foregroundNode = SCNNode(geometry: foregroundShape)
            foregroundNode.position = SCNVector3(0, 30, 70)
            foregroundNode.eulerAngles = SCNVector3(-0.50, Float(Double.pi), Float(Double.pi))
            foregroundNode.name = "CONECTAR"
            scene.rootNode.addChildNode(foregroundNode)
            
            // SOY / MODULES / CONOCER
            path = UIBezierPath()
            path.move(to: CGPoint(x: 0.42955*width, y: 0.71639*height))
            path.addLine(to: CGPoint(x: 0.43289*width, y: 0.71794*height))
            path.addLine(to: CGPoint(x: 0.43642*width, y: 0.70697*height))
            path.addLine(to: CGPoint(x: 0.42587*width, y: 0.6924*height))
            path.addLine(to: CGPoint(x: 0.41313*width, y: 0.69643*height))
            path.addLine(to: CGPoint(x: 0.41548*width, y: 0.7006*height))
            path.addCurve(to: CGPoint(x: 0.4227*width, y: 0.6988*height), controlPoint1: CGPoint(x: 0.4171*width, y: 0.69982*height), controlPoint2: CGPoint(x: 0.42066*width, y: 0.69887*height))
            path.addCurve(to: CGPoint(x: 0.42955*width, y: 0.70833*height), controlPoint1: CGPoint(x: 0.42481*width, y: 0.70084*height), controlPoint2: CGPoint(x: 0.42823*width, y: 0.70561*height))
            path.addCurve(to: CGPoint(x: 0.42955*width, y: 0.71639*height), controlPoint1: CGPoint(x: 0.4305*width, y: 0.71*height), controlPoint2: CGPoint(x: 0.43007*width, y: 0.71398*height))
            foregroundShape = SCNShape(path: path, extrusionDepth: 25)
            foregroundMaterial = SCNMaterial()
            foregroundMaterial.diffuse.contents = color
            foregroundShape.materials = [foregroundMaterial]
            foregroundNode = SCNNode(geometry: foregroundShape)
            foregroundNode.position = SCNVector3(0, 30, 70)
            foregroundNode.eulerAngles = SCNVector3(-0.50, Float(Double.pi), Float(Double.pi))
            foregroundNode.name = "CONOCER"
            scene.rootNode.addChildNode(foregroundNode)
            
            
            // SOY / MODULES / DECIDIR
            path = UIBezierPath()
            path.move(to: CGPoint(x: 0.44634*width, y: 0.72424*height))
            path.addCurve(to: CGPoint(x: 0.44457*width, y: 0.74434*height), controlPoint1: CGPoint(x: 0.44067*width, y: 0.72925*height), controlPoint2: CGPoint(x: 0.4409*width, y: 0.7392*height))
            path.addLine(to: CGPoint(x: 0.52836*width, y: 0.85769*height))
            path.addCurve(to: CGPoint(x: 0.54724*width, y: 0.86114*height), controlPoint1: CGPoint(x: 0.5331*width, y: 0.86414*height), controlPoint2: CGPoint(x: 0.54223*width, y: 0.86375*height))
            path.addLine(to: CGPoint(x: 0.58432*width, y: 0.83374*height))
            path.addCurve(to: CGPoint(x: 0.58524*width, y: 0.81508*height), controlPoint1: CGPoint(x: 0.5887*width, y: 0.82932*height), controlPoint2: CGPoint(x: 0.58796*width, y: 0.8201*height))
            path.addLine(to: CGPoint(x: 0.50219*width, y: 0.70224*height))
            path.addCurve(to: CGPoint(x: 0.47841*width, y: 0.7016*height), controlPoint1: CGPoint(x: 0.49721*width, y: 0.69488*height), controlPoint2: CGPoint(x: 0.48523*width, y: 0.69605*height))
            path.addLine(to: CGPoint(x: 0.44634*width, y: 0.72424*height))
            
            
            foregroundShape = SCNShape(path: path, extrusionDepth: 25)
            foregroundMaterial = SCNMaterial()
            foregroundMaterial.diffuse.contents = color
            foregroundShape.materials = [foregroundMaterial]
            foregroundNode = SCNNode(geometry: foregroundShape)
            foregroundNode.position = SCNVector3(0, 30, 70)
            foregroundNode.eulerAngles = SCNVector3(-0.50, Float(Double.pi), Float(Double.pi))
            foregroundNode.name = "DECIDIR"
            scene.rootNode.addChildNode(foregroundNode)
            
            
            path = UIBezierPath()
            path.addArc(withCenter: CGPoint(x: 0.44634 * width, y: 0.72424 * height), radius: CGFloat(20),  startAngle: 0, endAngle: CGFloat(2 * Double.pi), clockwise: true)
            foregroundShape = SCNShape(path: path, extrusionDepth: 25)
            foregroundMaterial = SCNMaterial()
            foregroundMaterial.diffuse.contents = color
            foregroundShape.materials = [foregroundMaterial]
            foregroundNode = SCNNode(geometry: foregroundShape)
            foregroundNode.position = SCNVector3(10, 110, 20)
            foregroundNode.eulerAngles = SCNVector3(-0.50, Float(Double.pi), Float(Double.pi))
            foregroundNode.name = "COMPARAR"
            scene.rootNode.addChildNode(foregroundNode)
            
            path = UIBezierPath()
            path.move(to: CGPoint(x: 0.50548*width, y: 0.67035*height))
            path.addLine(to: CGPoint(x: 0.5213*width, y: 0.64632*height))
            path.addCurve(to: CGPoint(x: 0.51831*width, y: 0.63869*height), controlPoint1: CGPoint(x: 0.5224*width, y: 0.64422*height), controlPoint2: CGPoint(x: 0.52161*width, y: 0.64064*height))
            path.addCurve(to: CGPoint(x: 0.51041*width, y: 0.64016*height), controlPoint1: CGPoint(x: 0.51397*width, y: 0.63723*height), controlPoint2: CGPoint(x: 0.51199*width, y: 0.63886*height))
            path.addLine(to: CGPoint(x: 0.49438*width, y: 0.66376*height))
            path.addCurve(to: CGPoint(x: 0.49622*width, y: 0.67192*height), controlPoint1: CGPoint(x: 0.49333*width, y: 0.66659*height), controlPoint2: CGPoint(x: 0.49427*width, y: 0.67055*height))
            path.addCurve(to: CGPoint(x: 0.50548*width, y: 0.67035*height), controlPoint1: CGPoint(x: 0.49858*width, y: 0.67386*height), controlPoint2: CGPoint(x: 0.50321*width, y: 0.6732*height))
            foregroundShape = SCNShape(path: path, extrusionDepth: 25)
            foregroundMaterial = SCNMaterial()
            foregroundMaterial.diffuse.contents = color
            foregroundShape.materials = [foregroundMaterial]
            foregroundNode = SCNNode(geometry: foregroundShape)
            foregroundNode.position = SCNVector3(0, 30, 70)
            foregroundNode.eulerAngles = SCNVector3(-0.50, Float(Double.pi), Float(Double.pi))
            foregroundNode.name = "SEPARAR"
            scene.rootNode.addChildNode(foregroundNode)
            
            
            path = UIBezierPath()
            path.move(to: CGPoint(x: 0.5245*width, y: 0.61489*height))
            path.addLine(to: CGPoint(x: 0.54503*width, y: 0.60509*height))
            path.addLine(to: CGPoint(x: 0.54248*width, y: 0.59058*height))
            path.addLine(to: CGPoint(x: 0.53644*width, y: 0.59344*height))
            path.addLine(to: CGPoint(x: 0.53875*width, y: 0.60021*height))
            path.addLine(to: CGPoint(x: 0.52253*width, y: 0.60987*height))
            path.addLine(to: CGPoint(x: 0.5245*width, y: 0.61489*height))
            foregroundShape = SCNShape(path: path, extrusionDepth: 25)
            foregroundMaterial = SCNMaterial()
            foregroundMaterial.diffuse.contents = color
            foregroundShape.materials = [foregroundMaterial]
            foregroundNode = SCNNode(geometry: foregroundShape)
            foregroundNode.position = SCNVector3(0, 30, 70)
            foregroundNode.eulerAngles = SCNVector3(-0.50, Float(Double.pi), Float(Double.pi))
            foregroundNode.name = "ACTUAR"
            scene.rootNode.addChildNode(foregroundNode)
            
            path = UIBezierPath()
            path.move(to: CGPoint(x: 0.50349*width, y: 0.61977*height))
            path.addLine(to: CGPoint(x: 0.51556*width, y: 0.6025*height))
            path.addLine(to: CGPoint(x: 0.54602*width, y: 0.58809*height))
            path.addLine(to: CGPoint(x: 0.55265*width, y: 0.57324*height))
            path.addLine(to: CGPoint(x: 0.54873*width, y: 0.57172*height))
            path.addLine(to: CGPoint(x: 0.54235*width, y: 0.58492*height))
            path.addLine(to: CGPoint(x: 0.51274*width, y: 0.59878*height))
            path.addLine(to: CGPoint(x: 0.49988*width, y: 0.61731*height))
            path.addLine(to: CGPoint(x: 0.50349*width, y: 0.61977*height))
            foregroundShape = SCNShape(path: path, extrusionDepth: 25)
            foregroundMaterial = SCNMaterial()
            foregroundMaterial.diffuse.contents = color
            foregroundShape.materials = [foregroundMaterial]
            foregroundNode = SCNNode(geometry: foregroundShape)
            foregroundNode.position = SCNVector3(0, 30, 70)
            foregroundNode.eulerAngles = SCNVector3(-0.50, Float(Double.pi), Float(Double.pi))
            foregroundNode.name = "PROTEGER"
            scene.rootNode.addChildNode(foregroundNode)
            
            
            path = UIBezierPath()
            path.move(to: CGPoint(x: 0.63238*width, y: 0.89494*height))
            path.addLine(to: CGPoint(x: 0.63261*width, y: 0.88375*height))
            path.addLine(to: CGPoint(x: 0.60381*width, y: 0.88368*height))
            path.addCurve(to: CGPoint(x: 0.6023*width, y: 0.88655*height), controlPoint1: CGPoint(x: 0.60267*width, y: 0.88399*height), controlPoint2: CGPoint(x: 0.6023*width, y: 0.88554*height))
            path.addCurve(to: CGPoint(x: 0.60918*width, y: 0.89124*height), controlPoint1: CGPoint(x: 0.60266*width, y: 0.89031*height), controlPoint2: CGPoint(x: 0.60645*width, y: 0.89176*height))
            path.addLine(to: CGPoint(x: 0.63238*width, y: 0.89494*height))
            foregroundShape = SCNShape(path: path, extrusionDepth: 25)
            foregroundMaterial = SCNMaterial()
            foregroundMaterial.diffuse.contents = color
            foregroundShape.materials = [foregroundMaterial]
            foregroundNode = SCNNode(geometry: foregroundShape)
            foregroundNode.position = SCNVector3(0, 30, 70)
            foregroundNode.eulerAngles = SCNVector3(-0.50, Float(Double.pi), Float(Double.pi))
            foregroundNode.name = "DISMINUIR"
            scene.rootNode.addChildNode(foregroundNode)
            
            
            path = UIBezierPath()
            path.move(to: CGPoint(x: 0.64633*width, y: 0.85488*height))
            path.addCurve(to: CGPoint(x: 0.64093*width, y: 0.85963*height), controlPoint1: CGPoint(x: 0.64381*width, y: 0.85492*height), controlPoint2: CGPoint(x: 0.64167*width, y: 0.85766*height))
            path.addLine(to: CGPoint(x: 0.64027*width, y: 0.89518*height))
            path.addLine(to: CGPoint(x: 0.69084*width, y: 0.895*height))
            path.addCurve(to: CGPoint(x: 0.69298*width, y: 0.88483*height), controlPoint1: CGPoint(x: 0.69094*width, y: 0.89184*height), controlPoint2: CGPoint(x: 0.69149*width, y: 0.88676*height))
            path.addLine(to: CGPoint(x: 0.69298*width, y: 0.87923*height))
            path.addCurve(to: CGPoint(x: 0.68924*width, y: 0.87351*height), controlPoint1: CGPoint(x: 0.69135*width, y: 0.87819*height), controlPoint2: CGPoint(x: 0.68953*width, y: 0.87531*height))
            path.addLine(to: CGPoint(x: 0.68924*width, y: 0.86358*height))
            path.addLine(to: CGPoint(x: 0.69298*width, y: 0.85963*height))
            path.addLine(to: CGPoint(x: 0.69613*width, y: 0.85488*height))
            path.addLine(to: CGPoint(x: 0.64633*width, y: 0.85488*height))
            foregroundShape = SCNShape(path: path, extrusionDepth: 25)
            foregroundMaterial = SCNMaterial()
            foregroundMaterial.diffuse.contents = color
            foregroundShape.materials = [foregroundMaterial]
            foregroundNode = SCNNode(geometry: foregroundShape)
            foregroundNode.position = SCNVector3(0, 30, 70)
            foregroundNode.eulerAngles = SCNVector3(-0.50, Float(Double.pi), Float(Double.pi))
            foregroundNode.name = "DISTRIBUIR"
            scene.rootNode.addChildNode(foregroundNode)
            
            
            path = UIBezierPath()
            path.move(to: CGPoint(x: 0.69858*width, y: 0.85501*height))
            path.addLine(to: CGPoint(x: 0.74829*width, y: 0.85482*height))
            path.addLine(to: CGPoint(x: 0.75502*width, y: 0.86155*height))
            path.addLine(to: CGPoint(x: 0.76303*width, y: 0.89271*height))
            path.addLine(to: CGPoint(x: 0.7588*width, y: 0.8936*height))
            path.addLine(to: CGPoint(x: 0.69858*width, y: 0.89271*height))
            path.addLine(to: CGPoint(x: 0.69858*width, y: 0.85501*height))
            foregroundShape = SCNShape(path: path, extrusionDepth: 25)
            foregroundMaterial = SCNMaterial()
            foregroundMaterial.diffuse.contents = color
            foregroundShape.materials = [foregroundMaterial]
            foregroundNode = SCNNode(geometry: foregroundShape)
            foregroundNode.position = SCNVector3(0, 30, 70)
            foregroundNode.eulerAngles = SCNVector3(-0.50, Float(Double.pi), Float(Double.pi))
            foregroundNode.name = "RECICLAR"
            scene.rootNode.addChildNode(foregroundNode)
            
            
            
            // PEQUEÑOS
            color = UIColor(red: 86 / 255, green: 188/255, blue: 188/255, alpha: 1)
            path = UIBezierPath()
            path.move(to: CGPoint(x: 0.76876*width, y: 0.90089*height))
            path.addLine(to: CGPoint(x: 0.75629*width, y: 0.83365*height))
            path.addLine(to: CGPoint(x: 0.72458*width, y: 0.77699*height))
            path.addLine(to: CGPoint(x: 0.70865*width, y: 0.74718*height))
            path.addLine(to: CGPoint(x: 0.86289*width, y: 0.66215*height))
            path.addLine(to: CGPoint(x: 0.89222*width, y: 0.71337*height))
            path.addLine(to: CGPoint(x: 0.83898*width, y: 0.74244*height))
            path.addCurve(to: CGPoint(x: 0.83257*width, y: 0.75092*height), controlPoint1: CGPoint(x: 0.83656*width, y: 0.74409*height), controlPoint2: CGPoint(x: 0.83339*width, y: 0.74835*height))
            path.addLine(to: CGPoint(x: 0.82005*width, y: 0.77699*height))
            path.addLine(to: CGPoint(x: 0.82268*width, y: 0.79866*height))
            path.addLine(to: CGPoint(x: 0.77566*width, y: 0.8952*height))
            path.addCurve(to: CGPoint(x: 0.76876*width, y: 0.90089*height), controlPoint1: CGPoint(x: 0.77354*width, y: 0.89792*height), controlPoint2: CGPoint(x: 0.77082*width, y: 0.90157*height))
            foregroundShape = SCNShape(path: path, extrusionDepth: 25)
            foregroundMaterial = SCNMaterial()
            foregroundMaterial.diffuse.contents = color
            foregroundShape.materials = [foregroundMaterial]
            foregroundNode = SCNNode(geometry: foregroundShape)
            foregroundNode.position = SCNVector3(0, 30, 40)
            foregroundNode.eulerAngles = SCNVector3(-0.50, Float(Double.pi), Float(Double.pi))
            foregroundNode.name = "PEQUEÑOS 1"
            scene.rootNode.addChildNode(foregroundNode)
            
            textGeometry = SCNText(string: "PEQUEÑOS", extrusionDepth: 0)
            textGeometry.font = UIFont.boldSystemFont(ofSize: 11)
            textGeometry.firstMaterial?.diffuse.contents = UIColor.black
            textNode = SCNNode(geometry: textGeometry)
            textNode.position = SCNVector3(730, -610, 500)
            textNode.eulerAngles = SCNVector3(0, 0, 119.8)
            textNode.name = "PEQUEÑOS"
            scene.rootNode.addChildNode(textNode)
            
            
            color = UIColor(red: 0/255, green: 117/255, blue: 135/255, alpha: 1)
            path = UIBezierPath()
            path.move(to: CGPoint(x: 0.74674*width, y: 0.79368*height))
            path.addLine(to: CGPoint(x: 0.74687*width, y: 0.79242*height))
            path.addCurve(to: CGPoint(x: 0.73434*width, y: 0.78375*height), controlPoint1: CGPoint(x: 0.74284*width, y: 0.7918*height), controlPoint2: CGPoint(x: 0.73669*width, y: 0.78731*height))
            path.addLine(to: CGPoint(x: 0.73854*width, y: 0.78215*height))
            path.addCurve(to: CGPoint(x: 0.75021*width, y: 0.78715*height), controlPoint1: CGPoint(x: 0.74122*width, y: 0.78456*height), controlPoint2: CGPoint(x: 0.74705*width, y: 0.78682*height))
            path.addLine(to: CGPoint(x: 0.75814*width, y: 0.77406*height))
            path.addLine(to: CGPoint(x: 0.75655*width, y: 0.77224*height))
            path.addLine(to: CGPoint(x: 0.75902*width, y: 0.76818*height))
            path.addLine(to: CGPoint(x: 0.75815*width, y: 0.76771*height))
            path.addLine(to: CGPoint(x: 0.75555*width, y: 0.77138*height))
            path.addCurve(to: CGPoint(x: 0.74755*width, y: 0.76644*height), controlPoint1: CGPoint(x: 0.75285*width, y: 0.76955*height), controlPoint2: CGPoint(x: 0.74893*width, y: 0.76685*height))
            path.addLine(to: CGPoint(x: 0.74714*width, y: 0.762*height))
            path.addCurve(to: CGPoint(x: 0.76081*width, y: 0.7686*height), controlPoint1: CGPoint(x: 0.75086*width, y: 0.76196*height), controlPoint2: CGPoint(x: 0.75771*width, y: 0.76505*height))
            path.addLine(to: CGPoint(x: 0.76201*width, y: 0.76786*height))
            path.addCurve(to: CGPoint(x: 0.74755*width, y: 0.76051*height), controlPoint1: CGPoint(x: 0.75976*width, y: 0.76335*height), controlPoint2: CGPoint(x: 0.75254*width, y: 0.75966*height))
            path.addCurve(to: CGPoint(x: 0.73228*width, y: 0.76786*height), controlPoint1: CGPoint(x: 0.74226*width, y: 0.76036*height), controlPoint2: CGPoint(x: 0.73459*width, y: 0.76399*height))
            path.addCurve(to: CGPoint(x: 0.73075*width, y: 0.77678*height), controlPoint1: CGPoint(x: 0.73132*width, y: 0.76994*height), controlPoint2: CGPoint(x: 0.7306*width, y: 0.7744*height))
            path.addCurve(to: CGPoint(x: 0.73228*width, y: 0.78375*height), controlPoint1: CGPoint(x: 0.73076*width, y: 0.77871*height), controlPoint2: CGPoint(x: 0.73139*width, y: 0.7822*height))
            path.addCurve(to: CGPoint(x: 0.73854*width, y: 0.79056*height), controlPoint1: CGPoint(x: 0.73331*width, y: 0.78563*height), controlPoint2: CGPoint(x: 0.73653*width, y: 0.7889*height))
            path.addCurve(to: CGPoint(x: 0.74674*width, y: 0.79368*height), controlPoint1: CGPoint(x: 0.74051*width, y: 0.7922*height), controlPoint2: CGPoint(x: 0.74459*width, y: 0.79387*height))
            foregroundShape = SCNShape(path: path, extrusionDepth: 25)
            foregroundMaterial = SCNMaterial()
            foregroundMaterial.diffuse.contents = color
            foregroundShape.materials = [foregroundMaterial]
            foregroundNode = SCNNode(geometry: foregroundShape)
            foregroundNode.position = SCNVector3(0, 40, 70)
            foregroundNode.eulerAngles = SCNVector3(-0.50, Float(Double.pi), Float(Double.pi))
            foregroundNode.name = "AVES"
            scene.rootNode.addChildNode(foregroundNode)
            
            
            path = UIBezierPath()
            path.move(to: CGPoint(x: 0.77046*width, y: 0.75577*height))
            path.addLine(to: CGPoint(x: 0.77646*width, y: 0.7579*height))
            path.addCurve(to: CGPoint(x: 0.78561*width, y: 0.77138*height), controlPoint1: CGPoint(x: 0.7816*width, y: 0.75984*height), controlPoint2: CGPoint(x: 0.78695*width, y: 0.76605*height))
            path.addCurve(to: CGPoint(x: 0.76788*width, y: 0.77224*height), controlPoint1: CGPoint(x: 0.7816*width, y: 0.77619*height), controlPoint2: CGPoint(x: 0.77271*width, y: 0.77619*height))
            path.addLine(to: CGPoint(x: 0.76341*width, y: 0.7686*height))
            path.addLine(to: CGPoint(x: 0.77046*width, y: 0.75577*height))
            foregroundShape = SCNShape(path: path, extrusionDepth: 25)
            foregroundMaterial = SCNMaterial()
            foregroundMaterial.diffuse.contents = color
            foregroundShape.materials = [foregroundMaterial]
            foregroundNode = SCNNode(geometry: foregroundShape)
            foregroundNode.position = SCNVector3(0, 40, 70)
            foregroundNode.eulerAngles = SCNVector3(-0.50, Float(Double.pi), Float(Double.pi))
            foregroundNode.name = "BARCO"
            scene.rootNode.addChildNode(foregroundNode)
            
            
            path.move(to: CGPoint(x: 0.78774*width, y: 0.79589*height))
            path.addCurve(to: CGPoint(x: 0.79584*width, y: 0.789*height), controlPoint1: CGPoint(x: 0.7893*width, y: 0.79258*height), controlPoint2: CGPoint(x: 0.7934*width, y: 0.78968*height))
            path.addCurve(to: CGPoint(x: 0.80478*width, y: 0.78832*height), controlPoint1: CGPoint(x: 0.79802*width, y: 0.78833*height), controlPoint2: CGPoint(x: 0.80249*width, y: 0.78802*height))
            path.addCurve(to: CGPoint(x: 0.81356*width, y: 0.79256*height), controlPoint1: CGPoint(x: 0.80791*width, y: 0.78893*height), controlPoint2: CGPoint(x: 0.81191*width, y: 0.79114*height))
            path.addCurve(to: CGPoint(x: 0.81788*width, y: 0.80043*height), controlPoint1: CGPoint(x: 0.81527*width, y: 0.79412*height), controlPoint2: CGPoint(x: 0.81731*width, y: 0.7981*height))
            path.addLine(to: CGPoint(x: 0.80994*width, y: 0.81707*height))
            path.addCurve(to: CGPoint(x: 0.80221*width, y: 0.81833*height), controlPoint1: CGPoint(x: 0.80815*width, y: 0.81895*height), controlPoint2: CGPoint(x: 0.80439*width, y: 0.81891*height))
            path.addLine(to: CGPoint(x: 0.78634*width, y: 0.81007*height))
            path.addCurve(to: CGPoint(x: 0.78774*width, y: 0.79589*height), controlPoint1: CGPoint(x: 0.78532*width, y: 0.80658*height), controlPoint2: CGPoint(x: 0.78482*width, y: 0.80021*height))
            foregroundShape = SCNShape(path: path, extrusionDepth: 25)
            foregroundMaterial = SCNMaterial()
            foregroundMaterial.diffuse.contents = color
            foregroundShape.materials = [foregroundMaterial]
            foregroundNode = SCNNode(geometry: foregroundShape)
            foregroundNode.position = SCNVector3(0, 40, 70)
            foregroundNode.eulerAngles = SCNVector3(-0.50, Float(Double.pi), Float(Double.pi))
            foregroundNode.name = "SUBMARINO"
            scene.rootNode.addChildNode(foregroundNode)
            
            
            
            path.move(to: CGPoint(x: 0.81322*width, y: 0.74318*height))
            path.addLine(to: CGPoint(x: 0.81228*width, y: 0.73932*height))
            path.addCurve(to: CGPoint(x: 0.82422*width, y: 0.73932*height), controlPoint1: CGPoint(x: 0.81593*width, y: 0.73756*height), controlPoint2: CGPoint(x: 0.82189*width, y: 0.73615*height))
            path.addLine(to: CGPoint(x: 0.82249*width, y: 0.74318*height))
            path.addCurve(to: CGPoint(x: 0.82696*width, y: 0.74709*height), controlPoint1: CGPoint(x: 0.82408*width, y: 0.74444*height), controlPoint2: CGPoint(x: 0.82645*width, y: 0.74632*height))
            path.addCurve(to: CGPoint(x: 0.83123*width, y: 0.74696*height), controlPoint1: CGPoint(x: 0.8281*width, y: 0.74691*height), controlPoint2: CGPoint(x: 0.83024*width, y: 0.74681*height))
            path.addCurve(to: CGPoint(x: 0.82889*width, y: 0.75096*height), controlPoint1: CGPoint(x: 0.83116*width, y: 0.74786*height), controlPoint2: CGPoint(x: 0.82989*width, y: 0.74986*height))
            path.addCurve(to: CGPoint(x: 0.82956*width, y: 0.75476*height), controlPoint1: CGPoint(x: 0.82932*width, y: 0.75178*height), controlPoint2: CGPoint(x: 0.82957*width, y: 0.75368*height))
            path.addLine(to: CGPoint(x: 0.82556*width, y: 0.76376*height))
            path.addCurve(to: CGPoint(x: 0.81949*width, y: 0.76656*height), controlPoint1: CGPoint(x: 0.82414*width, y: 0.76503*height), controlPoint2: CGPoint(x: 0.82111*width, y: 0.76633*height))
            path.addLine(to: CGPoint(x: 0.8197*width, y: 0.77083*height))
            path.addCurve(to: CGPoint(x: 0.81017*width, y: 0.77083*height), controlPoint1: CGPoint(x: 0.81749*width, y: 0.77253*height), controlPoint2: CGPoint(x: 0.81329*width, y: 0.77389*height))
            path.addLine(to: CGPoint(x: 0.81228*width, y: 0.76656*height))
            path.addCurve(to: CGPoint(x: 0.80877*width, y: 0.76376*height), controlPoint1: CGPoint(x: 0.81103*width, y: 0.76599*height), controlPoint2: CGPoint(x: 0.80918*width, y: 0.76466*height))
            path.addCurve(to: CGPoint(x: 0.7983*width, y: 0.7651*height), controlPoint1: CGPoint(x: 0.80663*width, y: 0.76716*height), controlPoint2: CGPoint(x: 0.80144*width, y: 0.76805*height))
            path.addCurve(to: CGPoint(x: 0.80517*width, y: 0.75703*height), controlPoint1: CGPoint(x: 0.7982*width, y: 0.76165*height), controlPoint2: CGPoint(x: 0.80034*width, y: 0.75697*height))
            path.addLine(to: CGPoint(x: 0.8049*width, y: 0.7529*height))
            path.addLine(to: CGPoint(x: 0.79984*width, y: 0.75096*height))
            path.addCurve(to: CGPoint(x: 0.8049*width, y: 0.74318*height), controlPoint1: CGPoint(x: 0.80016*width, y: 0.74878*height), controlPoint2: CGPoint(x: 0.80228*width, y: 0.74489*height))
            path.addLine(to: CGPoint(x: 0.80877*width, y: 0.74696*height))
            path.addCurve(to: CGPoint(x: 0.81322*width, y: 0.74318*height), controlPoint1: CGPoint(x: 0.80927*width, y: 0.74564*height), controlPoint2: CGPoint(x: 0.81158*width, y: 0.74382*height))
            foregroundShape = SCNShape(path: path, extrusionDepth: 25)
            foregroundMaterial = SCNMaterial()
            foregroundMaterial.diffuse.contents = color
            foregroundShape.materials = [foregroundMaterial]
            foregroundNode = SCNNode(geometry: foregroundShape)
            foregroundNode.position = SCNVector3(0, 40, 70)
            foregroundNode.eulerAngles = SCNVector3(-0.50, Float(Double.pi), Float(Double.pi))
            foregroundNode.name = "TORTUGANERO"
            scene.rootNode.addChildNode(foregroundNode)
            
            
            path = UIBezierPath()
            path.move(to: CGPoint(x: 0.83774*width, y: 0.71563*height))
            path.addCurve(to: CGPoint(x: 0.84429*width, y: 0.71225*height), controlPoint1: CGPoint(x: 0.83744*width, y: 0.71206*height), controlPoint2: CGPoint(x: 0.84028*width, y: 0.70981*height))
            path.addCurve(to: CGPoint(x: 0.85449*width, y: 0.71501*height), controlPoint1: CGPoint(x: 0.84924*width, y: 0.70844*height), controlPoint2: CGPoint(x: 0.85377*width, y: 0.71078*height))
            path.addCurve(to: CGPoint(x: 0.85098*width, y: 0.72136*height), controlPoint1: CGPoint(x: 0.85468*width, y: 0.71707*height), controlPoint2: CGPoint(x: 0.85424*width, y: 0.7203*height))
            path.addCurve(to: CGPoint(x: 0.84622*width, y: 0.72474*height), controlPoint1: CGPoint(x: 0.85088*width, y: 0.72462*height), controlPoint2: CGPoint(x: 0.84833*width, y: 0.72589*height))
            path.addCurve(to: CGPoint(x: 0.8338*width, y: 0.72391*height), controlPoint1: CGPoint(x: 0.84218*width, y: 0.7307*height), controlPoint2: CGPoint(x: 0.83625*width, y: 0.72893*height))
            path.addCurve(to: CGPoint(x: 0.83774*width, y: 0.71563*height), controlPoint1: CGPoint(x: 0.83273*width, y: 0.72091*height), controlPoint2: CGPoint(x: 0.83411*width, y: 0.71657*height))
            foregroundShape = SCNShape(path: path, extrusionDepth: 25)
            foregroundMaterial = SCNMaterial()
            foregroundMaterial.diffuse.contents = color
            foregroundShape.materials = [foregroundMaterial]
            foregroundNode = SCNNode(geometry: foregroundShape)
            foregroundNode.position = SCNVector3(0, 40, 70)
            foregroundNode.eulerAngles = SCNVector3(-0.50, Float(Double.pi), Float(Double.pi))
            foregroundNode.name = "SONIDOS PEQUEÑOS"
            scene.rootNode.addChildNode(foregroundNode)
            
            
            // EXPRESO
            color = UIColor(red: 229 / 255, green: 117/255, blue: 43/255, alpha: 1)
            path = UIBezierPath()
            path.move(to: CGPoint(x: 0.66361*width, y: 0.45159*height))
            path.addLine(to: CGPoint(x: 0.83257*width, y: 0.48391*height))
            path.addCurve(to: CGPoint(x: 0.85556*width, y: 0.46952*height), controlPoint1: CGPoint(x: 0.83562*width, y: 0.47445*height), controlPoint2: CGPoint(x: 0.84732*width, y: 0.46774*height))
            path.addLine(to: CGPoint(x: 0.93642*width, y: 0.48611*height))
            path.addCurve(to: CGPoint(x: 0.95089*width, y: 0.50187*height), controlPoint1: CGPoint(x: 0.94309*width, y: 0.48767*height), controlPoint2: CGPoint(x: 0.94936*width, y: 0.49607*height))
            path.addLine(to: CGPoint(x: 0.97413*width, y: 0.65314*height))
            path.addCurve(to: CGPoint(x: 0.9675*width, y: 0.67159*height), controlPoint1: CGPoint(x: 0.97519*width, y: 0.6593*height), controlPoint2: CGPoint(x: 0.97116*width, y: 0.66792*height))
            path.addLine(to: CGPoint(x: 0.9649*width, y: 0.67425*height))
            path.addLine(to: CGPoint(x: 0.89222*width, y: 0.71337*height))
            path.addLine(to: CGPoint(x: 0.86289*width, y: 0.66215*height))
            path.addLine(to: CGPoint(x: 0.88266*width, y: 0.65101*height))
            path.addCurve(to: CGPoint(x: 0.89694*width, y: 0.61519*height), controlPoint1: CGPoint(x: 0.88912*width, y: 0.64669*height), controlPoint2: CGPoint(x: 0.89699*width, y: 0.63083*height))
            path.addCurve(to: CGPoint(x: 0.86637*width, y: 0.57521*height), controlPoint1: CGPoint(x: 0.89774*width, y: 0.59552*height), controlPoint2: CGPoint(x: 0.88375*width, y: 0.57661*height))
            path.addCurve(to: CGPoint(x: 0.83257*width, y: 0.59999*height), controlPoint1: CGPoint(x: 0.85261*width, y: 0.57248*height), controlPoint2: CGPoint(x: 0.83893*width, y: 0.58824*height))
            path.addCurve(to: CGPoint(x: 0.76504*width, y: 0.63337*height), controlPoint1: CGPoint(x: 0.8235*width, y: 0.61696*height), controlPoint2: CGPoint(x: 0.78899*width, y: 0.6327*height))
            path.addCurve(to: CGPoint(x: 0.68221*width, y: 0.6164*height), controlPoint1: CGPoint(x: 0.74564*width, y: 0.63235*height), controlPoint2: CGPoint(x: 0.70461*width, y: 0.6231*height))
            path.addLine(to: CGPoint(x: 0.65905*width, y: 0.61329*height))
            path.addLine(to: CGPoint(x: 0.57124*width, y: 0.61564*height))
            path.addLine(to: CGPoint(x: 0.55357*width, y: 0.55201*height))
            path.addLine(to: CGPoint(x: 0.59047*width, y: 0.5547*height))
            path.addLine(to: CGPoint(x: 0.6664*width, y: 0.53268*height))
            path.addLine(to: CGPoint(x: 0.66361*width, y: 0.45159*height))
            foregroundShape = SCNShape(path: path, extrusionDepth: 25)
            foregroundMaterial = SCNMaterial()
            foregroundMaterial.diffuse.contents = color
            foregroundShape.materials = [foregroundMaterial]
            foregroundNode = SCNNode(geometry: foregroundShape)
            foregroundNode.position = SCNVector3(0, 30, 40)
            foregroundNode.eulerAngles = SCNVector3(-0.50, Float(Double.pi), Float(Double.pi))
            foregroundNode.name = "EXPRESO"
            scene.rootNode.addChildNode(foregroundNode)
            
            textGeometry = SCNText(string: "EXPRESO", extrusionDepth: 0)
            textGeometry.font = UIFont.boldSystemFont(ofSize: 11)
            textGeometry.firstMaterial?.diffuse.contents = UIColor.black
            textNode = SCNNode(geometry: textGeometry)
            textNode.position = SCNVector3(650, -410, 500)
            textNode.eulerAngles = SCNVector3(0, 0, 0)
            textNode.name = "EXPRESO"
            scene.rootNode.addChildNode(textNode)
            
            
            
            color = UIColor(red: 197 / 255, green: 45/255, blue: 1/255, alpha: 1)
            path = UIBezierPath()
            path.move(to: CGPoint(x: 0.89737*width, y: 0.71075*height))
            path.addLine(to: CGPoint(x: 0.88362*width, y: 0.68097*height))
            path.addLine(to: CGPoint(x: 0.96912*width, y: 0.63461*height))
            path.addCurve(to: CGPoint(x: 0.96565*width, y: 0.67331*height), controlPoint1: CGPoint(x: 0.97364*width, y: 0.64819*height), controlPoint2: CGPoint(x: 0.97303*width, y: 0.6682*height))
            path.addLine(to: CGPoint(x: 0.89737*width, y: 0.71075*height))
            foregroundShape = SCNShape(path: path, extrusionDepth: 25)
            foregroundMaterial = SCNMaterial()
            foregroundMaterial.diffuse.contents = color
            foregroundShape.materials = [foregroundMaterial]
            foregroundNode = SCNNode(geometry: foregroundShape)
            foregroundNode.position = SCNVector3(0, 45, 70)
            foregroundNode.eulerAngles = SCNVector3(-0.50, Float(Double.pi), Float(Double.pi))
            foregroundNode.name = "LUZ"
            scene.rootNode.addChildNode(foregroundNode)
            
            
            path = UIBezierPath()
            path.move(to: CGPoint(x: 0.92794*width, y: 0.63308*height))
            path.addLine(to: CGPoint(x: 0.94545*width, y: 0.61293*height))
            path.addLine(to: CGPoint(x: 0.94229*width, y: 0.6074*height))
            path.addCurve(to: CGPoint(x: 0.93808*width, y: 0.60793*height), controlPoint1: CGPoint(x: 0.94076*width, y: 0.60622*height), controlPoint2: CGPoint(x: 0.93868*width, y: 0.60654*height))
            path.addLine(to: CGPoint(x: 0.92162*width, y: 0.62873*height))
            path.addCurve(to: CGPoint(x: 0.92794*width, y: 0.63308*height), controlPoint1: CGPoint(x: 0.92053*width, y: 0.63012*height), controlPoint2: CGPoint(x: 0.92383*width, y: 0.63228*height))
            foregroundShape = SCNShape(path: path, extrusionDepth: 25)
            foregroundMaterial = SCNMaterial()
            foregroundMaterial.diffuse.contents = color
            foregroundShape.materials = [foregroundMaterial]
            foregroundNode = SCNNode(geometry: foregroundShape)
            foregroundNode.position = SCNVector3(0, 40, 70)
            foregroundNode.eulerAngles = SCNVector3(-0.50, Float(Double.pi), Float(Double.pi))
            foregroundNode.name = "PALABRAS"
            scene.rootNode.addChildNode(foregroundNode)
            
            
            path = UIBezierPath()
            path.move(to: CGPoint(x: 0.94554*width, y: 0.61157*height))
            path.addLine(to: CGPoint(x: 0.95883*width, y: 0.60417*height))
            path.addCurve(to: CGPoint(x: 0.96441*width, y: 0.5961*height), controlPoint1: CGPoint(x: 0.96134*width, y: 0.6027*height), controlPoint2: CGPoint(x: 0.96406*width, y: 0.59863*height))
            path.addLine(to: CGPoint(x: 0.9596*width, y: 0.563*height))
            path.addCurve(to: CGPoint(x: 0.95579*width, y: 0.55778*height), controlPoint1: CGPoint(x: 0.95855*width, y: 0.56129*height), controlPoint2: CGPoint(x: 0.95665*width, y: 0.5586*height))
            path.addLine(to: CGPoint(x: 0.93388*width, y: 0.54428*height))
            path.addLine(to: CGPoint(x: 0.93195*width, y: 0.54775*height))
            path.addLine(to: CGPoint(x: 0.95289*width, y: 0.56067*height))
            path.addCurve(to: CGPoint(x: 0.95654*width, y: 0.56824*height), controlPoint1: CGPoint(x: 0.95428*width, y: 0.56191*height), controlPoint2: CGPoint(x: 0.95609*width, y: 0.56571*height))
            path.addLine(to: CGPoint(x: 0.96059*width, y: 0.59304*height))
            path.addCurve(to: CGPoint(x: 0.95667*width, y: 0.60113*height), controlPoint1: CGPoint(x: 0.96052*width, y: 0.59572*height), controlPoint2: CGPoint(x: 0.95861*width, y: 0.5998*height))
            path.addLine(to: CGPoint(x: 0.9525*width, y: 0.60387*height))
            path.addLine(to: CGPoint(x: 0.94884*width, y: 0.58129*height))
            path.addCurve(to: CGPoint(x: 0.94258*width, y: 0.57777*height), controlPoint1: CGPoint(x: 0.94804*width, y: 0.57717*height), controlPoint2: CGPoint(x: 0.94475*width, y: 0.57638*height))
            path.addCurve(to: CGPoint(x: 0.93423*width, y: 0.58834*height), controlPoint1: CGPoint(x: 0.93951*width, y: 0.58023*height), controlPoint2: CGPoint(x: 0.93599*width, y: 0.58532*height))
            path.addCurve(to: CGPoint(x: 0.93592*width, y: 0.59604*height), controlPoint1: CGPoint(x: 0.93429*width, y: 0.59047*height), controlPoint2: CGPoint(x: 0.935*width, y: 0.59432*height))
            path.addLine(to: CGPoint(x: 0.94554*width, y: 0.61157*height))
            foregroundShape = SCNShape(path: path, extrusionDepth: 25)
            foregroundMaterial = SCNMaterial()
            foregroundMaterial.diffuse.contents = color
            foregroundShape.materials = [foregroundMaterial]
            foregroundNode = SCNNode(geometry: foregroundShape)
            foregroundNode.position = SCNVector3(0, 40, 70)
            foregroundNode.eulerAngles = SCNVector3(-0.50, Float(Double.pi), Float(Double.pi))
            foregroundNode.name = "PATRONES"
            scene.rootNode.addChildNode(foregroundNode)
            
            
            path = UIBezierPath()
            path.move(to: CGPoint(x: 0.93195*width, y: 0.52504*height))
            path.addLine(to: CGPoint(x: 0.94106*width, y: 0.51778*height))
            path.addLine(to: CGPoint(x: 0.93733*width, y: 0.51451*height))
            path.addLine(to: CGPoint(x: 0.92446*width, y: 0.52131*height))
            path.addLine(to: CGPoint(x: 0.92359*width, y: 0.54428*height))
            path.addLine(to: CGPoint(x: 0.92953*width, y: 0.54775*height))
            path.addLine(to: CGPoint(x: 0.93388*width, y: 0.54198*height))
            path.addLine(to: CGPoint(x: 0.93195*width, y: 0.52504*height))
            foregroundShape = SCNShape(path: path, extrusionDepth: 25)
            foregroundMaterial = SCNMaterial()
            foregroundMaterial.diffuse.contents = color
            foregroundShape.materials = [foregroundMaterial]
            foregroundNode = SCNNode(geometry: foregroundShape)
            foregroundNode.position = SCNVector3(0, 40, 70)
            foregroundNode.eulerAngles = SCNVector3(-0.50, Float(Double.pi), Float(Double.pi))
            foregroundNode.name = "TEXTURAS"
            scene.rootNode.addChildNode(foregroundNode)
            
            
            path = UIBezierPath()
            path.move(to: CGPoint(x: 0.90819*width, y: 0.49727*height))
            path.addLine(to: CGPoint(x: 0.91205*width, y: 0.49727*height))
            path.addLine(to: CGPoint(x: 0.91405*width, y: 0.50173*height))
            path.addLine(to: CGPoint(x: 0.92052*width, y: 0.5036*height))
            path.addLine(to: CGPoint(x: 0.92599*width, y: 0.50047*height))
            path.addLine(to: CGPoint(x: 0.92939*width, y: 0.5024*height))
            path.addLine(to: CGPoint(x: 0.92325*width, y: 0.50853*height))
            path.addLine(to: CGPoint(x: 0.90979*width, y: 0.50573*height))
            path.addLine(to: CGPoint(x: 0.90819*width, y: 0.49727*height))
            foregroundShape = SCNShape(path: path, extrusionDepth: 25)
            foregroundMaterial = SCNMaterial()
            foregroundMaterial.diffuse.contents = color
            foregroundShape.materials = [foregroundMaterial]
            foregroundNode = SCNNode(geometry: foregroundShape)
            foregroundNode.position = SCNVector3(0, 40, 70)
            foregroundNode.eulerAngles = SCNVector3(-0.50, Float(Double.pi), Float(Double.pi))
            foregroundNode.name = "PALABRAS"
            scene.rootNode.addChildNode(foregroundNode)
            
            path = UIBezierPath()
            path.move(to: CGPoint(x: 0.88335*width, y: 0.5761*height))
            path.addLine(to: CGPoint(x: 0.89482*width, y: 0.58935*height))
            path.addCurve(to: CGPoint(x: 0.89874*width, y: 0.58837*height), controlPoint1: CGPoint(x: 0.8964*width, y: 0.59111*height), controlPoint2: CGPoint(x: 0.89841*width, y: 0.59078*height))
            path.addLine(to: CGPoint(x: 0.90603*width, y: 0.56358*height))
            path.addLine(to: CGPoint(x: 0.89048*width, y: 0.55588*height))
            path.addCurve(to: CGPoint(x: 0.88573*width, y: 0.55793*height), controlPoint1: CGPoint(x: 0.88805*width, y: 0.55462*height), controlPoint2: CGPoint(x: 0.88603*width, y: 0.55608*height))
            path.addLine(to: CGPoint(x: 0.88335*width, y: 0.5761*height))
            foregroundShape = SCNShape(path: path, extrusionDepth: 25)
            foregroundMaterial = SCNMaterial()
            foregroundMaterial.diffuse.contents = color
            foregroundShape.materials = [foregroundMaterial]
            foregroundNode = SCNNode(geometry: foregroundShape)
            foregroundNode.position = SCNVector3(0, 40, 70)
            foregroundNode.eulerAngles = SCNVector3(-0.50, Float(Double.pi), Float(Double.pi))
            foregroundNode.name = "RELIEVE"
            scene.rootNode.addChildNode(foregroundNode)
            
            path = UIBezierPath()
            path.move(to: CGPoint(x: 0.85134*width, y: 0.50857*height))
            path.addLine(to: CGPoint(x: 0.88305*width, y: 0.51408*height))
            path.addLine(to: CGPoint(x: 0.89637*width, y: 0.50699*height))
            path.addLine(to: CGPoint(x: 0.89842*width, y: 0.51408*height))
            path.addLine(to: CGPoint(x: 0.88915*width, y: 0.52366*height))
            path.addCurve(to: CGPoint(x: 0.88605*width, y: 0.52878*height), controlPoint1: CGPoint(x: 0.89042*width, y: 0.52653*height), controlPoint2: CGPoint(x: 0.88873*width, y: 0.52898*height))
            path.addCurve(to: CGPoint(x: 0.88305*width, y: 0.5255*height), controlPoint1: CGPoint(x: 0.88412*width, y: 0.52903*height), controlPoint2: CGPoint(x: 0.88305*width, y: 0.52688*height))
            path.addLine(to: CGPoint(x: 0.8797*width, y: 0.52445*height))
            path.addCurve(to: CGPoint(x: 0.87471*width, y: 0.52629*height), controlPoint1: CGPoint(x: 0.87916*width, y: 0.52615*height), controlPoint2: CGPoint(x: 0.87658*width, y: 0.52689*height))
            path.addCurve(to: CGPoint(x: 0.87235*width, y: 0.52209*height), controlPoint1: CGPoint(x: 0.87328*width, y: 0.52573*height), controlPoint2: CGPoint(x: 0.87237*width, y: 0.52352*height))
            path.addLine(to: CGPoint(x: 0.8499*width, y: 0.51408*height))
            path.addCurve(to: CGPoint(x: 0.84872*width, y: 0.51067*height), controlPoint1: CGPoint(x: 0.84823*width, y: 0.51361*height), controlPoint2: CGPoint(x: 0.84789*width, y: 0.51185*height))
            path.addLine(to: CGPoint(x: 0.85134*width, y: 0.50857*height))
            foregroundShape = SCNShape(path: path, extrusionDepth: 25)
            foregroundMaterial = SCNMaterial()
            foregroundMaterial.diffuse.contents = color
            foregroundShape.materials = [foregroundMaterial]
            foregroundNode = SCNNode(geometry: foregroundShape)
            foregroundNode.position = SCNVector3(0, 40, 70)
            foregroundNode.eulerAngles = SCNVector3(-0.50, Float(Double.pi), Float(Double.pi))
            foregroundNode.name = "HISTORIAS"
            scene.rootNode.addChildNode(foregroundNode)
            
            path = UIBezierPath()
            path.move(to: CGPoint(x: 0.84744*width, y: 0.48742*height))
            path.addCurve(to: CGPoint(x: 0.85535*width, y: 0.48219*height), controlPoint1: CGPoint(x: 0.84863*width, y: 0.48583*height), controlPoint2: CGPoint(x: 0.85256*width, y: 0.48321*height))
            path.addLine(to: CGPoint(x: 0.89163*width, y: 0.48936*height))
            path.addCurve(to: CGPoint(x: 0.89536*width, y: 0.49488*height), controlPoint1: CGPoint(x: 0.8934*width, y: 0.49011*height), controlPoint2: CGPoint(x: 0.8957*width, y: 0.4923*height))
            path.addLine(to: CGPoint(x: 0.89387*width, y: 0.50026*height))
            path.addCurve(to: CGPoint(x: 0.88645*width, y: 0.50502*height), controlPoint1: CGPoint(x: 0.89187*width, y: 0.50182*height), controlPoint2: CGPoint(x: 0.88824*width, y: 0.50409*height))
            path.addLine(to: CGPoint(x: 0.85003*width, y: 0.49796*height))
            path.addCurve(to: CGPoint(x: 0.84744*width, y: 0.48742*height), controlPoint1: CGPoint(x: 0.84462*width, y: 0.49753*height), controlPoint2: CGPoint(x: 0.84422*width, y: 0.49189*height))
            foregroundShape = SCNShape(path: path, extrusionDepth: 25)
            foregroundMaterial = SCNMaterial()
            foregroundMaterial.diffuse.contents = color
            foregroundShape.materials = [foregroundMaterial]
            foregroundNode = SCNNode(geometry: foregroundShape)
            foregroundNode.position = SCNVector3(0, 40, 70)
            foregroundNode.eulerAngles = SCNVector3(-0.50, Float(Double.pi), Float(Double.pi))
            foregroundNode.name = "INFOLINK"
            scene.rootNode.addChildNode(foregroundNode)
            
            path = UIBezierPath()
            path.move(to: CGPoint(x: 0.84272*width, y: 0.53505*height))
            path.addLine(to: CGPoint(x: 0.84698*width, y: 0.54405*height))
            path.addCurve(to: CGPoint(x: 0.84165*width, y: 0.55092*height), controlPoint1: CGPoint(x: 0.84407*width, y: 0.54494*height), controlPoint2: CGPoint(x: 0.84211*width, y: 0.54857*height))
            path.addCurve(to: CGPoint(x: 0.84525*width, y: 0.55925*height), controlPoint1: CGPoint(x: 0.84139*width, y: 0.55388*height), controlPoint2: CGPoint(x: 0.84349*width, y: 0.55772*height))
            path.addCurve(to: CGPoint(x: 0.82368*width, y: 0.57149*height), controlPoint1: CGPoint(x: 0.83711*width, y: 0.55846*height), controlPoint2: CGPoint(x: 0.82514*width, y: 0.56126*height))
            path.addLine(to: CGPoint(x: 0.83267*width, y: 0.57521*height))
            path.addCurve(to: CGPoint(x: 0.84396*width, y: 0.56944*height), controlPoint1: CGPoint(x: 0.83405*width, y: 0.57141*height), controlPoint2: CGPoint(x: 0.83929*width, y: 0.56798*height))
            path.addCurve(to: CGPoint(x: 0.86607*width, y: 0.56345*height), controlPoint1: CGPoint(x: 0.85153*width, y: 0.57201*height), controlPoint2: CGPoint(x: 0.86285*width, y: 0.56966*height))
            path.addCurve(to: CGPoint(x: 0.8678*width, y: 0.54405*height), controlPoint1: CGPoint(x: 0.86903*width, y: 0.55732*height), controlPoint2: CGPoint(x: 0.86933*width, y: 0.54752*height))
            path.addCurve(to: CGPoint(x: 0.84272*width, y: 0.53505*height), controlPoint1: CGPoint(x: 0.86375*width, y: 0.53423*height), controlPoint2: CGPoint(x: 0.85075*width, y: 0.53127*height))
            foregroundShape = SCNShape(path: path, extrusionDepth: 25)
            foregroundMaterial = SCNMaterial()
            foregroundMaterial.diffuse.contents = color
            foregroundShape.materials = [foregroundMaterial]
            foregroundNode = SCNNode(geometry: foregroundShape)
            foregroundNode.position = SCNVector3(0, 40, 70)
            foregroundNode.eulerAngles = SCNVector3(-0.50, Float(Double.pi), Float(Double.pi))
            foregroundNode.name = "MENSAJES"
            scene.rootNode.addChildNode(foregroundNode)
            
            path = UIBezierPath()
            path.move(to: CGPoint(x: 0.76748*width, y: 0.59606*height))
            path.addLine(to: CGPoint(x: 0.76717*width, y: 0.60439*height))
            path.addLine(to: CGPoint(x: 0.77303*width, y: 0.60578*height))
            path.addLine(to: CGPoint(x: 0.77859*width, y: 0.61041*height))
            path.addLine(to: CGPoint(x: 0.78846*width, y: 0.60501*height))
            path.addCurve(to: CGPoint(x: 0.79734*width, y: 0.60578*height), controlPoint1: CGPoint(x: 0.79012*width, y: 0.60722*height), controlPoint2: CGPoint(x: 0.7944*width, y: 0.60804*height))
            path.addLine(to: CGPoint(x: 0.80987*width, y: 0.59606*height))
            path.addLine(to: CGPoint(x: 0.80487*width, y: 0.59016*height))
            path.addLine(to: CGPoint(x: 0.79614*width, y: 0.59776*height))
            path.addLine(to: CGPoint(x: 0.79188*width, y: 0.58332*height))
            path.addCurve(to: CGPoint(x: 0.78846*width, y: 0.58355*height), controlPoint1: CGPoint(x: 0.79084*width, y: 0.58275*height), controlPoint2: CGPoint(x: 0.78914*width, y: 0.58291*height))
            path.addLine(to: CGPoint(x: 0.77992*width, y: 0.5884*height))
            path.addLine(to: CGPoint(x: 0.77688*width, y: 0.58038*height))
            path.addLine(to: CGPoint(x: 0.76717*width, y: 0.58686*height))
            path.addLine(to: CGPoint(x: 0.77303*width, y: 0.59286*height))
            path.addLine(to: CGPoint(x: 0.76748*width, y: 0.59606*height))
            foregroundShape = SCNShape(path: path, extrusionDepth: 25)
            foregroundMaterial = SCNMaterial()
            foregroundMaterial.diffuse.contents = color
            foregroundShape.materials = [foregroundMaterial]
            foregroundNode = SCNNode(geometry: foregroundShape)
            foregroundNode.position = SCNVector3(0, 40, 70)
            foregroundNode.eulerAngles = SCNVector3(-0.50, Float(Double.pi), Float(Double.pi))
            foregroundNode.name = "COLOR"
            scene.rootNode.addChildNode(foregroundNode)
            
            path = UIBezierPath()
            path.move(to: CGPoint(x: 0.74476*width, y: 0.59987*height))
            path.addLine(to: CGPoint(x: 0.73737*width, y: 0.59776*height))
            path.addLine(to: CGPoint(x: 0.726*width, y: 0.60837*height))
            path.addCurve(to: CGPoint(x: 0.72608*width, y: 0.61041*height), controlPoint1: CGPoint(x: 0.72512*width, y: 0.60943*height), controlPoint2: CGPoint(x: 0.72551*width, y: 0.6102*height))
            path.addLine(to: CGPoint(x: 0.74465*width, y: 0.61845*height))
            path.addCurve(to: CGPoint(x: 0.74809*width, y: 0.61803*height), controlPoint1: CGPoint(x: 0.74558*width, y: 0.6188*height), controlPoint2: CGPoint(x: 0.7473*width, y: 0.6187*height))
            path.addLine(to: CGPoint(x: 0.76488*width, y: 0.60578*height))
            path.addLine(to: CGPoint(x: 0.76502*width, y: 0.59539*height))
            path.addLine(to: CGPoint(x: 0.75355*width, y: 0.59286*height))
            path.addLine(to: CGPoint(x: 0.74476*width, y: 0.59987*height))
            foregroundShape = SCNShape(path: path, extrusionDepth: 25)
            foregroundMaterial = SCNMaterial()
            foregroundMaterial.diffuse.contents = color
            foregroundShape.materials = [foregroundMaterial]
            foregroundNode = SCNNode(geometry: foregroundShape)
            foregroundNode.position = SCNVector3(0, 40, 70)
            foregroundNode.eulerAngles = SCNVector3(-0.50, Float(Double.pi), Float(Double.pi))
            foregroundNode.name = "COMPOSICIÓN"
            scene.rootNode.addChildNode(foregroundNode)
            
            
            path = UIBezierPath()
            path.move(to: CGPoint(x: 0.68059*width, y: 0.45478*height))
            path.addLine(to: CGPoint(x: 0.67998*width, y: 0.45823*height))
            path.addLine(to: CGPoint(x: 0.71265*width, y: 0.46464*height))
            path.addLine(to: CGPoint(x: 0.71339*width, y: 0.46082*height))
            path.addLine(to: CGPoint(x: 0.68059*width, y: 0.45478*height))
            foregroundShape = SCNShape(path: path, extrusionDepth: 25)
            foregroundMaterial = SCNMaterial()
            foregroundMaterial.diffuse.contents = color
            foregroundShape.materials = [foregroundMaterial]
            foregroundNode = SCNNode(geometry: foregroundShape)
            foregroundNode.position = SCNVector3(0, 40, 70)
            foregroundNode.eulerAngles = SCNVector3(-0.50, Float(Double.pi), Float(Double.pi))
            foregroundNode.name = "MOVIMIENTO"
            scene.rootNode.addChildNode(foregroundNode)
            
            path = UIBezierPath()
            path.move(to: CGPoint(x: 0.7522*width, y: 0.46894*height))
            path.addLine(to: CGPoint(x: 0.7562*width, y: 0.54291*height))
            path.addCurve(to: CGPoint(x: 0.76363*width, y: 0.55747*height), controlPoint1: CGPoint(x: 0.75599*width, y: 0.54815*height), controlPoint2: CGPoint(x: 0.75987*width, y: 0.5553*height))
            path.addLine(to: CGPoint(x: 0.77602*width, y: 0.56491*height))
            path.addCurve(to: CGPoint(x: 0.79089*width, y: 0.5604*height), controlPoint1: CGPoint(x: 0.78107*width, y: 0.56655*height), controlPoint2: CGPoint(x: 0.78879*width, y: 0.56514*height))
            path.addLine(to: CGPoint(x: 0.83416*width, y: 0.48401*height))
            path.addLine(to: CGPoint(x: 0.7522*width, y: 0.46894*height))
            foregroundShape = SCNShape(path: path, extrusionDepth: 25)
            foregroundMaterial = SCNMaterial()
            foregroundMaterial.diffuse.contents = color
            foregroundShape.materials = [foregroundMaterial]
            foregroundNode = SCNNode(geometry: foregroundShape)
            foregroundNode.position = SCNVector3(0, 40, 70)
            foregroundNode.eulerAngles = SCNVector3(-0.50, Float(Double.pi), Float(Double.pi))
            foregroundNode.name = "ARTE"
            scene.rootNode.addChildNode(foregroundNode)
            
            
            path = UIBezierPath()
            path.move(to: CGPoint(x: 0.66352*width, y: 0.5604*height))
            path.addLine(to: CGPoint(x: 0.67339*width, y: 0.54551*height))
            path.addLine(to: CGPoint(x: 0.70986*width, y: 0.53477*height))
            path.addLine(to: CGPoint(x: 0.72632*width, y: 0.54811*height))
            path.addCurve(to: CGPoint(x: 0.73106*width, y: 0.55231*height), controlPoint1: CGPoint(x: 0.72878*width, y: 0.54725*height),  controlPoint2: CGPoint(x: 0.73133*width, y: 0.54905*height))
            path.addLine(to: CGPoint(x: 0.73312*width, y: 0.55444*height))
            path.addLine(to: CGPoint(x: 0.72992*width, y: 0.55747*height))
            path.addLine(to: CGPoint(x: 0.72772*width, y: 0.55524*height))
            path.addCurve(to: CGPoint(x: 0.72312*width, y: 0.55151*height), controlPoint1: CGPoint(x: 0.72523*width, y: 0.55509*height), controlPoint2: CGPoint(x: 0.72273*width, y: 0.55335*height))
            path.addLine(to: CGPoint(x: 0.70843*width, y: 0.53971*height))
            path.addLine(to: CGPoint(x: 0.71606*width, y: 0.5604*height))
            path.addCurve(to: CGPoint(x: 0.71472*width, y: 0.56295*height), controlPoint1: CGPoint(x: 0.71657*width, y: 0.56139*height), controlPoint2: CGPoint(x: 0.71592*width, y: 0.56267*height))
            path.addLine(to: CGPoint(x: 0.68787*width, y: 0.57242*height))
            path.addCurve(to: CGPoint(x: 0.68469*width, y: 0.57093*height), controlPoint1: CGPoint(x: 0.68637*width, y: 0.57295*height), controlPoint2: CGPoint(x: 0.68508*width, y: 0.57191*height))
            path.addLine(to: CGPoint(x: 0.67678*width, y: 0.54932*height))
            path.addLine(to: CGPoint(x: 0.66787*width, y: 0.56269*height))
            path.addLine(to: CGPoint(x: 0.67996*width, y: 0.58965*height))
            path.addLine(to: CGPoint(x: 0.67579*width, y: 0.59123*height))
            path.addLine(to: CGPoint(x: 0.66352*width, y: 0.56269*height))
            path.addLine(to: CGPoint(x: 0.66352*width, y: 0.5604*height))
            foregroundShape = SCNShape(path: path, extrusionDepth: 25)
            foregroundMaterial = SCNMaterial()
            foregroundMaterial.diffuse.contents = color
            foregroundShape.materials = [foregroundMaterial]
            foregroundNode = SCNNode(geometry: foregroundShape)
            foregroundNode.position = SCNVector3(0, 40, 70)
            foregroundNode.eulerAngles = SCNVector3(-0.50, Float(Double.pi), Float(Double.pi))
            foregroundNode.name = "PROPORCIÓN"
            scene.rootNode.addChildNode(foregroundNode)
            
            
            path = UIBezierPath()
            path.move(to: CGPoint(x: 0.60077*width, y: 0.59709*height))
            path.addLine(to: CGPoint(x: 0.60029*width, y: 0.56873*height))
            path.addCurve(to: CGPoint(x: 0.60316*width, y: 0.56442*height), controlPoint1: CGPoint(x: 0.60035*width, y: 0.56731*height), controlPoint2: CGPoint(x: 0.60149*width, y: 0.56508*height))
            path.addLine(to: CGPoint(x: 0.63369*width, y: 0.55161*height))
            path.addLine(to: CGPoint(x: 0.63559*width, y: 0.55573*height))
            path.addLine(to: CGPoint(x: 0.60917*width, y: 0.56716*height))
            path.addLine(to: CGPoint(x: 0.61052*width, y: 0.59175*height))
            path.addLine(to: CGPoint(x: 0.6148*width, y: 0.59286*height))
            path.addLine(to: CGPoint(x: 0.61782*width, y: 0.59806*height))
            path.addLine(to: CGPoint(x: 0.63988*width, y: 0.60245*height))
            path.addLine(to: CGPoint(x: 0.63902*width, y: 0.60638*height))
            path.addLine(to: CGPoint(x: 0.63681*width, y: 0.60572*height))
            path.addLine(to: CGPoint(x: 0.63616*width, y: 0.60785*height))
            path.addLine(to: CGPoint(x: 0.62428*width, y: 0.60531*height))
            path.addLine(to: CGPoint(x: 0.60316*width, y: 0.60022*height))
            path.addCurve(to: CGPoint(x: 0.60077*width, y: 0.59709*height), controlPoint1: CGPoint(x: 0.60197*width, y: 0.59987*height), controlPoint2: CGPoint(x: 0.60069*width, y: 0.59838*height))
            foregroundShape = SCNShape(path: path, extrusionDepth: 25)
            foregroundMaterial = SCNMaterial()
            foregroundMaterial.diffuse.contents = color
            foregroundShape.materials = [foregroundMaterial]
            foregroundNode = SCNNode(geometry: foregroundShape)
            foregroundNode.position = SCNVector3(0, 40, 70)
            foregroundNode.eulerAngles = SCNVector3(-0.50, Float(Double.pi), Float(Double.pi))
            foregroundNode.name = "SONIDOS EXPRESO"
            scene.rootNode.addChildNode(foregroundNode)
            
            path = UIBezierPath()
            path.move(to: CGPoint(x: 0.62343*width, y: 0.57886*height))
            path.addLine(to: CGPoint(x: 0.65003*width, y: 0.57659*height))
            path.addLine(to: CGPoint(x: 0.67451*width, y: 0.60155*height))
            path.addLine(to: CGPoint(x: 0.68561*width, y: 0.59588*height))
            path.addLine(to: CGPoint(x: 0.68417*width, y: 0.58842*height))
            path.addLine(to: CGPoint(x: 0.69075*width, y: 0.58549*height))
            path.addLine(to: CGPoint(x: 0.69255*width, y: 0.60095*height))
            path.addLine(to: CGPoint(x: 0.67288*width, y: 0.60848*height))
            path.addLine(to: CGPoint(x: 0.66013*width, y: 0.59814*height))
            path.addLine(to: CGPoint(x: 0.65932*width, y: 0.59302*height))
            path.addLine(to: CGPoint(x: 0.65189*width, y: 0.58499*height))
            path.addLine(to: CGPoint(x: 0.6526*width, y: 0.58338*height))
            path.addLine(to: CGPoint(x: 0.64999*width, y: 0.58047*height))
            path.addLine(to: CGPoint(x: 0.62348*width, y: 0.58288*height))
            path.addLine(to: CGPoint(x: 0.62343*width, y: 0.57886*height))
            foregroundShape = SCNShape(path: path, extrusionDepth: 25)
            foregroundMaterial = SCNMaterial()
            foregroundMaterial.diffuse.contents = color
            foregroundShape.materials = [foregroundMaterial]
            foregroundNode = SCNNode(geometry: foregroundShape)
            foregroundNode.position = SCNVector3(0, 40, 70)
            foregroundNode.eulerAngles = SCNVector3(-0.50, Float(Double.pi), Float(Double.pi))
            foregroundNode.name = "FIGURAS"
            scene.rootNode.addChildNode(foregroundNode)
            
            
            // COMPRENDO
            color = UIColor(red: 123/255, green: 68/255, blue: 136/255, alpha: 1)
            path = UIBezierPath()
            path.move(to: CGPoint(x: 0.3757 * width, y: 0.30048 * height))
            path.addLine(to: CGPoint(x: 0.55743 * width, y: 0.23124 * height))
            path.addCurve(to: CGPoint(x: 0.56563 * width, y: 0.22304 * height),
                          controlPoint1: CGPoint(x: 0.56052 * width, y: 0.22979 * height),
                          controlPoint2: CGPoint(x: 0.56497 * width, y: 0.22613 * height))
            path.addLine(to: CGPoint(x: 0.56446 * width, y: 0.18514 * height))
            path.addLine(to: CGPoint(x: 0.59993 * width, y: 0.18424 * height))
            path.addLine(to: CGPoint(x: 0.59819 * width, y: 0.42482 * height))
            path.addCurve(to: CGPoint(x: 0.61567 * width, y: 0.44206 * height),
                          controlPoint1: CGPoint(x: 0.59966 * width, y: 0.43194 * height),
                          controlPoint2: CGPoint(x: 0.60873 * width, y: 0.44019 * height))
            path.addLine(to: CGPoint(x: 0.66361 * width, y: 0.45159 * height))
            path.addLine(to: CGPoint(x: 0.6664 * width, y: 0.53268 * height))
            path.addLine(to: CGPoint(x: 0.59047 * width, y: 0.55461 * height))
            path.addLine(to: CGPoint(x: 0.55357 * width, y: 0.55201 * height))
            path.addLine(to: CGPoint(x: 0.3757 * width, y: 0.30048 * height))
            foregroundShape = SCNShape(path: path, extrusionDepth: 25)
            foregroundMaterial = SCNMaterial()
            foregroundMaterial.diffuse.contents = color
            foregroundShape.materials = [foregroundMaterial]
            foregroundNode = SCNNode(geometry: foregroundShape)
            foregroundNode.position = SCNVector3(0, 30, 40)
            foregroundNode.eulerAngles = SCNVector3(-0.50, Float(Double.pi), Float(Double.pi))
            foregroundNode.name = "COMPRENDO"
            scene.rootNode.addChildNode(foregroundNode)
            
            textGeometry = SCNText(string: "COMPRENDO", extrusionDepth: 0)
            textGeometry.font = UIFont.boldSystemFont(ofSize: 11)
            textGeometry.firstMaterial?.diffuse.contents = UIColor.black
            textNode = SCNNode(geometry: textGeometry)
            textNode.position = SCNVector3(422, -300, 500)
            textNode.eulerAngles = SCNVector3(0, 0, 119.8)
            textNode.name = "COMPRENDO"
            scene.rootNode.addChildNode(textNode)
            
            
            color = UIColor(red: 56/255, green: 16/255, blue: 72/255, alpha: 1)
            path = UIBezierPath()
            path.move(to: CGPoint(x: 0.58689*width, y: 0.47108*height))
            path.addLine(to: CGPoint(x: 0.59528*width, y: 0.46211*height))
            path.addLine(to: CGPoint(x: 0.60174*width, y: 0.46059*height))
            path.addLine(to: CGPoint(x: 0.61449*width, y: 0.46395*height))
            path.addLine(to: CGPoint(x: 0.61114*width, y: 0.47503*height))
            path.addLine(to: CGPoint(x: 0.63111*width, y: 0.48006*height))
            path.addCurve(to: CGPoint(x: 0.63413*width, y: 0.48451*height), controlPoint1: CGPoint(x: 0.63227*width, y: 0.48102*height), controlPoint2: CGPoint(x: 0.63379*width, y: 0.48324*height))
            path.addLine(to: CGPoint(x: 0.63782*width, y: 0.49617*height))
            path.addCurve(to: CGPoint(x: 0.6352*width, y: 0.50181*height), controlPoint1: CGPoint(x: 0.63781*width, y: 0.4978*height), controlPoint2: CGPoint(x: 0.63651*width, y: 0.50063*height))
            path.addLine(to: CGPoint(x: 0.61642*width, y: 0.52226*height))
            path.addLine(to: CGPoint(x: 0.58914*width, y: 0.51546*height))
            path.addCurve(to: CGPoint(x: 0.58353*width, y: 0.51062*height), controlPoint1: CGPoint(x: 0.58695*width, y: 0.51535*height), controlPoint2: CGPoint(x: 0.58401*width, y: 0.51316*height))
            path.addLine(to: CGPoint(x: 0.58022*width, y: 0.4994*height))
            path.addLine(to: CGPoint(x: 0.57674*width, y: 0.50016*height))
            path.addQuadCurve(to: CGPoint(x: 0.57258*width, y: 0.48686*height), controlPoint: CGPoint(x: 0.57261*width, y: 0.48692*height))
            path.addCurve(to: CGPoint(x: 0.57521*width, y: 0.47848*height), controlPoint1: CGPoint(x: 0.57124*width, y: 0.48409*height), controlPoint2: CGPoint(x: 0.57228*width, y: 0.48164*height))
            path.addLine(to: CGPoint(x: 0.58442*width, y: 0.46907*height))
            path.addLine(to: CGPoint(x: 0.58689*width, y: 0.47108*height))
            
            foregroundShape = SCNShape(path: path, extrusionDepth: 25)
            foregroundMaterial = SCNMaterial()
            foregroundMaterial.diffuse.contents = color
            foregroundShape.materials = [foregroundMaterial]
            foregroundNode = SCNNode(geometry: foregroundShape)
            foregroundNode.position = SCNVector3(0, 40, 70)
            foregroundNode.eulerAngles = SCNVector3(-0.50, Float(Double.pi), Float(Double.pi))
            foregroundNode.name = "SIMULADOR"
            scene.rootNode.addChildNode(foregroundNode)
            
            
            
            path = UIBezierPath()
            path.move(to: CGPoint(x: 0.514*width, y: 0.4929*height))
            path.addLine(to: CGPoint(x: 0.52527*width, y: 0.48651*height))
            path.addCurve(to: CGPoint(x: 0.52527*width, y: 0.4837*height), controlPoint1: CGPoint(x: 0.52588*width, y: 0.48578*height), controlPoint2: CGPoint(x: 0.52595*width, y: 0.48437*height))
            path.addLine(to: CGPoint(x: 0.5223*width, y: 0.47936*height))
            path.addLine(to: CGPoint(x: 0.52527*width, y: 0.4773*height))
            path.addLine(to: CGPoint(x: 0.51651*width, y: 0.46463*height))
            path.addLine(to: CGPoint(x: 0.514*width, y: 0.46663*height))
            path.addLine(to: CGPoint(x: 0.5109*width, y: 0.4627*height))
            path.addCurve(to: CGPoint(x: 0.50777*width, y: 0.4631*height), controlPoint1: CGPoint(x: 0.51*width, y: 0.46207*height), controlPoint2: CGPoint(x: 0.50847*width, y: 0.4624*height))
            path.addLine(to: CGPoint(x: 0.50057*width, y: 0.46823*height))
            path.addLine(to: CGPoint(x: 0.48873*width, y: 0.45139*height))
            path.addLine(to: CGPoint(x: 0.48485*width, y: 0.45388*height))
            path.addLine(to: CGPoint(x: 0.514*width, y: 0.4929*height))
            foregroundShape = SCNShape(path: path, extrusionDepth: 25)
            foregroundMaterial = SCNMaterial()
            foregroundMaterial.diffuse.contents = color
            foregroundShape.materials = [foregroundMaterial]
            foregroundNode = SCNNode(geometry: foregroundShape)
            foregroundNode.position = SCNVector3(0, 40, 70)
            foregroundNode.eulerAngles = SCNVector3(-0.50, Float(Double.pi), Float(Double.pi))
            foregroundNode.name = "EXPLORACIÓN"
            scene.rootNode.addChildNode(foregroundNode)
            
            
            path = UIBezierPath()
            path.move(to: CGPoint(x: 0.55125*width, y: 0.41375*height))
            path.addCurve(to: CGPoint(x: 0.5562*width, y: 0.41776*height), controlPoint1: CGPoint(x: 0.55297*width, y: 0.41439*height), controlPoint2: CGPoint(x: 0.55541*width, y: 0.41628*height))
            path.addCurve(to: CGPoint(x: 0.55789*width, y: 0.42271*height), controlPoint1: CGPoint(x: 0.55709*width, y: 0.41858*height), controlPoint2: CGPoint(x: 0.55747*width, y: 0.42096*height))
            path.addLine(to: CGPoint(x: 0.55578*width, y: 0.43737*height))
            path.addCurve(to: CGPoint(x: 0.55125*width, y: 0.44156*height), controlPoint1: CGPoint(x: 0.55486*width, y: 0.4386*height), controlPoint2: CGPoint(x: 0.55315*width, y: 0.44089*height))
            path.addCurve(to: CGPoint(x: 0.54692*width, y: 0.44306*height), controlPoint1: CGPoint(x: 0.55007*width, y: 0.44231*height), controlPoint2: CGPoint(x: 0.54803*width, y: 0.4428*height))
            path.addLine(to: CGPoint(x: 0.54397*width, y: 0.43948*height))
            path.addLine(to: CGPoint(x: 0.54819*width, y: 0.41449*height))
            path.addCurve(to: CGPoint(x: 0.55125*width, y: 0.41375*height), controlPoint1: CGPoint(x: 0.54979*width, y: 0.41394*height), controlPoint2: CGPoint(x: 0.55049*width, y: 0.41359*height))
            foregroundShape = SCNShape(path: path, extrusionDepth: 25)
            foregroundMaterial = SCNMaterial()
            foregroundMaterial.diffuse.contents = color
            foregroundShape.materials = [foregroundMaterial]
            foregroundNode = SCNNode(geometry: foregroundShape)
            foregroundNode.position = SCNVector3(0, 40, 70)
            foregroundNode.eulerAngles = SCNVector3(-0.50, Float(Double.pi), Float(Double.pi))
            foregroundNode.name = "ESCENARIOS"
            scene.rootNode.addChildNode(foregroundNode)
            
            
            path = UIBezierPath()
            path.move(to: CGPoint(x: 0.5702*width, y: 0.45122*height))
            path.addCurve(to: CGPoint(x: 0.57093*width, y: 0.44509*height), controlPoint1: CGPoint(x: 0.57094*width, y: 0.44953*height), controlPoint2: CGPoint(x: 0.57155*width, y: 0.4465*height))
            path.addCurve(to: CGPoint(x: 0.56447*width, y: 0.44156*height), controlPoint1: CGPoint(x: 0.56995*width, y: 0.44268*height), controlPoint2: CGPoint(x: 0.56659*width, y: 0.44146*height))
            path.addCurve(to: CGPoint(x: 0.5598*width, y: 0.44476*height), controlPoint1: CGPoint(x: 0.56301*width, y: 0.44181*height), controlPoint2: CGPoint(x: 0.56071*width, y: 0.44346*height))
            path.addCurve(to: CGPoint(x: 0.55967*width, y: 0.45016*height), controlPoint1: CGPoint(x: 0.55928*width, y: 0.4459*height), controlPoint2: CGPoint(x: 0.55938*width, y: 0.4486*height))
            path.addCurve(to: CGPoint(x: 0.56447*width, y: 0.45356*height), controlPoint1: CGPoint(x: 0.56061*width, y: 0.45174*height), controlPoint2: CGPoint(x: 0.56301*width, y: 0.45342*height))
            path.addCurve(to: CGPoint(x: 0.5702*width, y: 0.45122*height), controlPoint1: CGPoint(x: 0.56652*width, y: 0.45359*height), controlPoint2: CGPoint(x: 0.5695*width, y: 0.45257*height))
            foregroundShape = SCNShape(path: path, extrusionDepth: 25)
            foregroundMaterial = SCNMaterial()
            foregroundMaterial.diffuse.contents = color
            foregroundShape.materials = [foregroundMaterial]
            foregroundNode = SCNNode(geometry: foregroundShape)
            foregroundNode.position = SCNVector3(0, 40, 70)
            foregroundNode.eulerAngles = SCNVector3(-0.50, Float(Double.pi), Float(Double.pi))
            foregroundNode.name = "EVIDENCIAS"
            scene.rootNode.addChildNode(foregroundNode)
            
            
            
            path = UIBezierPath()
            path.move(to: CGPoint(x: 0.57711*width, y: 0.40889*height))
            path.addCurve(to: CGPoint(x: 0.58227*width, y: 0.41334*height), controlPoint1: CGPoint(x: 0.5791*width, y: 0.40926*height), controlPoint2: CGPoint(x: 0.58185*width, y: 0.41123*height))
            path.addCurve(to: CGPoint(x: 0.58015*width, y: 0.4193*height), controlPoint1: CGPoint(x: 0.58282*width, y: 0.4153*height), controlPoint2: CGPoint(x: 0.58172*width, y: 0.41827*height))
            path.addCurve(to: CGPoint(x: 0.57368*width, y: 0.42001*height), controlPoint1: CGPoint(x: 0.57898*width, y: 0.42075*height), controlPoint2: CGPoint(x: 0.57567*width, y: 0.4208*height))
            path.addCurve(to: CGPoint(x: 0.57074*width, y: 0.41425*height), controlPoint1: CGPoint(x: 0.57222*width, y: 0.41907*height), controlPoint2: CGPoint(x: 0.57069*width, y: 0.41623*height))
            path.addCurve(to: CGPoint(x: 0.57711*width, y: 0.40889*height), controlPoint1: CGPoint(x: 0.57122*width, y: 0.41185*height), controlPoint2: CGPoint(x: 0.57403*width, y: 0.40889*height))
            foregroundShape = SCNShape(path: path, extrusionDepth: 25)
            foregroundMaterial = SCNMaterial()
            foregroundMaterial.diffuse.contents = color
            foregroundShape.materials = [foregroundMaterial]
            foregroundNode = SCNNode(geometry: foregroundShape)
            foregroundNode.position = SCNVector3(0, 40, 70)
            foregroundNode.eulerAngles = SCNVector3(-0.50, Float(Double.pi), Float(Double.pi))
            foregroundNode.name = "FENÓMENOS"
            scene.rootNode.addChildNode(foregroundNode)
            
            
            path = UIBezierPath()
            path.move(to: CGPoint(x: 0.45333*width, y: 0.40664*height))
            path.addLine(to: CGPoint(x: 0.43642*width, y: 0.38338*height))
            path.addCurve(to: CGPoint(x: 0.43829*width, y: 0.38052*height), controlPoint1: CGPoint(x: 0.43599*width, y: 0.38244*height), controlPoint2: CGPoint(x: 0.43666*width, y: 0.38096*height))
            path.addLine(to: CGPoint(x: 0.44775*width, y: 0.38001*height))
            path.addLine(to: CGPoint(x: 0.46096*width, y: 0.39842*height))
            path.addQuadCurve(to: CGPoint(x: 0.45516*width, y: 0.40657*height), controlPoint: CGPoint(x: 0.45509*width, y: 0.40657*height))
            path.addQuadCurve(to: CGPoint(x: 0.45333*width, y: 0.40664*height), controlPoint: CGPoint(x: 0.45524*width, y: 0.40657*height))
            foregroundShape = SCNShape(path: path, extrusionDepth: 25)
            foregroundMaterial = SCNMaterial()
            foregroundMaterial.diffuse.contents = color
            foregroundShape.materials = [foregroundMaterial]
            foregroundNode = SCNNode(geometry: foregroundShape)
            foregroundNode.position = SCNVector3(0, 40, 70)
            foregroundNode.eulerAngles = SCNVector3(-0.50, Float(Double.pi), Float(Double.pi))
            foregroundNode.name = "GENERACIÓN"
            scene.rootNode.addChildNode(foregroundNode)
            
            path = UIBezierPath()
            path.move(to: CGPoint(x: 0.59532*width, y: 0.40065*height))
            path.addLine(to: CGPoint(x: 0.59542*width, y: 0.3589*height))
            path.addLine(to: CGPoint(x: 0.59824*width, y: 0.35875*height))
            path.addLine(to: CGPoint(x: 0.59817*width, y: 0.34669*height))
            path.addCurve(to: CGPoint(x: 0.5935*width, y: 0.34356*height), controlPoint1: CGPoint(x: 0.59734*width, y: 0.34487*height), controlPoint2: CGPoint(x: 0.59505*width, y: 0.3432*height))
            path.addLine(to: CGPoint(x: 0.5645*width, y: 0.34816*height))
            path.addCurve(to: CGPoint(x: 0.5631*width, y: 0.35062*height), controlPoint1: CGPoint(x: 0.56367*width, y: 0.34856*height), controlPoint2: CGPoint(x: 0.56294*width, y: 0.34977*height))
            path.addLine(to: CGPoint(x: 0.56397*width, y: 0.35502*height))
            path.addCurve(to: CGPoint(x: 0.56677*width, y: 0.35729*height), controlPoint1: CGPoint(x: 0.56423*width, y: 0.35623*height), controlPoint2: CGPoint(x: 0.56558*width, y: 0.35743*height))
            path.addLine(to: CGPoint(x: 0.5835*width, y: 0.35875*height))
            path.addCurve(to: CGPoint(x: 0.5855*width, y: 0.36042*height), controlPoint1: CGPoint(x: 0.58419*width, y: 0.35902*height), controlPoint2: CGPoint(x: 0.58525*width, y: 0.35956*height))
            path.addLine(to: CGPoint(x: 0.58946*width, y: 0.40065*height))
            path.addLine(to: CGPoint(x: 0.59532*width, y: 0.40065*height))
            foregroundShape = SCNShape(path: path, extrusionDepth: 25)
            foregroundMaterial = SCNMaterial()
            foregroundMaterial.diffuse.contents = color
            foregroundShape.materials = [foregroundMaterial]
            foregroundNode = SCNNode(geometry: foregroundShape)
            foregroundNode.position = SCNVector3(0, 40, 70)
            foregroundNode.eulerAngles = SCNVector3(-0.50, Float(Double.pi), Float(Double.pi))
            foregroundNode.name = "INNOVACIÓN"
            scene.rootNode.addChildNode(foregroundNode)
            
            
            path = UIBezierPath()
            path.move(to: CGPoint(x: 0.51085*width, y: 0.4013*height))
            path.addLine(to: CGPoint(x: 0.52305*width, y: 0.4021*height))
            path.addLine(to: CGPoint(x: 0.52631*width, y: 0.41364*height))
            path.addLine(to: CGPoint(x: 0.52318*width, y: 0.41337*height))
            path.addLine(to: CGPoint(x: 0.53089*width, y: 0.43079*height))
            path.addLine(to: CGPoint(x: 0.52862*width, y: 0.43152*height))
            path.addLine(to: CGPoint(x: 0.52009*width, y: 0.41306*height))
            path.addLine(to: CGPoint(x: 0.51502*width, y: 0.41252*height))
            path.addLine(to: CGPoint(x: 0.51085*width, y: 0.4013*height))
            foregroundShape = SCNShape(path: path, extrusionDepth: 25)
            foregroundMaterial = SCNMaterial()
            foregroundMaterial.diffuse.contents = color
            foregroundShape.materials = [foregroundMaterial]
            foregroundNode = SCNNode(geometry: foregroundShape)
            foregroundNode.position = SCNVector3(0, 40, 70)
            foregroundNode.eulerAngles = SCNVector3(-0.50, Float(Double.pi), Float(Double.pi))
            foregroundNode.name = "INTERPRETACIÓN"
            scene.rootNode.addChildNode(foregroundNode)
            
            path = UIBezierPath()
            path.move(to: CGPoint(x: 0.49236*width, y: 0.39564*height))
            path.addLine(to: CGPoint(x: 0.52621*width, y: 0.39564*height))
            path.addCurve(to: CGPoint(x: 0.5352*width, y: 0.37516*height), controlPoint1: CGPoint(x: 0.53029*width, y: 0.3911*height), controlPoint2: CGPoint(x: 0.53472*width, y: 0.38084*height))
            path.addCurve(to: CGPoint(x: 0.52947*width, y: 0.35383*height), controlPoint1: CGPoint(x: 0.53532*width, y: 0.36943*height), controlPoint2: CGPoint(x: 0.53253*width, y: 0.35875*height))
            path.addCurve(to: CGPoint(x: 0.51462*width, y: 0.34147*height), controlPoint1: CGPoint(x: 0.52665*width, y: 0.34981*height), controlPoint2: CGPoint(x: 0.51912*width, y: 0.34383*height))
            path.addCurve(to: CGPoint(x: 0.49489*width, y: 0.3398*height), controlPoint1: CGPoint(x: 0.50968*width, y: 0.33895*height), controlPoint2: CGPoint(x: 0.50008*width, y: 0.33885*height))
            path.addCurve(to: CGPoint(x: 0.47741*width, y: 0.34947*height), controlPoint1: CGPoint(x: 0.48955*width, y: 0.34085*height), controlPoint2: CGPoint(x: 0.48076*width, y: 0.3456*height))
            path.addCurve(to: CGPoint(x: 0.46844*width, y: 0.36936*height), controlPoint1: CGPoint(x: 0.47258*width, y: 0.35277*height), controlPoint2: CGPoint(x: 0.46887*width, y: 0.36301*height))
            path.addLine(to: CGPoint(x: 0.47334*width, y: 0.3697*height))
            path.addCurve(to: CGPoint(x: 0.48577*width, y: 0.34947*height), controlPoint1: CGPoint(x: 0.47465*width, y: 0.36318*height), controlPoint2: CGPoint(x: 0.48058*width, y: 0.35289*height))
            path.addCurve(to: CGPoint(x: 0.50393*width, y: 0.34498*height), controlPoint1: CGPoint(x: 0.48989*width, y: 0.34646*height), controlPoint2: CGPoint(x: 0.49894*width, y: 0.34409*height))
            path.addCurve(to: CGPoint(x: 0.52023*width, y: 0.35216*height), controlPoint1: CGPoint(x: 0.50865*width, y: 0.34543*height), controlPoint2: CGPoint(x: 0.51687*width, y: 0.34869*height))
            path.addCurve(to: CGPoint(x: 0.52942*width, y: 0.36839*height), controlPoint1: CGPoint(x: 0.52363*width, y: 0.35508*height), controlPoint2: CGPoint(x: 0.52847*width, y: 0.36277*height))
            path.addLine(to: CGPoint(x: 0.52936*width, y: 0.3725*height))
            path.addLine(to: CGPoint(x: 0.51846*width, y: 0.39049*height))
            path.addLine(to: CGPoint(x: 0.49235*width, y: 0.39185*height))
            path.addCurve(to: CGPoint(x: 0.49236*width, y: 0.39564*height), controlPoint1: CGPoint(x: 0.49126*width, y: 0.39279*height), controlPoint2: CGPoint(x: 0.49129*width, y: 0.39468*height))
            foregroundShape = SCNShape(path: path, extrusionDepth: 25)
            foregroundMaterial = SCNMaterial()
            foregroundMaterial.diffuse.contents = color
            foregroundShape.materials = [foregroundMaterial]
            foregroundNode = SCNNode(geometry: foregroundShape)
            foregroundNode.position = SCNVector3(0, 40, 70)
            foregroundNode.eulerAngles = SCNVector3(-0.50, Float(Double.pi), Float(Double.pi))
            foregroundNode.name = "INTERDISCIPLINA"
            scene.rootNode.addChildNode(foregroundNode)
            
            
            path = UIBezierPath()
            path.move(to: CGPoint(x: 0.51651*width, y: 0.31659*height))
            path.addLine(to: CGPoint(x: 0.5594*width, y: 0.29992*height))
            path.addCurve(to: CGPoint(x: 0.5653*width, y: 0.28954*height), controlPoint1: CGPoint(x: 0.56334*width, y: 0.29822*height), controlPoint2: CGPoint(x: 0.56554*width, y: 0.29288*height))
            path.addLine(to: CGPoint(x: 0.56469*width, y: 0.2384*height))
            path.addCurve(to: CGPoint(x: 0.55734*width, y: 0.23351*height), controlPoint1: CGPoint(x: 0.5642*width, y: 0.23389*height), controlPoint2: CGPoint(x: 0.5601*width, y: 0.23316*height))
            path.addLine(to: CGPoint(x: 0.47207*width, y: 0.26566*height))
            path.addCurve(to: CGPoint(x: 0.47008*width, y: 0.27438*height), controlPoint1: CGPoint(x: 0.46928*width, y: 0.26758*height), controlPoint2: CGPoint(x: 0.46813*width, y: 0.27192*height))
            path.addLine(to: CGPoint(x: 0.50483*width, y: 0.31373*height))
            path.addCurve(to: CGPoint(x: 0.51651*width, y: 0.31659*height), controlPoint1: CGPoint(x: 0.50679*width, y: 0.31647*height), controlPoint2: CGPoint(x: 0.51251*width, y: 0.31812*height))
            foregroundShape = SCNShape(path: path, extrusionDepth: 25)
            foregroundMaterial = SCNMaterial()
            foregroundMaterial.diffuse.contents = color
            foregroundShape.materials = [foregroundMaterial]
            foregroundNode = SCNNode(geometry: foregroundShape)
            foregroundNode.position = SCNVector3(0, 40, 70)
            foregroundNode.eulerAngles = SCNVector3(-0.50, Float(Double.pi), Float(Double.pi))
            foregroundNode.name = "BAYLAB"
            scene.rootNode.addChildNode(foregroundNode)
            
            
            guard let sceneURL = Bundle.main.url(forResource: "Tyrannosaurus_Rex_skeleton", withExtension: "usdz") else {
                print("Failed to find model file.")
                return
            }
            
            let modelScene = try? SCNScene(url: sceneURL, options: nil)
            
            if let modelScene = modelScene {
                let modelNode = modelScene.rootNode.childNodes.first ?? SCNNode()
                modelNode.position = SCNVector3(750, -510, 500)
                modelNode.scale = SCNVector3(0.35, 0.35, 0.35)
                modelNode.eulerAngles = SCNVector3(-1.4, -2.5, 1)

                scene.rootNode.addChildNode(modelNode)
            }
            
        }
        else {
            var path = UIBezierPath()
            path.move(to: CGPoint(x: 0.12822*width, y: 0.08963*height))
            path.addLine(to: CGPoint(x: 0.17047*width, y: 0.29118*height))
            path.addLine(to: CGPoint(x: 0.14969*width, y: 0.33205*height))
            path.addLine(to: CGPoint(x: 0.14969*width, y: 0.3833*height))
            path.addLine(to: CGPoint(x: 0.08319*width, y: 0.38329*height))
            path.addLine(to: CGPoint(x: 0.08228*width, y: 0.58444*height))
            path.addLine(to: CGPoint(x: 0.31052*width, y: 0.58442*height))
            path.addLine(to: CGPoint(x: 0.56475*width, y: 0.94072*height))
            path.addCurve(to: CGPoint(x: 0.58471*width, y: 0.95237*height), controlPoint1: CGPoint(x: 0.56852*width, y: 0.94534*height), controlPoint2: CGPoint(x: 0.5784*width, y: 0.95128*height))
            path.addLine(to: CGPoint(x: 0.74939*width, y: 0.95181*height))
            path.addCurve(to: CGPoint(x: 0.77323*width, y: 0.93629*height), controlPoint1: CGPoint(x: 0.75771*width, y: 0.95213*height), controlPoint2: CGPoint(x: 0.76922*width, y: 0.94377*height))
            path.addLine(to: CGPoint(x: 0.86527*width, y: 0.74832*height))
            path.addLine(to: CGPoint(x: 0.96906*width, y: 0.69102*height))
            path.addCurve(to: CGPoint(x: 0.98506*width, y: 0.64423*height), controlPoint1: CGPoint(x: 0.98226*width, y: 0.68607*height), controlPoint2: CGPoint(x: 0.98907*width, y: 0.66095*height))
            path.addLine(to: CGPoint(x: 0.95993*width, y: 0.48921*height))
            path.addLine(to: CGPoint(x: 0.9512*width, y: 0.47766*height))
            path.addLine(to: CGPoint(x: 0.6043*width, y: 0.40601*height))
            path.addLine(to: CGPoint(x: 0.60365*width, y: 0.08963*height))
            path.addLine(to: CGPoint(x: 0.12822*width, y: 0.08963*height))
            
            path.move(to: CGPoint(x: 0.65679*width, y: 0.8097*height))
            path.addLine(to: CGPoint(x: 0.713*width, y: 0.80972*height))
            path.addLine(to: CGPoint(x: 0.74575*width, y: 0.79817*height))
            path.addLine(to: CGPoint(x: 0.78507*width, y: 0.74158*height))
            path.addCurve(to: CGPoint(x: 0.79761*width, y: 0.73292*height), controlPoint1: CGPoint(x: 0.78759*width, y: 0.73919*height), controlPoint2: CGPoint(x: 0.79391*width, y: 0.73489*height))
            path.addLine(to: CGPoint(x: 0.87114*width, y: 0.69264*height))
            path.addLine(to: CGPoint(x: 0.91195*width, y: 0.66981*height))
            path.addCurve(to: CGPoint(x: 0.92405*width, y: 0.64125*height), controlPoint1: CGPoint(x: 0.91839*width, y: 0.66381*height), controlPoint2: CGPoint(x: 0.92649*width, y: 0.65147*height))
            path.addLine(to: CGPoint(x: 0.90897*width, y: 0.54345*height))
            path.addCurve(to: CGPoint(x: 0.89405*width, y: 0.53234*height), controlPoint1: CGPoint(x: 0.90625*width, y: 0.53849*height), controlPoint2: CGPoint(x: 0.89897*width, y: 0.53263*height))
            path.addLine(to: CGPoint(x: 0.84971*width, y: 0.53919*height))
            path.addCurve(to: CGPoint(x: 0.8242*width, y: 0.57802*height), controlPoint1: CGPoint(x: 0.84363*width, y: 0.53908*height), controlPoint2: CGPoint(x: 0.83359*width, y: 0.56198*height))
            path.addLine(to: CGPoint(x: 0.81695*width, y: 0.59007*height))
            path.addCurve(to: CGPoint(x: 0.78507*width, y: 0.61017*height), controlPoint1: CGPoint(x: 0.81227*width, y: 0.59977*height), controlPoint2: CGPoint(x: 0.79699*width, y: 0.61058*height))
            path.addCurve(to: CGPoint(x: 0.73248*width, y: 0.59283*height), controlPoint1: CGPoint(x: 0.76682*width, y: 0.61378*height), controlPoint2: CGPoint(x: 0.74087*width, y: 0.60493*height))
            path.addLine(to: CGPoint(x: 0.68754*width, y: 0.56691*height))
            path.addCurve(to: CGPoint(x: 0.64072*width, y: 0.56691*height), controlPoint1: CGPoint(x: 0.67879*width, y: 0.55947*height), controlPoint2: CGPoint(x: 0.65518*width, y: 0.56003*height))
            path.addLine(to: CGPoint(x: 0.50136*width, y: 0.61548*height))
            path.addCurve(to: CGPoint(x: 0.48337*width, y: 0.63667*height), controlPoint1: CGPoint(x: 0.49401*width, y: 0.62022*height), controlPoint2: CGPoint(x: 0.48333*width, y: 0.62889*height))
            path.addCurve(to: CGPoint(x: 0.48963*width, y: 0.66499*height), controlPoint1: CGPoint(x: 0.48182*width, y: 0.64649*height), controlPoint2: CGPoint(x: 0.48355*width, y: 0.66141*height))
            path.addLine(to: CGPoint(x: 0.61151*width, y: 0.80021*height))
            path.addCurve(to: CGPoint(x: 0.63276*width, y: 0.8097*height), controlPoint1: CGPoint(x: 0.6164*width, y: 0.80493*height), controlPoint2: CGPoint(x: 0.62647*width, y: 0.81061*height))
            path.addLine(to: CGPoint(x: 0.65679*width, y: 0.8097*height))
                    
            var foregroundShape = SCNShape(path: path, extrusionDepth: 80)
            var foregroundMaterial = SCNMaterial()
            foregroundMaterial.diffuse.contents = UIColor.gray
            foregroundShape.materials = [foregroundMaterial]
            var foregroundNode = SCNNode(geometry: foregroundShape)
            foregroundNode.position = SCNVector3(0, 0, 0)
            foregroundNode.name = "background"
            foregroundNode.eulerAngles = SCNVector3(-0.5, Float(Double.pi), Float(Double.pi))
            scene.rootNode.addChildNode(foregroundNode)
            
            
            color = UIColor(red: 139 / 255, green: 192 / 255, blue: 67 / 255, alpha: 1)
            path = UIBezierPath()
            path.move(to: CGPoint(x: 0.43279*width, y: 0.38329*height))
            path.addLine(to: CGPoint(x: 0.56475*width, y: 0.35071*height))
            path.addLine(to: CGPoint(x: 0.6043*width, y: 0.34909*height))
            path.addLine(to: CGPoint(x: 0.6043*width, y: 0.40601*height))
            path.addCurve(to: CGPoint(x: 0.62887*width, y: 0.45068*height), controlPoint1: CGPoint(x: 0.60357*width, y: 0.42221*height), controlPoint2: CGPoint(x: 0.60749*width, y: 0.44666*height))
            path.addLine(to: CGPoint(x: 0.83336*width, y: 0.48921*height))
            path.addLine(to: CGPoint(x: 0.84554*width, y: 0.47766*height))
            path.addCurve(to: CGPoint(x: 0.86344*width, y: 0.47766*height), controlPoint1: CGPoint(x: 0.8499*width, y: 0.47615*height), controlPoint2: CGPoint(x: 0.85881*width, y: 0.47595*height))
            path.addLine(to: CGPoint(x: 0.93574*width, y: 0.49308*height))
            path.addLine(to: CGPoint(x: 0.94901*width, y: 0.50817*height))
            path.addLine(to: CGPoint(x: 0.97285*width, y: 0.66087*height))
            path.addCurve(to: CGPoint(x: 0.96328*width, y: 0.67878*height), controlPoint1: CGPoint(x: 0.97432*width, y: 0.6677*height), controlPoint2: CGPoint(x: 0.96807*width, y: 0.67518*height))
            path.addLine(to: CGPoint(x: 0.88636*width, y: 0.72146*height))
            path.addLine(to: CGPoint(x: 0.87114*width, y: 0.69264*height))
            path.addLine(to: CGPoint(x: 0.91195*width, y: 0.66981*height))
            path.addCurve(to: CGPoint(x: 0.92405*width, y: 0.64125*height), controlPoint1: CGPoint(x: 0.91895*width, y: 0.66369*height), controlPoint2: CGPoint(x: 0.92611*width, y: 0.64995*height))
            path.addLine(to: CGPoint(x: 0.90897*width, y: 0.54345*height))
            path.addCurve(to: CGPoint(x: 0.89405*width, y: 0.53234*height), controlPoint1: CGPoint(x: 0.90723*width, y: 0.53878*height), controlPoint2: CGPoint(x: 0.8997*width, y: 0.5333*height))
            path.addLine(to: CGPoint(x: 0.84971*width, y: 0.53919*height))
            path.addCurve(to: CGPoint(x: 0.84158*width, y: 0.54703*height), controlPoint1: CGPoint(x: 0.84654*width, y: 0.54001*height), controlPoint2: CGPoint(x: 0.84283*width, y: 0.54417*height))
            path.addLine(to: CGPoint(x: 0.81519*width, y: 0.59306*height))
            path.addCurve(to: CGPoint(x: 0.73248*width, y: 0.59283*height), controlPoint1: CGPoint(x: 0.80018*width, y: 0.6167*height), controlPoint2: CGPoint(x: 0.75872*width, y: 0.61612*height))
            path.addLine(to: CGPoint(x: 0.68754*width, y: 0.56691*height))
            path.addCurve(to: CGPoint(x: 0.65035*width, y: 0.56364*height), controlPoint1: CGPoint(x: 0.67708*width, y: 0.55998*height), controlPoint2: CGPoint(x: 0.6596*width, y: 0.56077*height))
            path.addLine(to: CGPoint(x: 0.50136*width, y: 0.61548*height))
            path.addCurve(to: CGPoint(x: 0.49003*width, y: 0.62438*height), controlPoint1: CGPoint(x: 0.49754*width, y: 0.6173*height), controlPoint2: CGPoint(x: 0.49172*width, y: 0.62164*height))
            path.addLine(to: CGPoint(x: 0.46464*width, y: 0.55329*height))
            path.addLine(to: CGPoint(x: 0.52379*width, y: 0.53671*height))
            path.addCurve(to: CGPoint(x: 0.52532*width, y: 0.52252*height), controlPoint1: CGPoint(x: 0.52821*width, y: 0.53477*height), controlPoint2: CGPoint(x: 0.52991*width, y: 0.52812*height))
            path.addLine(to: CGPoint(x: 0.43279*width, y: 0.38329*height))
            foregroundShape = SCNShape(path: path, extrusionDepth: 25)
            foregroundMaterial = SCNMaterial()
            foregroundMaterial.diffuse.contents = color
            foregroundShape.materials = [foregroundMaterial]
            foregroundNode = SCNNode(geometry: foregroundShape)
            foregroundNode.position = SCNVector3(0, 20, 40)
            foregroundNode.eulerAngles = SCNVector3(-0.50, Float(Double.pi), Float(Double.pi))
            foregroundNode.name = "PERTENEZCO"
            scene.rootNode.addChildNode(foregroundNode)
            
            var textGeometry = SCNText(string: "PERTENEZCO", extrusionDepth: 0)
            textGeometry.font = UIFont.boldSystemFont(ofSize: 11)
            textGeometry.firstMaterial?.diffuse.contents = UIColor.black
            var textNode = SCNNode(geometry: textGeometry)
            textNode.position = SCNVector3(740, -435, 500)
            textNode.eulerAngles = SCNVector3(0, 0, 0)
            textNode.name = "PERTENEZCO"
            scene.rootNode.addChildNode(textNode)
            
            color = UIColor(red: 65 / 255, green: 130 / 255, blue: 1 / 255, alpha: 1 )
            path = UIBezierPath()
            path.move(to: CGPoint(x: 0.87963*width, y: 0.70741*height))
            path.addLine(to: CGPoint(x: 0.88689*width, y: 0.72107*height))
            path.addLine(to: CGPoint(x: 0.93877*width, y: 0.6939*height))
            path.addLine(to: CGPoint(x: 0.93194*width, y: 0.68038*height))
            path.addLine(to: CGPoint(x: 0.87963*width, y: 0.70741*height))
            foregroundShape = SCNShape(path: path, extrusionDepth: 25)
            foregroundMaterial = SCNMaterial()
            foregroundMaterial.diffuse.contents = color
            foregroundShape.materials = [foregroundMaterial]
            foregroundNode = SCNNode(geometry: foregroundShape)
            foregroundNode.position = SCNVector3(0, 40, 70)
            foregroundNode.eulerAngles = SCNVector3(-0.50, Float(Double.pi), Float(Double.pi))
            foregroundNode.name = "ESPECIES"
            scene.rootNode.addChildNode(foregroundNode)
               
            
            path = UIBezierPath()
            path.move(to: CGPoint(x: 0.96975*width, y: 0.64829*height))
            path.addLine(to: CGPoint(x: 0.95081*width, y: 0.65084*height))
            path.addLine(to: CGPoint(x: 0.95088*width, y: 0.62693*height))
            path.addLine(to: CGPoint(x: 0.95675*width, y: 0.62438*height))
            path.addLine(to: CGPoint(x: 0.95835*width, y: 0.63486*height))
            path.addLine(to: CGPoint(x: 0.96328*width, y: 0.63399*height))
            path.addLine(to: CGPoint(x: 0.95834*width, y: 0.60268*height))
            path.addLine(to: CGPoint(x: 0.94692*width, y: 0.60508*height))
            path.addLine(to: CGPoint(x: 0.94339*width, y: 0.581*height))
            path.addLine(to: CGPoint(x: 0.95466*width, y: 0.57927*height))
            path.addLine(to: CGPoint(x: 0.94901*width, y: 0.54345*height))
            path.addLine(to: CGPoint(x: 0.94474*width, y: 0.54345*height))
            path.addLine(to: CGPoint(x: 0.94549*width, y: 0.55779*height))
            path.addLine(to: CGPoint(x: 0.93936*width, y: 0.55487*height))
            path.addLine(to: CGPoint(x: 0.93256*width, y: 0.53373*height))
            path.addLine(to: CGPoint(x: 0.94692*width, y: 0.53234*height))
            path.addLine(to: CGPoint(x: 0.94493*width, y: 0.51769*height))
            path.addLine(to: CGPoint(x: 0.95081*width, y: 0.51769*height))
            path.addLine(to: CGPoint(x: 0.96975*width, y: 0.64829*height))
            foregroundShape = SCNShape(path: path, extrusionDepth: 25)
            foregroundMaterial = SCNMaterial()
            foregroundMaterial.diffuse.contents = color
            foregroundShape.materials = [foregroundMaterial]
            foregroundNode = SCNNode(geometry: foregroundShape)
            foregroundNode.position = SCNVector3(0, 40, 70)
            foregroundNode.eulerAngles = SCNVector3(-0.50, Float(Double.pi), Float(Double.pi))
            foregroundNode.name = "VIENTO"
            scene.rootNode.addChildNode(foregroundNode)
                  
            path = UIBezierPath()
            path.move(to: CGPoint(x: 0.83336*width, y: 0.49504*height))
            path.addLine(to: CGPoint(x: 0.90162*width, y: 0.50959*height))
            path.addCurve(to: CGPoint(x: 0.9219*width, y: 0.49602*height), controlPoint1: CGPoint(x: 0.90977*width, y: 0.51048*height), controlPoint2: CGPoint(x: 0.91884*width, y: 0.5026*height))
            path.addLine(to: CGPoint(x: 0.91195*width, y: 0.48921*height))
            path.addLine(to: CGPoint(x: 0.85944*width, y: 0.47766*height))
            path.addCurve(to: CGPoint(x: 0.84554*width, y: 0.47766*height), controlPoint1: CGPoint(x: 0.85599*width, y: 0.47707*height), controlPoint2: CGPoint(x: 0.84905*width, y: 0.47713*height))
            path.addCurve(to: CGPoint(x: 0.83336*width, y: 0.49504*height), controlPoint1: CGPoint(x: 0.83995*width, y: 0.48408*height), controlPoint2: CGPoint(x: 0.8304*width, y: 0.49151*height))
            foregroundShape = SCNShape(path: path, extrusionDepth: 25)
            foregroundMaterial = SCNMaterial()
            foregroundMaterial.diffuse.contents = color
            foregroundShape.materials = [foregroundMaterial]
            foregroundNode = SCNNode(geometry: foregroundShape)
            foregroundNode.position = SCNVector3(0, 40, 70)
            foregroundNode.eulerAngles = SCNVector3(-0.50, Float(Double.pi), Float(Double.pi))
            foregroundNode.name = "MARIPOSAS"
            scene.rootNode.addChildNode(foregroundNode)
            
            
            path = UIBezierPath()
            path.move(to: CGPoint(x: 0.73528*width, y: 0.56364*height))
            path.addLine(to: CGPoint(x: 0.73323*width, y: 0.53537*height))
            path.addLine(to: CGPoint(x: 0.72864*width, y: 0.53381*height))
            path.addCurve(to: CGPoint(x: 0.72635*width, y: 0.53595*height), controlPoint1: CGPoint(x: 0.72739*width, y: 0.53411*height), controlPoint2: CGPoint(x: 0.72613*width, y: 0.53512*height))
            path.addLine(to: CGPoint(x: 0.72438*width, y: 0.56553*height))
            path.addLine(to: CGPoint(x: 0.73676*width, y: 0.57258*height))
            path.addCurve(to: CGPoint(x: 0.73922*width, y: 0.57176*height), controlPoint1: CGPoint(x: 0.73745*width, y: 0.57269*height), controlPoint2: CGPoint(x: 0.73868*width, y: 0.57241*height))
            path.addCurve(to: CGPoint(x: 0.73922*width, y: 0.56734*height), controlPoint1: CGPoint(x: 0.7395*width, y: 0.57026*height), controlPoint2: CGPoint(x: 0.73974*width, y: 0.56793*height))
            path.addLine(to: CGPoint(x: 0.73528*width, y: 0.56364*height))
            foregroundShape = SCNShape(path: path, extrusionDepth: 25)
            foregroundMaterial = SCNMaterial()
            foregroundMaterial.diffuse.contents = color
            foregroundShape.materials = [foregroundMaterial]
            foregroundNode = SCNNode(geometry: foregroundShape)
            foregroundNode.position = SCNVector3(0, 40, 70)
            foregroundNode.eulerAngles = SCNVector3(-0.50, Float(Double.pi), Float(Double.pi))
            foregroundNode.name = "SUCULENTAS"
            scene.rootNode.addChildNode(foregroundNode)
            
            
            path = UIBezierPath()
            path.move(to: CGPoint(x: 0.73195*width, y: 0.49285*height))
            path.addCurve(to: CGPoint(x: 0.73774*width, y: 0.49345*height), controlPoint1: CGPoint(x: 0.733*width, y: 0.49452*height), controlPoint2: CGPoint(x: 0.73595*width, y: 0.49435*height))
            path.addCurve(to: CGPoint(x: 0.74187*width, y: 0.50232*height), controlPoint1: CGPoint(x: 0.74091*width, y: 0.49665*height), controlPoint2: CGPoint(x: 0.74274*width, y: 0.49986*height))
            path.addCurve(to: CGPoint(x: 0.73747*width, y: 0.51032*height), controlPoint1: CGPoint(x: 0.74162*width, y: 0.50302*height), controlPoint2: CGPoint(x: 0.74015*width, y: 0.50584*height))
            path.addCurve(to: CGPoint(x: 0.72667*width, y: 0.51025*height), controlPoint1: CGPoint(x: 0.73428*width, y: 0.5133*height), controlPoint2: CGPoint(x: 0.72887*width, y: 0.51329*height))
            path.addCurve(to: CGPoint(x: 0.7222*width, y: 0.50239*height), controlPoint1: CGPoint(x: 0.72594*width, y: 0.5081*height), controlPoint2: CGPoint(x: 0.72372*width, y: 0.50416*height))
            path.addCurve(to: CGPoint(x: 0.72707*width, y: 0.49372*height), controlPoint1: CGPoint(x: 0.72218*width, y: 0.49905*height), controlPoint2: CGPoint(x: 0.72445*width, y: 0.49457*height))
            path.addCurve(to: CGPoint(x: 0.73195*width, y: 0.49285*height), controlPoint1: CGPoint(x: 0.72851*width, y: 0.49422*height), controlPoint2: CGPoint(x: 0.73095*width, y: 0.49424*height))
            foregroundShape = SCNShape(path: path, extrusionDepth: 25)
            foregroundMaterial = SCNMaterial()
            foregroundMaterial.diffuse.contents = color
            foregroundShape.materials = [foregroundMaterial]
            foregroundNode = SCNNode(geometry: foregroundShape)
            foregroundNode.position = SCNVector3(0, 40, 70)
            foregroundNode.eulerAngles = SCNVector3(-0.50, Float(Double.pi), Float(Double.pi))
            foregroundNode.name = "CADENA"
            scene.rootNode.addChildNode(foregroundNode)
                    
                
            path = UIBezierPath()
            path.move(to: CGPoint(x: 0.69713*width, y: 0.48918*height))
            path.addLine(to: CGPoint(x: 0.70518*width, y: 0.4893*height))
            path.addLine(to: CGPoint(x: 0.7053*width, y: 0.5424*height))
            path.addLine(to: CGPoint(x: 0.69689*width, y: 0.54228*height))
            path.addLine(to: CGPoint(x: 0.69713*width, y: 0.48918*height))
            foregroundShape = SCNShape(path: path, extrusionDepth: 25)
            foregroundMaterial = SCNMaterial()
            foregroundMaterial.diffuse.contents = color
            foregroundShape.materials = [foregroundMaterial]
            foregroundNode = SCNNode(geometry: foregroundShape)
            foregroundNode.position = SCNVector3(0, 40, 70)
            foregroundNode.eulerAngles = SCNVector3(-0.50, Float(Double.pi), Float(Double.pi))
            foregroundNode.name = "BIODIVERSIDAD"
            scene.rootNode.addChildNode(foregroundNode)
                    
            
            path = UIBezierPath()
            path.move(to: CGPoint(x: 0.63513*width, y: 0.45444*height))
            path.addLine(to: CGPoint(x: 0.63466*width, y: 0.45669*height))
            path.addLine(to: CGPoint(x: 0.67437*width, y: 0.46457*height))
            path.addLine(to: CGPoint(x: 0.67465*width, y: 0.46204*height))
            path.addLine(to: CGPoint(x: 0.63513*width, y: 0.45444*height))
            foregroundShape = SCNShape(path: path, extrusionDepth: 25)
            foregroundMaterial = SCNMaterial()
            foregroundMaterial.diffuse.contents = color
            foregroundShape.materials = [foregroundMaterial]
            foregroundNode = SCNNode(geometry: foregroundShape)
            foregroundNode.position = SCNVector3(0, 30, 70)
            foregroundNode.eulerAngles = SCNVector3(-0.50, Float(Double.pi), Float(Double.pi))
            foregroundNode.name = "ATMÓSFERA"
            scene.rootNode.addChildNode(foregroundNode)
            
            path = UIBezierPath()
            path.move(to: CGPoint(x: 0.58673*width, y: 0.47357*height))
            path.addLine(to: CGPoint(x: 0.62553*width, y: 0.48052*height))
            path.addLine(to: CGPoint(x: 0.62433*width, y: 0.48857*height))
            path.addLine(to: CGPoint(x: 0.58507*width, y: 0.48126*height))
            path.addLine(to: CGPoint(x: 0.58673*width, y: 0.47357*height))
            foregroundShape = SCNShape(path: path, extrusionDepth: 25)
            foregroundMaterial = SCNMaterial()
            foregroundMaterial.diffuse.contents = color
            foregroundShape.materials = [foregroundMaterial]
            foregroundNode = SCNNode(geometry: foregroundShape)
            foregroundNode.position = SCNVector3(0, 40, 70)
            foregroundNode.eulerAngles = SCNVector3(-0.50, Float(Double.pi), Float(Double.pi))
            foregroundNode.name = "AIRE"
            scene.rootNode.addChildNode(foregroundNode)
                    
            
            path = UIBezierPath()
            path.move(to: CGPoint(x: 0.60791*width, y: 0.53305*height))
            path.addLine(to: CGPoint(x: 0.59834*width, y: 0.53548*height))
            path.addCurve(to: CGPoint(x: 0.59714*width, y: 0.53921*height), controlPoint1: CGPoint(x: 0.59676*width, y: 0.5362*height), controlPoint2: CGPoint(x: 0.5963*width, y: 0.53808*height))
            path.addLine(to: CGPoint(x: 0.60791*width, y: 0.56071*height))
            path.addCurve(to: CGPoint(x: 0.61261*width, y: 0.56152*height), controlPoint1: CGPoint(x: 0.6084*width, y: 0.56176*height), controlPoint2: CGPoint(x: 0.61065*width, y: 0.56228*height))
            path.addLine(to: CGPoint(x: 0.64043*width, y: 0.55163*height))
            path.addCurve(to: CGPoint(x: 0.64149*width, y: 0.54692*height), controlPoint1: CGPoint(x: 0.64147*width, y: 0.54977*height), controlPoint2: CGPoint(x: 0.64195*width, y: 0.54871*height))
            path.addQuadCurve(to: CGPoint(x: 0.62989*width, y: 0.53054*height), controlPoint: CGPoint(x: 0.64147*width, y: 0.54685*height))
            path.addCurve(to: CGPoint(x: 0.62518*width, y: 0.52957*height), controlPoint1: CGPoint(x: 0.6291*width, y: 0.52928*height), controlPoint2: CGPoint(x: 0.62668*width, y: 0.5291*height))
            path.addLine(to: CGPoint(x: 0.6174*width, y: 0.53127*height))
            path.addLine(to: CGPoint(x: 0.61821*width, y: 0.53305*height))
            path.addLine(to: CGPoint(x: 0.6264*width, y: 0.53135*height))
            path.addCurve(to: CGPoint(x: 0.62908*width, y: 0.53224*height), controlPoint1: CGPoint(x: 0.62704*width, y: 0.53108*height), controlPoint2: CGPoint(x: 0.62828*width, y: 0.5312*height))
            path.addLine(to: CGPoint(x: 0.64011*width, y: 0.54855*height))
            path.addCurve(to: CGPoint(x: 0.63954*width, y: 0.55009*height), controlPoint1: CGPoint(x: 0.64016*width, y: 0.54903*height), controlPoint2: CGPoint(x: 0.63988*width, y: 0.54981*height))
            path.addLine(to: CGPoint(x: 0.62259*width, y: 0.55593*height))
            path.addLine(to: CGPoint(x: 0.6144*width, y: 0.55901*height))
            path.addCurve(to: CGPoint(x: 0.60937*width, y: 0.55836*height), controlPoint1: CGPoint(x: 0.61232*width, y: 0.55964*height), controlPoint2: CGPoint(x: 0.60924*width, y: 0.56045*height))
            path.addLine(to: CGPoint(x: 0.59834*width, y: 0.53784*height))
            path.addLine(to: CGPoint(x: 0.60791*width, y: 0.53548*height))
            path.addLine(to: CGPoint(x: 0.60791*width, y: 0.53305*height))
            path.move(to: CGPoint(x: 0.60485*width, y: 0.53963*height))
            path.addLine(to: CGPoint(x: 0.61272*width, y: 0.55563*height))
            path.addLine(to: CGPoint(x: 0.63319*width, y: 0.54856*height))
            path.addLine(to: CGPoint(x: 0.62412*width, y: 0.53456*height))
            path.addLine(to: CGPoint(x: 0.60485*width, y: 0.53963*height))
            foregroundShape = SCNShape(path: path, extrusionDepth: 25)
            foregroundMaterial = SCNMaterial()
            foregroundMaterial.diffuse.contents = color
            foregroundShape.materials = [foregroundMaterial]
            foregroundNode = SCNNode(geometry: foregroundShape)
            foregroundNode.position = SCNVector3(0, 40, 70)
            foregroundNode.eulerAngles = SCNVector3(-0.50, Float(Double.pi), Float(Double.pi))
            foregroundNode.name = "SERVICIOS"
            scene.rootNode.addChildNode(foregroundNode)
            
            
            path = UIBezierPath()
            path.move(to: CGPoint(x: 0.53007*width, y: 0.56804*height))
            path.addLine(to: CGPoint(x: 0.52848*width, y: 0.58265*height))
            path.addLine(to: CGPoint(x: 0.49637*width, y: 0.59239*height))
            path.addCurve(to: CGPoint(x: 0.49637*width, y: 0.58275*height), controlPoint1: CGPoint(x: 0.4948*width, y: 0.59045*height), controlPoint2: CGPoint(x: 0.49329*width, y: 0.58666*height))
            path.addCurve(to: CGPoint(x: 0.53007*width, y: 0.56804*height), controlPoint1: CGPoint(x: 0.51126*width, y: 0.57586*height), controlPoint2: CGPoint(x: 0.52811*width, y: 0.56356*height))
            foregroundShape = SCNShape(path: path, extrusionDepth: 25)
            foregroundMaterial = SCNMaterial()
            foregroundMaterial.diffuse.contents = color
            foregroundShape.materials = [foregroundMaterial]
            foregroundNode = SCNNode(geometry: foregroundShape)
            foregroundNode.position = SCNVector3(0, 40, 70)
            foregroundNode.eulerAngles = SCNVector3(-0.50, Float(Double.pi), Float(Double.pi))
            foregroundNode.name = "SUPERFICIE"
            scene.rootNode.addChildNode(foregroundNode)
            
            
            path = UIBezierPath()
            path.move(to: CGPoint(x: 0.53007*width, y: 0.56804*height))
            path.addLine(to: CGPoint(x: 0.52848*width, y: 0.58265*height))
            path.addLine(to: CGPoint(x: 0.49637*width, y: 0.59239*height))
            path.addCurve(to: CGPoint(x: 0.49637*width, y: 0.58275*height), controlPoint1: CGPoint(x: 0.4948*width, y: 0.59045*height), controlPoint2: CGPoint(x: 0.49329*width, y: 0.58666*height))
            path.addCurve(to: CGPoint(x: 0.53007*width, y: 0.56804*height), controlPoint1: CGPoint(x: 0.51126*width, y: 0.57586*height), controlPoint2: CGPoint(x: 0.52811*width, y: 0.56356*height))
            foregroundShape = SCNShape(path: path, extrusionDepth: 25)
            foregroundMaterial = SCNMaterial()
            foregroundMaterial.diffuse.contents = color
            foregroundShape.materials = [foregroundMaterial]
            foregroundNode = SCNNode(geometry: foregroundShape)
            foregroundNode.position = SCNVector3(0, 40, 70)
            foregroundNode.eulerAngles = SCNVector3(-0.50, Float(Double.pi), Float(Double.pi))
            foregroundNode.name = "SUPERFICIE"
            scene.rootNode.addChildNode(foregroundNode)
            
            
            path = UIBezierPath()
            path.move(to: CGPoint(x: 0.53283*width, y: 0.56801*height))
            path.addLine(to: CGPoint(x: 0.53103*width, y: 0.58155*height))
            path.addLine(to: CGPoint(x: 0.53816*width, y: 0.57915*height))
            path.addCurve(to: CGPoint(x: 0.53916*width, y: 0.56495*height), controlPoint1: CGPoint(x: 0.54177*width, y: 0.57496*height), controlPoint2: CGPoint(x: 0.54377*width, y: 0.5678*height))
            path.addLine(to: CGPoint(x: 0.53283*width, y: 0.56488*height))
            path.addLine(to: CGPoint(x: 0.53283*width, y: 0.56801*height))
            foregroundShape = SCNShape(path: path, extrusionDepth: 25)
            foregroundMaterial = SCNMaterial()
            foregroundMaterial.diffuse.contents = color
            foregroundShape.materials = [foregroundMaterial]
            foregroundNode = SCNNode(geometry: foregroundShape)
            foregroundNode.position = SCNVector3(0, 40, 70)
            foregroundNode.eulerAngles = SCNVector3(-0.50, Float(Double.pi), Float(Double.pi))
            foregroundNode.name = "ROCAS"
            scene.rootNode.addChildNode(foregroundNode)
            
            
            
            path = UIBezierPath()
            path.move(to: CGPoint(x: 0.52589*width, y: 0.46137*height))
            path.addLine(to: CGPoint(x: 0.52113*width, y: 0.46741*height))
            path.addLine(to: CGPoint(x: 0.56143*width, y: 0.5*height))
            path.addLine(to: CGPoint(x: 0.56677*width, y: 0.49401*height))
            path.addLine(to: CGPoint(x: 0.52589*width, y: 0.46137*height))
            foregroundShape = SCNShape(path: path, extrusionDepth: 25)
            foregroundMaterial = SCNMaterial()
            foregroundMaterial.diffuse.contents = color
            foregroundShape.materials = [foregroundMaterial]
            foregroundNode = SCNNode(geometry: foregroundShape)
            foregroundNode.position = SCNVector3(0, 40, 70)
            foregroundNode.eulerAngles = SCNVector3(-0.50, Float(Double.pi), Float(Double.pi))
            foregroundNode.name = "SUELO"
            scene.rootNode.addChildNode(foregroundNode)
            
            path = UIBezierPath()
            path.move(to: CGPoint(x: 0.56421*width, y: 0.53161*height))
            path.addLine(to: CGPoint(x: 0.56768*width, y: 0.53534*height))
            path.addLine(to: CGPoint(x: 0.55595*width, y: 0.54821*height))
            path.addLine(to: CGPoint(x: 0.55201*width, y: 0.54461*height))
            path.addLine(to: CGPoint(x: 0.55501*width, y: 0.54094*height))
            path.addLine(to: CGPoint(x: 0.55261*width, y: 0.53807*height))
            path.addLine(to: CGPoint(x: 0.55588*width, y: 0.53494*height))
            path.addLine(to: CGPoint(x: 0.55888*width, y: 0.53694*height))
            path.addLine(to: CGPoint(x: 0.56421*width, y: 0.53161*height))
            foregroundShape = SCNShape(path: path, extrusionDepth: 25)
            foregroundMaterial = SCNMaterial()
            foregroundMaterial.diffuse.contents = color
            foregroundShape.materials = [foregroundMaterial]
            foregroundNode = SCNNode(geometry: foregroundShape)
            foregroundNode.position = SCNVector3(0, 40, 70)
            foregroundNode.eulerAngles = SCNVector3(-0.50, Float(Double.pi), Float(Double.pi))
            foregroundNode.name = "LOMBRICOMPOSTA"
            scene.rootNode.addChildNode(foregroundNode)
            
            
            path = UIBezierPath()
            path.move(to: CGPoint(x: 0.57055*width, y: 0.53161*height))
            path.addLine(to: CGPoint(x: 0.56768*width, y: 0.528*height))
            path.addLine(to: CGPoint(x: 0.58873*width, y: 0.50506*height))
            path.addCurve(to: CGPoint(x: 0.59833*width, y: 0.50326*height), controlPoint1: CGPoint(x: 0.59074*width, y: 0.50348*height), controlPoint2: CGPoint(x: 0.59496*width, y: 0.50188*height))
            path.addLine(to: CGPoint(x: 0.60246*width, y: 0.50526*height))
            path.addLine(to: CGPoint(x: 0.60486*width, y: 0.5*height))
            path.addLine(to: CGPoint(x: 0.60866*width, y: 0.50172*height))
            path.addLine(to: CGPoint(x: 0.6086*width, y: 0.50819*height))
            path.addLine(to: CGPoint(x: 0.61473*width, y: 0.51172*height))
            path.addLine(to: CGPoint(x: 0.6126*width, y: 0.51579*height))
            path.addLine(to: CGPoint(x: 0.59773*width, y: 0.50806*height))
            path.addCurve(to: CGPoint(x: 0.591*width, y: 0.50879*height), controlPoint1: CGPoint(x: 0.59566*width, y: 0.50699*height), controlPoint2: CGPoint(x: 0.59231*width, y: 0.50741*height))
            path.addLine(to: CGPoint(x: 0.57055*width, y: 0.53161*height))
            foregroundShape = SCNShape(path: path, extrusionDepth: 25)
            foregroundMaterial = SCNMaterial()
            foregroundMaterial.diffuse.contents = color
            foregroundShape.materials = [foregroundMaterial]
            foregroundNode = SCNNode(geometry: foregroundShape)
            foregroundNode.position = SCNVector3(0, 40, 70)
            foregroundNode.eulerAngles = SCNVector3(-0.50, Float(Double.pi), Float(Double.pi))
            foregroundNode.name = "ORGANISMOS"
            scene.rootNode.addChildNode(foregroundNode)
              
            
            path = UIBezierPath()
            path.move(to: CGPoint(x: 0.44058*width, y: 0.3948*height))
            path.addLine(to: CGPoint(x: 0.5122*width, y: 0.36814*height))
            path.addLine(to: CGPoint(x: 0.51261*width, y: 0.3698*height))
            path.addLine(to: CGPoint(x: 0.52245*width, y: 0.36602*height))
            path.addCurve(to: CGPoint(x: 0.53366*width, y: 0.37492*height), controlPoint1: CGPoint(x: 0.52671*width, y: 0.36594*height), controlPoint2: CGPoint(x: 0.53268*width, y: 0.36958*height))
            path.addLine(to: CGPoint(x: 0.53322*width, y: 0.40614*height))
            path.addCurve(to: CGPoint(x: 0.52883*width, y: 0.41259*height), controlPoint1: CGPoint(x: 0.53278*width, y: 0.40797*height), controlPoint2: CGPoint(x: 0.53209*width, y: 0.41073*height))
            path.addLine(to: CGPoint(x: 0.48615*width, y: 0.44313*height))
            path.addCurve(to: CGPoint(x: 0.47583*width, y: 0.44102*height), controlPoint1: CGPoint(x: 0.48291*width, y: 0.44448*height), controlPoint2: CGPoint(x: 0.47771*width, y: 0.44357*height))
            path.addLine(to: CGPoint(x: 0.47409*width, y: 0.44176*height))
            path.addLine(to: CGPoint(x: 0.44058*width, y: 0.3948*height))
            foregroundShape = SCNShape(path: path, extrusionDepth: 25)
            foregroundMaterial = SCNMaterial()
            foregroundMaterial.diffuse.contents = color
            foregroundShape.materials = [foregroundMaterial]
            foregroundNode = SCNNode(geometry: foregroundShape)
            foregroundNode.position = SCNVector3(0, 40, 70)
            foregroundNode.eulerAngles = SCNVector3(-0.50, Float(Double.pi), Float(Double.pi))
            foregroundNode.name = "NATURALEZA"
            scene.rootNode.addChildNode(foregroundNode)
            
            path = UIBezierPath()
            path.move(to: CGPoint(x: 0.56344*width, y: 0.36602*height))
            path.addLine(to: CGPoint(x: 0.5738*width, y: 0.36641*height))
            path.addLine(to: CGPoint(x: 0.57421*width, y: 0.36003*height))
            path.addLine(to: CGPoint(x: 0.57873*width, y: 0.36065*height))
            path.addLine(to: CGPoint(x: 0.57853*width, y: 0.36675*height))
            path.addLine(to: CGPoint(x: 0.58888*width, y: 0.36785*height))
            path.addCurve(to: CGPoint(x: 0.58813*width, y: 0.37505*height), controlPoint1: CGPoint(x: 0.59154*width, y: 0.3696*height), controlPoint2: CGPoint(x: 0.59196*width, y: 0.37314*height))
            path.addLine(to: CGPoint(x: 0.57757*width, y: 0.37443*height))
            path.addCurve(to: CGPoint(x: 0.57345*width, y: 0.37416*height), controlPoint1: CGPoint(x: 0.57635*width, y: 0.37811*height), controlPoint2: CGPoint(x: 0.57435*width, y: 0.37719*height))
            path.addLine(to: CGPoint(x: 0.56262*width, y: 0.37313*height))
            path.addCurve(to: CGPoint(x: 0.56344*width, y: 0.36602*height), controlPoint1: CGPoint(x: 0.56015*width, y: 0.37133*height), controlPoint2: CGPoint(x: 0.5591*width, y: 0.36791*height))
            foregroundShape = SCNShape(path: path, extrusionDepth: 25)
            foregroundMaterial = SCNMaterial()
            foregroundMaterial.diffuse.contents = color
            foregroundShape.materials = [foregroundMaterial]
            foregroundNode = SCNNode(geometry: foregroundShape)
            foregroundNode.position = SCNVector3(0, 40, 70)
            foregroundNode.eulerAngles = SCNVector3(-0.50, Float(Double.pi), Float(Double.pi))
            foregroundNode.name = "AGUA"
            scene.rootNode.addChildNode(foregroundNode)
                    
            path = UIBezierPath()
            path.move(to: CGPoint(x: 0.60071*width, y: 0.38639*height))
            path.addLine(to: CGPoint(x: 0.60046*width, y: 0.42655*height))
            path.addLine(to: CGPoint(x: 0.59601*width, y: 0.42655*height))
            path.addLine(to: CGPoint(x: 0.59589*width, y: 0.38981*height))
            path.addLine(to: CGPoint(x: 0.60071*width, y: 0.38639*height))
            foregroundShape = SCNShape(path: path, extrusionDepth: 25)
            foregroundMaterial = SCNMaterial()
            foregroundMaterial.diffuse.contents = color
            foregroundShape.materials = [foregroundMaterial]
            foregroundNode = SCNNode(geometry: foregroundShape)
            foregroundNode.position = SCNVector3(0, 40, 70)
            foregroundNode.eulerAngles = SCNVector3(-0.50, Float(Double.pi), Float(Double.pi))
            foregroundNode.name = "ATRATOS"
            scene.rootNode.addChildNode(foregroundNode)
            
            path = UIBezierPath()
            path.move(to: CGPoint(x: 0.59601*width, y: 0.43026*height))
            path.addLine(to: CGPoint(x: 0.60046*width, y: 0.43035*height))
            path.addCurve(to: CGPoint(x: 0.61946*width, y: 0.45083*height), controlPoint1: CGPoint(x: 0.60108*width, y: 0.43949*height), controlPoint2: CGPoint(x: 0.60963*width, y: 0.4505*height))
            path.addLine(to: CGPoint(x: 0.61863*width, y: 0.45724*height))
            path.addCurve(to: CGPoint(x: 0.59601*width, y: 0.43026*height), controlPoint1: CGPoint(x: 0.59874*width, y: 0.45247*height), controlPoint2: CGPoint(x: 0.59682*width, y: 0.43911*height))
            foregroundShape = SCNShape(path: path, extrusionDepth: 25)
            foregroundMaterial = SCNMaterial()
            foregroundMaterial.diffuse.contents = color
            foregroundShape.materials = [foregroundMaterial]
            foregroundNode = SCNNode(geometry: foregroundShape)
            foregroundNode.position = SCNVector3(0, 40, 70)
            foregroundNode.eulerAngles = SCNVector3(-0.50, Float(Double.pi), Float(Double.pi))
            foregroundNode.name = "MINERALES"
            scene.rootNode.addChildNode(foregroundNode)
            
            
            color = UIColor(red: 86 / 255, green: 188/255, blue: 188/255, alpha: 1)
            path = UIBezierPath()
            path.move(to: CGPoint(x: 0.83297*width, y: 0.75397*height))
            path.addLine(to: CGPoint(x: 0.74575*width, y: 0.79817*height))
            path.addCurve(to: CGPoint(x: 0.713*width, y: 0.80972*height), controlPoint1: CGPoint(x: 0.74026*width, y: 0.80658*height), controlPoint2: CGPoint(x: 0.72371*width, y: 0.81197*height))
            path.addLine(to: CGPoint(x: 0.65681*width, y: 0.80972*height))
            path.addLine(to: CGPoint(x: 0.68513*width, y: 0.91604*height))
            path.addLine(to: CGPoint(x: 0.75419*width, y: 0.91478*height))
            path.addCurve(to: CGPoint(x: 0.78088*width, y: 0.89218*height), controlPoint1: CGPoint(x: 0.76407*width, y: 0.91347*height), controlPoint2: CGPoint(x: 0.7778*width, y: 0.90278*height))
            path.addLine(to: CGPoint(x: 0.8242*width, y: 0.80333*height))
            path.addLine(to: CGPoint(x: 0.82075*width, y: 0.78293*height))
            path.addLine(to: CGPoint(x: 0.83297*width, y: 0.75397*height))
            foregroundShape = SCNShape(path: path, extrusionDepth: 25)
            foregroundMaterial = SCNMaterial()
            foregroundMaterial.diffuse.contents = color
            foregroundShape.materials = [foregroundMaterial]
            foregroundNode = SCNNode(geometry: foregroundShape)
            foregroundNode.position = SCNVector3(0, 20, 40)
            foregroundNode.eulerAngles = SCNVector3(-0.50, Float(Double.pi), Float(Double.pi))
            foregroundNode.name = "PEQUEÑOS 2"
            scene.rootNode.addChildNode(foregroundNode)
            
            
            textGeometry = SCNText(string: "PEQUEÑOS", extrusionDepth: 0)
            textGeometry.font = UIFont.boldSystemFont(ofSize: 11)
            textGeometry.firstMaterial?.diffuse.contents = UIColor.black
            textNode = SCNNode(geometry: textGeometry)
            textNode.position = SCNVector3(660, -690, 500)
            textNode.eulerAngles = SCNVector3(0, 0, 0)
            textNode.name = "PEQUEÑOS"
            scene.rootNode.addChildNode(textNode)
            
    
            
            
            color = UIColor(red: 0/255, green: 117/255, blue: 135/255, alpha: 1)
            path = UIBezierPath()
            path.move(to: CGPoint(x: 0.69223*width, y: 0.91329*height))
            path.addLine(to: CGPoint(x: 0.7265*width, y: 0.91322*height))
            path.addLine(to: CGPoint(x: 0.72638*width, y: 0.87948*height))
            path.addLine(to: CGPoint(x: 0.72063*width, y: 0.87968*height))
            path.addLine(to: CGPoint(x: 0.7207*width, y: 0.8855*height))
            path.addLine(to: CGPoint(x: 0.69857*width, y: 0.8855*height))
            path.addLine(to: CGPoint(x: 0.6985*width, y: 0.87995*height))
            path.addLine(to: CGPoint(x: 0.69254*width, y: 0.88002*height))
            path.addLine(to: CGPoint(x: 0.69223*width, y: 0.91329*height))
            foregroundShape = SCNShape(path: path, extrusionDepth: 25)
            foregroundMaterial = SCNMaterial()
            foregroundMaterial.diffuse.contents = color
            foregroundShape.materials = [foregroundMaterial]
            foregroundNode = SCNNode(geometry: foregroundShape)
            foregroundNode.position = SCNVector3(0, 40, 70)
            foregroundNode.eulerAngles = SCNVector3(-0.50, Float(Double.pi), Float(Double.pi))
            foregroundNode.name = "INVERNADERO"
            scene.rootNode.addChildNode(foregroundNode)
            
            
            path = UIBezierPath()
            path.move(to: CGPoint(x: 0.69857*width, y: 0.8504*height))
            path.addLine(to: CGPoint(x: 0.70455*width, y: 0.8486*height))
            path.addCurve(to: CGPoint(x: 0.70761*width, y: 0.84654*height), controlPoint1: CGPoint(x: 0.70412*width, y: 0.84639*height), controlPoint2: CGPoint(x: 0.70514*width, y: 0.84471*height))
            path.addLine(to: CGPoint(x: 0.71168*width, y: 0.8496*height))
            path.addLine(to: CGPoint(x: 0.70741*width, y: 0.85614*height))
            path.addCurve(to: CGPoint(x: 0.70455*width, y: 0.85614*height), controlPoint1: CGPoint(x: 0.70612*width, y: 0.85861*height), controlPoint2: CGPoint(x: 0.70488*width, y: 0.8579*height))
            path.addLine(to: CGPoint(x: 0.70455*width, y: 0.85467*height))
            path.addLine(to: CGPoint(x: 0.6985*width, y: 0.85614*height))
            path.addQuadCurve(to: CGPoint(x: 0.6985*width, y: 0.8594*height), controlPoint: CGPoint(x: 0.6985*width, y: 0.85934*height))
            path.addQuadCurve(to: CGPoint(x: 0.70936*width, y: 0.85954*height), controlPoint: CGPoint(x: 0.6985*width, y: 0.85947*height))
            path.addLine(to: CGPoint(x: 0.70936*width, y: 0.8576*height))
            path.addLine(to: CGPoint(x: 0.71668*width, y: 0.8576*height))
            path.addLine(to: CGPoint(x: 0.71648*width, y: 0.861*height))
            path.addLine(to: CGPoint(x: 0.71475*width, y: 0.86114*height))
            path.addLine(to: CGPoint(x: 0.71475*width, y: 0.86674*height))
            path.addLine(to: CGPoint(x: 0.6985*width, y: 0.86674*height))
            path.addLine(to: CGPoint(x: 0.69223*width, y: 0.86674*height))
            path.addCurve(to: CGPoint(x: 0.68988*width, y: 0.86327*height), controlPoint1: CGPoint(x: 0.69124*width, y: 0.8662*height), controlPoint2: CGPoint(x: 0.69007*width, y: 0.86446*height))
            path.addLine(to: CGPoint(x: 0.69008*width, y: 0.8522*height))
            path.addCurve(to: CGPoint(x: 0.69408*width, y: 0.8486*height), controlPoint1: CGPoint(x: 0.6902*width, y: 0.85065*height), controlPoint2: CGPoint(x: 0.69219*width, y: 0.84884*height))
            path.addLine(to: CGPoint(x: 0.6985*width, y: 0.8486*height))
            path.addLine(to: CGPoint(x: 0.69857*width, y: 0.8504*height))
            foregroundShape = SCNShape(path: path, extrusionDepth: 25)
            foregroundMaterial = SCNMaterial()
            foregroundMaterial.diffuse.contents = color
            foregroundShape.materials = [foregroundMaterial]
            foregroundNode = SCNNode(geometry: foregroundShape)
            foregroundNode.position = SCNVector3(0, 40, 70)
            foregroundNode.eulerAngles = SCNVector3(-0.50, Float(Double.pi), Float(Double.pi))
            foregroundNode.name = "PUENTE"
            scene.rootNode.addChildNode(foregroundNode)
            
            
            path = UIBezierPath()
            path.move(to: CGPoint(x: 0.74069*width, y: 0.84048*height))
            path.addCurve(to: CGPoint(x: 0.74989*width, y: 0.83548*height), controlPoint1: CGPoint(x: 0.74183*width, y: 0.83748*height), controlPoint2: CGPoint(x: 0.74631*width, y: 0.83482*height))
            path.addCurve(to: CGPoint(x: 0.75596*width, y: 0.83974*height), controlPoint1: CGPoint(x: 0.75188*width, y: 0.83622*height), controlPoint2: CGPoint(x: 0.75501*width, y: 0.83786*height))
            path.addCurve(to: CGPoint(x: 0.75596*width, y: 0.84654*height), controlPoint1: CGPoint(x: 0.7566*width, y: 0.84082*height), controlPoint2: CGPoint(x: 0.75695*width, y: 0.84374*height))
            path.addLine(to: CGPoint(x: 0.75769*width, y: 0.84714*height))
            path.addLine(to: CGPoint(x: 0.75029*width, y: 0.85261*height))
            path.addLine(to: CGPoint(x: 0.75002*width, y: 0.85094*height))
            path.addCurve(to: CGPoint(x: 0.74236*width, y: 0.84821*height), controlPoint1: CGPoint(x: 0.74695*width, y: 0.85212*height), controlPoint2: CGPoint(x: 0.74386*width, y: 0.84997*height))
            path.addCurve(to: CGPoint(x: 0.74069*width, y: 0.84048*height), controlPoint1: CGPoint(x: 0.74084*width, y: 0.84664*height), controlPoint2: CGPoint(x: 0.73925*width, y: 0.84336*height))
            foregroundShape = SCNShape(path: path, extrusionDepth: 25)
            foregroundMaterial = SCNMaterial()
            foregroundMaterial.diffuse.contents = color
            foregroundShape.materials = [foregroundMaterial]
            foregroundNode = SCNNode(geometry: foregroundShape)
            foregroundNode.position = SCNVector3(0, 40, 70)
            foregroundNode.eulerAngles = SCNVector3(-0.50, Float(Double.pi), Float(Double.pi))
            foregroundNode.name = "FLORES"
            scene.rootNode.addChildNode(foregroundNode)
            
            
            path = UIBezierPath()
            path.move(to: CGPoint(x: 0.74013*width, y: 0.88581*height))
            path.addLine(to: CGPoint(x: 0.74936*width, y: 0.88567*height))
            path.addLine(to: CGPoint(x: 0.74936*width, y: 0.89154*height))
            path.addLine(to: CGPoint(x: 0.75496*width, y: 0.89167*height))
            path.addLine(to: CGPoint(x: 0.75496*width, y: 0.90981*height))
            path.addLine(to: CGPoint(x: 0.75136*width, y: 0.90974*height))
            path.addLine(to: CGPoint(x: 0.73842*width, y: 0.90981*height))
            path.addLine(to: CGPoint(x: 0.73829*width, y: 0.89167*height))
            path.addLine(to: CGPoint(x: 0.74013*width, y: 0.89167*height))
            path.addQuadCurve(to: CGPoint(x: 0.74013*width, y: 0.88581*height), controlPoint: CGPoint(x: 0.74013*width, y: 0.88594*height))
            foregroundShape = SCNShape(path: path, extrusionDepth: 25)
            foregroundMaterial = SCNMaterial()
            foregroundMaterial.diffuse.contents = color
            foregroundShape.materials = [foregroundMaterial]
            foregroundNode = SCNNode(geometry: foregroundShape)
            foregroundNode.position = SCNVector3(0, 40, 70)
            foregroundNode.eulerAngles = SCNVector3(-0.50, Float(Double.pi), Float(Double.pi))
            foregroundNode.name = "CASITA"
            scene.rootNode.addChildNode(foregroundNode)
            
            
            
            path.move(to: CGPoint(x: 0.79615*width, y: 0.83054*height))
            path.addLine(to: CGPoint(x: 0.78235*width, y: 0.85761*height))
            path.addLine(to: CGPoint(x: 0.79389*width, y: 0.86307*height))
            path.addLine(to: CGPoint(x: 0.80749*width, y: 0.83501*height))
            path.addLine(to: CGPoint(x: 0.79615*width, y: 0.83054*height))
            foregroundShape = SCNShape(path: path, extrusionDepth: 25)
            foregroundMaterial = SCNMaterial()
            foregroundMaterial.diffuse.contents = color
            foregroundShape.materials = [foregroundMaterial]
            foregroundNode = SCNNode(geometry: foregroundShape)
            foregroundNode.position = SCNVector3(0, 40, 70)
            foregroundNode.eulerAngles = SCNVector3(-0.50, Float(Double.pi), Float(Double.pi))
            foregroundNode.name = "TRONCO"
            scene.rootNode.addChildNode(foregroundNode)
            
            
            path = UIBezierPath()
            path.move(to: CGPoint(x: 0.79786*width, y: 0.80178*height))
            path.addCurve(to: CGPoint(x: 0.81172*width, y: 0.80051*height), controlPoint1: CGPoint(x: 0.80111*width, y: 0.79878*height), controlPoint2: CGPoint(x: 0.80799*width, y: 0.7978*height))
            path.addCurve(to: CGPoint(x: 0.81619*width, y: 0.81071*height), controlPoint1: CGPoint(x: 0.81373*width, y: 0.80171*height), controlPoint2: CGPoint(x: 0.81651*width, y: 0.80513*height))
            path.addCurve(to: CGPoint(x: 0.81159*width, y: 0.81818*height), controlPoint1: CGPoint(x: 0.81621*width, y: 0.81297*height), controlPoint2: CGPoint(x: 0.81406*width, y: 0.81674*height))
            path.addCurve(to: CGPoint(x: 0.80166*width, y: 0.81951*height), controlPoint1: CGPoint(x: 0.80901*width, y: 0.81991*height), controlPoint2: CGPoint(x: 0.80404*width, y: 0.82073*height))
            path.addCurve(to: CGPoint(x: 0.79526*width, y: 0.81291*height), controlPoint1: CGPoint(x: 0.79892*width, y: 0.81872*height), controlPoint2: CGPoint(x: 0.79587*width, y: 0.81533*height))
            path.addCurve(to: CGPoint(x: 0.79786*width, y: 0.80178*height), controlPoint1: CGPoint(x: 0.7941*width, y: 0.80936*height), controlPoint2: CGPoint(x: 0.7953*width, y: 0.80376*height))
            foregroundShape = SCNShape(path: path, extrusionDepth: 25)
            foregroundMaterial = SCNMaterial()
            foregroundMaterial.diffuse.contents = color
            foregroundShape.materials = [foregroundMaterial]
            foregroundNode = SCNNode(geometry: foregroundShape)
            foregroundNode.position = SCNVector3(0, 40, 70)
            foregroundNode.eulerAngles = SCNVector3(-0.50, Float(Double.pi), Float(Double.pi))
            foregroundNode.name = "SUBMARINO"
            scene.rootNode.addChildNode(foregroundNode)
                    
            
            
            color = UIColor(red: 56 / 255, green: 99 / 255, blue: 158 / 255, alpha: 1)
            path = UIBezierPath()
            path.move(to: CGPoint(x: 0.36505*width, y: 0.63968*height))
            path.addLine(to: CGPoint(x: 0.48337*width, y: 0.63667*height))
            path.addCurve(to: CGPoint(x: 0.48963*width, y: 0.66499*height), controlPoint1: CGPoint(x: 0.48022*width, y: 0.65191*height), controlPoint2: CGPoint(x: 0.48568*width, y: 0.66045*height))
            path.addLine(to: CGPoint(x: 0.61151*width, y: 0.80021*height))
            path.addCurve(to: CGPoint(x: 0.63276*width, y: 0.80972*height), controlPoint1: CGPoint(x: 0.61556*width, y: 0.80538*height), controlPoint2: CGPoint(x: 0.62627*width, y: 0.80989*height))
            path.addLine(to: CGPoint(x: 0.65681*width, y: 0.80972*height))
            path.addLine(to: CGPoint(x: 0.68513*width, y: 0.91478*height))
            path.addLine(to: CGPoint(x: 0.57616*width, y: 0.91478*height))
            path.addCurve(to: CGPoint(x: 0.55113*width, y: 0.90077*height), controlPoint1: CGPoint(x: 0.56912*width, y: 0.91514*height), controlPoint2: CGPoint(x: 0.55656*width, y: 0.90922*height))
            path.addLine(to: CGPoint(x: 0.36505*width, y: 0.63968*height))
            foregroundShape = SCNShape(path: path, extrusionDepth: 25)
            foregroundMaterial = SCNMaterial()
            foregroundMaterial.diffuse.contents = color
            foregroundShape.materials = [foregroundMaterial]
            foregroundNode = SCNNode(geometry: foregroundShape)
            foregroundNode.position = SCNVector3(0, 20, 40)
            foregroundNode.eulerAngles = SCNVector3(-0.50, Float(Double.pi), Float(Double.pi))
            foregroundNode.name = "COMUNICO"
            scene.rootNode.addChildNode(foregroundNode)
            
            textGeometry = SCNText(string: "COMUNICO", extrusionDepth: 0)
            textGeometry.font = UIFont.boldSystemFont(ofSize: 11)
            textGeometry.firstMaterial?.diffuse.contents = UIColor.black
            textNode = SCNNode(geometry: textGeometry)
            textNode.position = SCNVector3(515, -600, 500)
            textNode.eulerAngles = SCNVector3(0, 0, -0.8)
            textNode.name = "COMUNICO"
            scene.rootNode.addChildNode(textNode)
            
            color = UIColor(red: 34 / 255, green: 59 / 255, blue: 94 / 255, alpha: 1)
            path = UIBezierPath()
            path.move(to: CGPoint(x: 0.44304*width, y: 0.7468*height))
            path.addLine(to: CGPoint(x: 0.48198*width, y: 0.71961*height))
            path.addLine(to: CGPoint(x: 0.46721*width, y: 0.70234*height))
            path.addQuadCurve(to: CGPoint(x: 0.45581*width, y: 0.71156*height), controlPoint: CGPoint(x: 0.45587*width, y: 0.71164*height))
            path.addCurve(to: CGPoint(x: 0.44857*width, y: 0.68609*height), controlPoint1: CGPoint(x: 0.45107*width, y: 0.70509*height), controlPoint2: CGPoint(x: 0.45007*width, y: 0.69854*height))
            path.addLine(to: CGPoint(x: 0.43502*width, y: 0.66935*height))
            path.addCurve(to: CGPoint(x: 0.41798*width, y: 0.66809*height), controlPoint1: CGPoint(x: 0.43056*width, y: 0.66475*height), controlPoint2: CGPoint(x: 0.42209*width, y: 0.66463*height))
            path.addLine(to: CGPoint(x: 0.40174*width, y: 0.67976*height))
            path.addCurve(to: CGPoint(x: 0.40184*width, y: 0.68602*height), controlPoint1: CGPoint(x: 0.40035*width, y: 0.68127*height), controlPoint2: CGPoint(x: 0.40014*width, y: 0.68438*height))
            path.addLine(to: CGPoint(x: 0.40038*width, y: 0.68749*height))
            path.addLine(to: CGPoint(x: 0.44304*width, y: 0.7468*height))
            foregroundShape = SCNShape(path: path, extrusionDepth: 25)
            foregroundMaterial = SCNMaterial()
            foregroundMaterial.diffuse.contents = color
            foregroundShape.materials = [foregroundMaterial]
            foregroundNode = SCNNode(geometry: foregroundShape)
            foregroundNode.position = SCNVector3(0, 40, 70)
            foregroundNode.eulerAngles = SCNVector3(-0.50, Float(Double.pi), Float(Double.pi))
            foregroundNode.name = "TELEPRESENCIA"
            scene.rootNode.addChildNode(foregroundNode)
            
            path = UIBezierPath()
            path.move(to: CGPoint(x: 0.48926*width, y: 0.81148*height))
            path.addLine(to: CGPoint(x: 0.53207*width, y: 0.7809*height))
            path.addQuadCurve(to: CGPoint(x: 0.52681*width, y: 0.77278*height), controlPoint: CGPoint(x: 0.52683*width, y: 0.77284*height))
            path.addCurve(to: CGPoint(x: 0.51754*width, y: 0.76491*height), controlPoint1: CGPoint(x: 0.52543*width, y: 0.76935*height), controlPoint2: CGPoint(x: 0.52209*width, y: 0.76612*height))
            path.addCurve(to: CGPoint(x: 0.49531*width, y: 0.75223*height), controlPoint1: CGPoint(x: 0.50948*width, y: 0.76288*height), controlPoint2: CGPoint(x: 0.49761*width, y: 0.75723*height))
            path.addLine(to: CGPoint(x: 0.50334*width, y: 0.74506*height))
            path.addLine(to: CGPoint(x: 0.48344*width, y: 0.72169*height))
            path.addLine(to: CGPoint(x: 0.44455*width, y: 0.74939*height))
            path.addLine(to: CGPoint(x: 0.48926*width, y: 0.81148*height))
            foregroundShape = SCNShape(path: path, extrusionDepth: 25)
            foregroundMaterial = SCNMaterial()
            foregroundMaterial.diffuse.contents = color
            foregroundShape.materials = [foregroundMaterial]
            foregroundNode = SCNNode(geometry: foregroundShape)
            foregroundNode.position = SCNVector3(0, 40, 70)
            foregroundNode.eulerAngles = SCNVector3(-0.50, Float(Double.pi), Float(Double.pi))
            foregroundNode.name = "RADIO"
            scene.rootNode.addChildNode(foregroundNode)
            
            
            path = UIBezierPath()
            path.move(to: CGPoint(x: 0.53404*width, y: 0.78519*height))
            path.addLine(to: CGPoint(x: 0.4912*width, y: 0.81426*height))
            path.addLine(to: CGPoint(x: 0.54358*width, y: 0.88827*height))
            path.addLine(to: CGPoint(x: 0.54538*width, y: 0.88633*height))
            path.addCurve(to: CGPoint(x: 0.54983*width, y: 0.88721*height), controlPoint1: CGPoint(x: 0.54649*width, y: 0.88738*height), controlPoint2: CGPoint(x: 0.54868*width, y: 0.88806*height))
            path.addLine(to: CGPoint(x: 0.57197*width, y: 0.87756*height))
            path.addCurve(to: CGPoint(x: 0.57941*width, y: 0.86803*height), controlPoint1: CGPoint(x: 0.5748*width, y: 0.87591*height), controlPoint2: CGPoint(x: 0.57852*width, y: 0.87114*height))
            path.addCurve(to: CGPoint(x: 0.57782*width, y: 0.85506*height), controlPoint1: CGPoint(x: 0.58001*width, y: 0.86453*height), controlPoint2: CGPoint(x: 0.58065*width, y: 0.859*height))
            path.addLine(to: CGPoint(x: 0.5556*width, y: 0.82*height))
            path.addLine(to: CGPoint(x: 0.546*width, y: 0.8256*height))
            path.addCurve(to: CGPoint(x: 0.54346*width, y: 0.8027*height), controlPoint1: CGPoint(x: 0.54342*width, y: 0.82168*height), controlPoint2: CGPoint(x: 0.54326*width, y: 0.81012*height))
            path.addCurve(to: CGPoint(x: 0.53902*width, y: 0.79188*height), controlPoint1: CGPoint(x: 0.54342*width, y: 0.79968*height), controlPoint2: CGPoint(x: 0.5411*width, y: 0.7943*height))
            path.addLine(to: CGPoint(x: 0.53404*width, y: 0.78519*height))
            foregroundShape = SCNShape(path: path, extrusionDepth: 25)
            foregroundMaterial = SCNMaterial()
            foregroundMaterial.diffuse.contents = color
            foregroundShape.materials = [foregroundMaterial]
            foregroundNode = SCNNode(geometry: foregroundShape)
            foregroundNode.position = SCNVector3(0, 40, 70)
            foregroundNode.eulerAngles = SCNVector3(-0.50, Float(Double.pi), Float(Double.pi))
            foregroundNode.name = "TELEVISIÓN"
            scene.rootNode.addChildNode(foregroundNode)
            
            
            path = UIBezierPath()
            path.move(to: CGPoint(x: 0.61221*width, y: 0.91461*height))
            path.addLine(to: CGPoint(x: 0.61221*width, y: 0.91168*height))
            path.addCurve(to: CGPoint(x: 0.60328*width, y: 0.90455*height), controlPoint1: CGPoint(x: 0.60705*width, y: 0.91197*height), controlPoint2: CGPoint(x: 0.60151*width, y: 0.90933*height))
            path.addLine(to: CGPoint(x: 0.62252*width, y: 0.85243*height))
            path.addCurve(to: CGPoint(x: 0.6477*width, y: 0.8425*height), controlPoint1: CGPoint(x: 0.62533*width, y: 0.844*height), controlPoint2: CGPoint(x: 0.63817*width, y: 0.83949*height))
            path.addLine(to: CGPoint(x: 0.64779*width, y: 0.85399*height))
            path.addCurve(to: CGPoint(x: 0.66647*width, y: 0.86058*height), controlPoint1: CGPoint(x: 0.65401*width, y: 0.85293*height), controlPoint2: CGPoint(x: 0.6637*width, y: 0.8552*height))
            path.addLine(to: CGPoint(x: 0.67339*width, y: 0.87151*height))
            path.addLine(to: CGPoint(x: 0.68512*width, y: 0.91473*height))
            path.addLine(to: CGPoint(x: 0.61221*width, y: 0.91461*height))
            foregroundShape = SCNShape(path: path, extrusionDepth: 25)
            foregroundMaterial = SCNMaterial()
            foregroundMaterial.diffuse.contents = color
            foregroundShape.materials = [foregroundMaterial]
            foregroundNode = SCNNode(geometry: foregroundShape)
            foregroundNode.position = SCNVector3(0, 40, 70)
            foregroundNode.eulerAngles = SCNVector3(-0.50, Float(Double.pi), Float(Double.pi))
            foregroundNode.name = "REDES"
            scene.rootNode.addChildNode(foregroundNode)
                    
                    
            
            
            color = UIColor(red: 203 / 255, green: 226 / 255, blue: 187 / 255, alpha: 1)
            path = UIBezierPath()
            path.move(to: CGPoint(x: 0.08717*width, y: 0.46009*height))
            path.addLine(to: CGPoint(x: 0.14668*width, y: 0.45894*height))
            path.addLine(to: CGPoint(x: 0.16813*width, y: 0.41857*height))
            path.addLine(to: CGPoint(x: 0.25925*width, y: 0.41834*height))
            path.addCurve(to: CGPoint(x: 0.26225*width, y: 0.42364*height), controlPoint1: CGPoint(x: 0.26103*width, y: 0.4204*height), controlPoint2: CGPoint(x: 0.26176*width, y: 0.42056*height))
            path.addQuadCurve(to: CGPoint(x: 0.26225*width, y: 0.51175*height), controlPoint: CGPoint(x: 0.26228*width, y: 0.42387*height))
            path.addLine(to: CGPoint(x: 0.08717*width, y: 0.51175*height))
            path.addLine(to: CGPoint(x: 0.08717*width, y: 0.46009*height))
            foregroundShape = SCNShape(path: path, extrusionDepth: 25)
            foregroundMaterial = SCNMaterial()
            foregroundMaterial.diffuse.contents = color
            foregroundShape.materials = [foregroundMaterial]
            foregroundNode = SCNNode(geometry: foregroundShape)
            foregroundNode.position = SCNVector3(0, 20, 40)
            foregroundNode.eulerAngles = SCNVector3(-0.50, Float(Double.pi), Float(Double.pi))
            foregroundNode.name = "TIENDA"
            scene.rootNode.addChildNode(foregroundNode)
            
            textGeometry = SCNText(string: "TIENDA", extrusionDepth: 0)
            textGeometry.font = UIFont.boldSystemFont(ofSize: 11)
            textGeometry.firstMaterial?.diffuse.contents = UIColor.black
            textNode = SCNNode(geometry: textGeometry)
            textNode.position = SCNVector3(225, -405, 500)
            textNode.eulerAngles = SCNVector3(0, 0, 0)
            textNode.name = "TIENDA"
            scene.rootNode.addChildNode(textNode)
            
            
            path = UIBezierPath()
            path.move(to: CGPoint(x: 0.33195*width, y: 0.24344*height))
            path.addLine(to: CGPoint(x: 0.60365*width, y: 0.13784*height))
            path.addLine(to: CGPoint(x: 0.6043*width, y: 0.34909*height))
            path.addLine(to: CGPoint(x: 0.56475*width, y: 0.35069*height))
            path.addLine(to: CGPoint(x: 0.49556*width, y: 0.36779*height))
            path.addLine(to: CGPoint(x: 0.44643*width, y: 0.37985*height))
            path.addLine(to: CGPoint(x: 0.4332*width, y: 0.38329*height))
            path.addLine(to: CGPoint(x: 0.33195*width, y: 0.24344*height))
            foregroundShape = SCNShape(path: path, extrusionDepth: 25)
            foregroundMaterial = SCNMaterial()
            foregroundMaterial.diffuse.contents = color
            foregroundShape.materials = [foregroundMaterial]
            foregroundNode = SCNNode(geometry: foregroundShape)
            foregroundNode.position = SCNVector3(0, 20, 40)
            foregroundNode.eulerAngles = SCNVector3(-0.50, Float(Double.pi), Float(Double.pi))
            foregroundNode.name = "EXPOSICIONES TEMPORALES"
            scene.rootNode.addChildNode(foregroundNode)
            
            textGeometry = SCNText(string: "EXPOSICIONES TEMPORALES", extrusionDepth: 0)
            textGeometry.font = UIFont.boldSystemFont(ofSize: 11)
            textGeometry.firstMaterial?.diffuse.contents = UIColor.black
            textNode = SCNNode(geometry: textGeometry)
            textNode.position = SCNVector3(422, -290, 500)
            textNode.eulerAngles = SCNVector3(0, 0, 0.3)
            textNode.name = "EXPOSICIONES TEMPORALES"
            scene.rootNode.addChildNode(textNode)
                    
        }
        
    }
}


#Preview {
    Map(focused: "Planta alta")
}
