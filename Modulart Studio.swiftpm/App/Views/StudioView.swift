import SwiftUI

struct StudioView: View {
    
    
    
    //MARK: - Properties
    
    @ObservedObject private var document = Document.current
    @State private var isShowingLayoutPanel = false
    @State private var isShowingPropertiesPanel = true
    
    
    
    //MARK: - Init
    
    init() {
        UINavigationBar.appearance().tintColor = UIColor(.text)
    }
    
    
    
    //MARK: - Body
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.background
                    .ignoresSafeArea()
                VStack {
                    Spacer()
                    UnitCircle(animationDuration: 2)
                        .frame(maxWidth: 400, maxHeight: 400)
                        .padding()
                    if isShowingLayoutPanel {
                        Spacer()
                        PanelLayout()
                            .padding()
                            .transition(.move(edge: .bottom).combined(with: .opacity))
                    } else if isShowingPropertiesPanel {
                        Spacer()
                        PanelProperties()
                            .padding()
                            .transition(.move(edge: .bottom).combined(with: .opacity))
                    }
                    Spacer()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Studio")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    NavigationLink(destination: LibraryView()) {
                        Label("Library", systemImage: "square.stack")
                    }
                    NavigationLink(destination: InfoView()) {
                        Label("Info", systemImage: "info.circle")
                    }
                }
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Toggle(isOn: $isShowingPropertiesPanel.animation()) {
                        Label("Toggle Properties Panel", systemImage: "slider.horizontal.3")
                    }
                    .onChange(of: isShowingPropertiesPanel) { newValue in
                        withAnimation {
                            isShowingLayoutPanel = newValue ? false : isShowingLayoutPanel
                        }
                    }
                    Toggle(isOn: $isShowingLayoutPanel.animation()) {
                        Label("Toggle Layout Panel", systemImage: "scribble.variable")
                    }
                    .onChange(of: isShowingLayoutPanel) { newValue in
                        withAnimation {
                            isShowingPropertiesPanel = newValue ? false : isShowingPropertiesPanel
                        }
                    }
                    NavigationLink(destination: ExportView()) {
                        Label("Share", systemImage: "square.and.arrow.up")
                    }
                    .padding(.leading)
                }
            }
        }
        .environmentObject(document)
        .foregroundColor(.text)
        .navigationViewStyle(.stack)
        .tint(.text)
    }
    
}
