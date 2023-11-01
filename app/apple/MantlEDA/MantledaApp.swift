import SwiftUI

@main
struct MantlEDAApp: App {
    let sketchManager: SketchManager
    
    init() {
        self.sketchManager = SketchManager()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(sketchManager: sketchManager)
        }
    }
}
