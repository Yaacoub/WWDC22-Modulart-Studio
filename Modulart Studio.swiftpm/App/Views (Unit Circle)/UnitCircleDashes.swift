import SwiftUI

struct UnitCircleDashes: View {
    
    
    
    //MARK: - Properties
    
    @EnvironmentObject private var document: Document
    
    let colors: [Color]
    
    
    
    //MARK: - Body
    
    var body: some View {
        let fontSize = max(8, 16 * (1 + 200 - CGFloat(document.properties.dashes)) / 200)
        ForEach(Array(0..<document.properties.dashes), id: \.self) { index in
            VStack {
                if document.properties.showNumbers {
                    Text("\(index)")
                        .font(.system(size: fontSize))
                        .rotationEffect(.degrees(document.properties.angleStart > 180 ? 90 : -90))
                }
                Rectangle()
                    .foregroundColor(colors[index])
                    .frame(width: document.properties.dashSize / 2, height: document.properties.dashSize)
                Spacer()
            }
            .offset(y: document.properties.showNumbers ? -fontSize * 2 + (-2 + 3 * (fontSize - 8) / 8) : 0)
            .rotationEffect(.degrees(document.properties.angleStart + 360 / Double(document.properties.dashes) * Double(index)))
        }
    }
    
}
