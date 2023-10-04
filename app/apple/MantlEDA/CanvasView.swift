import Foundation
import SwiftUI
import OSLog
import Swia

#if os(macOS)
import AppKit
#elseif os(iOS)
import UIKit
#endif

#if os(macOS)
public struct SkCanvas: NSViewRepresentable {
    public typealias NSViewType = SkCanvasView
    public typealias Coordinator = CanvasCoordinator
    public var drawCallback: ((Swia.Canvas) -> Void)!
    private var update: Bool
    
    public init(_ drawCallback: @escaping ((Swia.Canvas) -> Void), _ update: Binding<Bool>) {
        self.drawCallback = drawCallback
        self.update = update.wrappedValue
    }
    
    public func makeNSView(context: NSViewRepresentableContext<SkCanvas>) -> SkCanvasView {
        let canvas = SkCanvasView()
        canvas.delegate = context.coordinator
        return canvas
    }
    
    public func updateNSView(_ nsView: SkCanvasView, context: Context) {
        os_log("Update View")
        nsView.setNeedsDisplay(nsView.bounds)
    }
    
    public func makeCoordinator() -> CanvasCoordinator {
        os_log("Creating Coordinator", type: .debug)
        defer {
            os_log("Created Coordinator", type: .debug)
        }
        return CanvasCoordinator(self)
    }
}

open class SkCanvasView: NSView {
    var delegate: SkCanvasViewDelegate!
    
    open override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        delegate.draw(canvasView: self)
    }
}
#endif

#if os(iOS)
public struct SkCanvas: UIViewRepresentable {
    public typealias UIViewType = SkCanvasView
    public typealias Coordinator = CanvasCoordinator
    public var drawCallback: ((Swia.Canvas) -> Void)!
    private var update: Bool

    public init(_ drawCallback: @escaping ((Swia.Canvas) -> Void), _ update: Binding<Bool>) {
        self.drawCallback = drawCallback
        self.update = update.wrappedValue
    }

    public func makeUIView(context: Context) -> SkCanvasView {
        let canvas = SkCanvasView()
        canvas.delegate = context.coordinator
        return canvas
    }

    public func updateUIView(_ uiView: UIViewType, context: Context) {
        os_log("Update View")
        uiView.setNeedsDisplay(uiView.bounds)
    }
    
    public func makeCoordinator() -> CanvasCoordinator {
        os_log("Creating Coordinator", type: .debug)
        defer {
            os_log("Created Coordinator", type: .debug)
        }
        return CanvasCoordinator(self)
    }
}

open class SkCanvasView: UIView {
    var delegate: SkCanvasViewDelegate!
    
    open override func draw(_ dirtyRect: CGRect) {
        super.draw(dirtyRect)
        delegate.draw(canvasView: self)
    }
}

#endif

public class CanvasCoordinator: SkCanvasViewDelegate {
    public var surface: Surface!
    public var parent: SkCanvas
    private var canvas: Swia.Canvas!
    
    init(_ parent: SkCanvas) {
        self.parent = parent
    }
    
    func draw(canvasView: SkCanvasView) {
        os_log("Drawing")
        let info = ImageInfo(
            width: Int32(canvasView.bounds.width),
            height: Int32(canvasView.bounds.height),
            colorType: .rgba8888,
            alphaType: .premultiplied)
        if self.canvas == nil || info.width != self.canvas.imageInfo.width || info.height != self.canvas.imageInfo.height {
            if let bitmapData = malloc(Int(info.bytesSize)) {
                self.canvas = Canvas.RasterDirect(info, bitmapData, Int(info.rowBytes))
            }
        }
        self.canvas.clear(color: ColorUInt(r: 255, g: 255, b: 255, a: 255))
        parent.drawCallback(self.canvas)
        
        guard let dataProvider = CGDataProvider(dataInfo: nil, data: self.canvas.pixels, size: Int(canvas.imageInfo.bytesSize), releaseData: {ctx, ptr, size in }) else {
            free(self.canvas.pixels)
            return
        }
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedFirst.rawValue).union(.byteOrder32Little)
        if let image = CGImage(
            width: Int(canvas.imageInfo.width),
            height: Int(canvas.imageInfo.height),
            bitsPerComponent: 8,
            bitsPerPixel: Int(canvas.imageInfo.bytesPerPixel * 8),
            bytesPerRow: Int(canvas.imageInfo.rowBytes),
            space: colorSpace,
            bitmapInfo: bitmapInfo,
            provider: dataProvider,
            decode: nil,
            shouldInterpolate: false,
            intent: .defaultIntent
        ) {
            #if os(macOS)
            if let ctx = NSGraphicsContext.current?.cgContext {
                ctx.draw(image, in: canvasView.bounds)
            }
            #elseif os(iOS)
            if let ctx = UIGraphicsGetCurrentContext() {
                ctx.saveGState()
                ctx.translateBy(x: 0, y: canvasView.bounds.height)
                ctx.scaleBy(x: 1, y: -1)
                ctx.draw(image, in: canvasView.bounds)
                ctx.restoreGState()
            }
            #endif
        }
    }
}

protocol SkCanvasViewDelegate {
    func draw(canvasView: SkCanvasView)
}
