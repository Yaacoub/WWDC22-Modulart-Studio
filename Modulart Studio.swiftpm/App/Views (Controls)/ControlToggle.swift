import SwiftUI

struct ControlToggle: View {
    
    
    
    //MARK: - Properties
    
    private let systemImage: String
    private let title: String
    
    @Binding private(set) var value: Bool
    
    
    
    //MARK: - Init
    
    init(_ title: String, systemImage: String, value: Binding<Bool>) {
        self.systemImage = systemImage
        self.title = title
        self._value = value
    }
    
    
    
    //MARK: - Body
    
    var body: some View {
        HStack {
            Toggle(isOn: $value) {
                Label(title, systemImage: systemImage)
                    .multilineTextAlignment(.center)
            }
            .tint(.textSecondary)
            Spacer()
            Text(value == true ? "On" : "Off")
                .foregroundColor(.textSecondary)
                .frame(minWidth: 60)
        }
    }
    
}
