import SwiftUI

struct PanelProperties: View {
    
    
    
    //MARK: - Properties
    
    @EnvironmentObject private var document: Document
    
    
    
    //MARK: - Body
    
    var body: some View {
        VStack {
            Text("Properties")
                .font(.headline)
            Text("_`\(document.properties.multiplicationTable)A mod \(document.properties.dashes)`_ for all integer _`A`_ from _`0`_ to _`\(document.properties.dashes - 1)`_")
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .padding([.horizontal, .bottom])
            HStack {
                VStack {
                    ControlStepper("Multiplication Table", systemImage: "multiply.square", value: $document.properties.multiplicationTable, range: 1...100)
                    ControlStepper("Dashes (Modulus)", systemImage: "circle.dotted", value: $document.properties.dashes, range: 1...200)
                }
            }
        }
        .background(Color.background)
        .frame(maxWidth: 500)
        .padding()
    }
    
}
