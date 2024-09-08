import SwiftUI

struct ControlStepper<V: CustomStringConvertible & Strideable>: View {
    
    
    
    //MARK: - Properties
    
    private let range: ClosedRange<V>
    private let step: V.Stride
    private let systemImage: String
    private let title: String
    private let unit: String
    
    @Binding private var value: V
    
    
    
    //MARK: - Init
    
    init(_ title: String, systemImage: String, value: Binding<V>, range: ClosedRange<V>, step: V.Stride = 1, unit: String? = nil) {
        self.range = range
        self.step = step
        self.systemImage = systemImage
        self.title = title
        self.unit = unit ?? ""
        self._value = value
    }
    
    
    
    //MARK: - Body
    
    var body: some View {
        HStack {
            Stepper(value: $value, in: range, step: step) {
                Label(title, systemImage: systemImage)
            }
            Spacer()
            Text(String(format: "%.0f", Double(String(describing: value)) ?? 0) + (!unit.isEmpty ? " \(unit)" : ""))
                .foregroundColor(.textSecondary)
                .frame(minWidth: 60)
        }
    }
    
}
