import SwiftUI
import OSLog
import Swia

struct ContentView: View {
    let sketchManager: SketchManager
    @State var update: Bool = false
    
    var tap: some Gesture {
        SimultaneousGesture(
            SpatialTapGesture(count: 1)
                .onEnded { event in
                    sketchManager.startPath(Point(x: Double(event.location.x), y: Double(event.location.y)))
                    update.toggle()
                },
            SpatialTapGesture(count: 2)
                .onEnded { event in
                    sketchManager.endPath(Point(x: Double(event.location.x), y: Double(event.location.y)))
                    update.toggle()
                }
        )
    }
    
    var body: some View {
        SkCanvas({ canvas in
            sketchManager.draw(canvas)
        }, $update)
        .gesture(tap)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(sketchManager: SketchManager())
    }
}
