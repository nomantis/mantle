import Foundation
import SwiftUI
import OSLog
import Swia

public struct SkCanvas: View {
    private let drawCallback: (Swia.Canvas) -> Void
    private var coordinator: CanvasCoordinator
    private var update: Bool
    
    init(_ drawCallback: @escaping (Swia.Canvas) -> Void, _ update: Binding<Bool>) {
        self.coordinator = CanvasCoordinator()
        self.drawCallback = drawCallback
        self.update = update.wrappedValue
    }
    
    public var body: some View {
        Canvas{ context, size in
            context.withCGContext { ctx in
                os_log("Drawing \(size.width) \(size.height)")
                let info = ImageInfo(
                    width: Int32(size.width),
                    height: Int32(size.height),
                    colorType: .rgba8888,
                    alphaType: .premultiplied)
                if self.coordinator.canvas == nil || info.width != self.coordinator.canvas!.imageInfo.width || info.height != self.coordinator.canvas!.imageInfo.height {
                    if let bitmapData = malloc(Int(info.bytesSize)) {
                        self.coordinator.canvas = Swia.Canvas.RasterDirect(info, bitmapData, Int(info.rowBytes))
                    }
                }
                self.coordinator.canvas!.clear(color: ColorUInt(r: 255, g: 255, b: 255, a: 255))
                self.drawCallback(self.coordinator.canvas!)
        
                guard self.coordinator.canvas != nil, let dataProvider = CGDataProvider(dataInfo: nil, data: self.coordinator.canvas!.pixels, size: Int(self.coordinator.canvas!.imageInfo.bytesSize), releaseData: {ctx, ptr, size in return}) else {
                    self.coordinator.canvas = nil
                    return
                }
        
                let colorSpace = CGColorSpaceCreateDeviceRGB()
                let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedFirst.rawValue).union(.byteOrder32Little)
                if let image = CGImage(
                    width: Int(self.coordinator.canvas!.imageInfo.width),
                    height: Int(self.coordinator.canvas!.imageInfo.height),
                    bitsPerComponent: 8,
                    bitsPerPixel: Int(self.coordinator.canvas!.imageInfo.bytesPerPixel * 8),
                    bytesPerRow: Int(self.coordinator.canvas!.imageInfo.rowBytes),
                    space: colorSpace,
                    bitmapInfo: bitmapInfo,
                    provider: dataProvider,
                    decode: nil,
                    shouldInterpolate: false,
                    intent: .defaultIntent
                ) {
                    ctx.saveGState()
                    ctx.translateBy(x: 0, y: size.height)
                    ctx.scaleBy(x: 1, y: -1)
                    ctx.draw(image, in: CGRect(origin: CGPoint(x: 0, y: 0), size: size))
                    ctx.restoreGState()
                }
            }
        }
    }
}

public class CanvasCoordinator {
    public var canvas: Swia.Canvas? = nil
}
