import SwiftUI

@main
struct ModulartStudioApp: App {
    
    
    
    //MARK: - Body
    
    var body: some Scene {
        WindowGroup {
            StudioView()
                .preferredColorScheme(.dark)
                .statusBar(hidden: ProcessInfo.processInfo.isiOSAppOnMac)
                .onAppear {
                    AudioManager.startMusic(.main)
                }
        }
    }
    
}
