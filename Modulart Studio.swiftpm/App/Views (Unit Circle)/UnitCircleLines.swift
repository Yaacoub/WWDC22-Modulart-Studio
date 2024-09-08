import SwiftUI

struct UnitCircleLines: View {
    
    
    
    //MARK: - Properties
    
    private let animationDuration: Double
    private let animationPercentage: Double
    private let colors: [Color]
    private let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    @EnvironmentObject private var document: Document
    @State private var drawingPercentage: Double
    @State private var skipAnimation = false
    
    
    
    //MARK: - Init
    
    init(animationDuration: Double, animationPercentage: Double, colors: [Color]) {
        self.animationDuration = animationDuration
        self.animationPercentage = animationPercentage
        self.colors = colors
        drawingPercentage = animationDuration != 0 ? 0 : animationPercentage
    }
    
    
    
    //MARK: - Body
    
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.background.opacity(.leastNonzeroMagnitude))
            ForEach(Array(0..<document.properties.dashes), id: \.self) { index in
                GeometryReader { geometry in
                    if skipAnimation {
                        path(at: index, geometry: geometry)
                            .trim(from: 0, to: animationPercentage)
                            .stroke(LinearGradient(colors: [colors[index], colors[index]], startPoint: .top, endPoint: .bottom),
                                    lineWidth: document.properties.lineWidth)
                    } else {
                        path(at: index, geometry: geometry)
                            .trim(from: 0, to: drawingPercentage)
                            .stroke(LinearGradient(colors: [colors[index], colors[index]], startPoint: .top, endPoint: .bottom),
                                    lineWidth: document.properties.lineWidth)
                    }
                }
            }
        }
        .onAppear { animateDrawing() }
        .onDisappear { drawingPercentage = 0 }
        .onTapGesture {
            drawingPercentage = 0
            animateDrawing()
        }
    }
    
    
    
    //MARK: - Methods
    
    private func animateDrawing() {
        skipAnimation = false
        guard animationDuration != 0 else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            withAnimation(.linear(duration: animationDuration)) {
                drawingPercentage = animationPercentage
            }
        }
    }
    
    private func path(at index: Int, geometry: GeometryProxy) -> Path {
        let remainder = (index * document.properties.multiplicationTable) % document.properties.dashes
        let angleStart: CGFloat = (-90 + document.properties.angleStart + 360 / Double(document.properties.dashes) * Double(index)) * .pi / 180
        let angleEnd: CGFloat = (-90 + document.properties.angleStart + 360 / Double(document.properties.dashes) * Double(remainder)) * .pi / 180
        let frame = geometry.frame(in: .local)
        let x1 = frame.midX + (min(geometry.size.width, geometry.size.height) / 2 * cos(angleStart))
        let x2 = frame.midX + (min(geometry.size.width, geometry.size.height) / 2 * cos(angleEnd))
        let y1 = frame.midY + (min(geometry.size.width, geometry.size.height) / 2 * sin(angleStart))
        let y2 = frame.midY + (min(geometry.size.width, geometry.size.height) / 2 * sin(angleEnd))
        return Path { path in
            path.move(to: CGPoint(x: x1, y: y1))
            path.addLine(to: CGPoint(x: x2, y: y2))
        }
    }
    
}
