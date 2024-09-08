import SwiftUI

struct LibraryView: View {
    
    
    
    //MARK: - Properties
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var document: Document
    private var items = [GridItem(.adaptive(minimum: 150, maximum: 150))]
    
    
    
    //MARK: - Body
    
    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()
            ScrollView {
                LazyVGrid(columns: items) {
                    Section(header: Text("Presets").font(.headline)) {
                        ForEach(Document.presets) { preset in
                            Button {
                                document.name = preset.name
                                document.properties = preset.properties
                                dismiss()
                            } label: {
                                VStack {
                                    Image(preset.thumbnailName)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 150)
                                    Text(preset.name)
                                        .multilineTextAlignment(.center)
                                        .frame(maxWidth: .infinity)
                                }
                            }
                        }
                    }
                    .padding()
                }
            }
        }
        .navigationTitle("Library")
    }
    
}
