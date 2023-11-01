import Foundation
import Swia
import OSLog

struct Point: Equatable {
    let x, y: Double
    
    static func -(lhs: Point, rhs: Point) -> Point {
        return Point(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }
    
    static func +(lhs: Point, rhs: Point) -> Point {
        return Point(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
    
    static func ==(lhs: Point, rhs: Point) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }
}

typealias Vector = Point

extension Vector {
    var magnitude: Double {
        return sqrt(pow(x, 2) + pow(y, 2))
    }
}

struct Segment {
    let start, end: Point
    var length: Double {
        get {
            let vec = end - start
            return vec.magnitude
        }
    }
}

struct Path {
    let start, end: Point
    let segments: [Segment]
    var closed: Bool {
        get { return start == end }
    }
    
    public init(start: Point) {
        self.init(start: start, end: start, segments: [])
    }
    
    public init(start: Point, end: Point, segments: [Segment]) {
        self.start = start
        self.end = end
        self.segments = segments
    }
    
    public func addPoint(point: Point) -> Path {
        var segments = self.segments
        segments.append(Segment(start: self.end, end: point))
        return Path(start: self.start, end: point, segments: segments)
    }
}

struct Grid {
    let division: Double
    let subdivision: Int
}

class SketchManager {
    var grid: Grid
    var paths: [Path]
    var currentPath: Path?
    
    public init() {
        grid = Grid(division: 20, subdivision: 0)
        paths = []
    }
    
    public func startPath(_ point: Point) {
        let translatedPoint = translatePointToGrid(point: point)
        if currentPath == nil {
            os_log("Created new path")
            currentPath = Path(start: translatedPoint)
            return
        }
        os_log("Appended new point")
        currentPath = currentPath!.addPoint(point: translatedPoint)
        if currentPath!.start == currentPath!.end && currentPath!.segments.count > 0 {
            os_log("Closed current path")
            paths.append(currentPath!)
            currentPath = nil
        }
    }
    
    public func endPath(_ point: Point) {
        if currentPath != nil {
            os_log("Closed current path")
            paths.append(currentPath!.addPoint(point: translatePointToGrid(point: point)))
            currentPath = nil
        }
    }
    
    public func draw(_ canvas: Canvas) {
        drawGrid(canvas)
        if paths.isEmpty && currentPath == nil {
            os_log("There are no points to draw")
            return
        }
        
        for path in paths {
            let rPath = SkPath.create()
            _ = rPath.moveTo(x: Float(path.start.x), y: Float(path.start.y))
            for segment in path.segments[...(path.segments.count - 1)] {
                _ = rPath.lineTo(x: Float(segment.end.x), y: Float(segment.end.y))
            }
            if path.closed {
                _ = rPath.close()
            } else {
                _ = rPath.lineTo(x: Float(path.end.x), y: Float(path.end.y))
            }
            canvas.drawPath(path: rPath, color: ColorUInt(r: 255, g: 0, b: 0, a: 255))
        }
        
        if currentPath != nil {
            let rPath = SkPath.create()
            _ = rPath.moveTo(x: Float(currentPath!.start.x), y: Float(currentPath!.start.y))
            for segment in currentPath!.segments {
                _ = rPath.lineTo(x: Float(segment.end.x), y: Float(segment.end.y))
            }
            canvas.drawPath(path: rPath, color: ColorUInt(r: 255, g: 0, b: 0, a: 255))
        }
    }
    
    private func createPoint(center: Point) -> SkPath {
        let path = SkPath.create()
            .addCircle(x: Float(center.x), y: Float(center.y), r: 1.7)
            .close()
        return path
    }

    private func drawGrid(_ canvas: Canvas) {
        for x in 0...Int(Double(canvas.imageInfo.width) / self.grid.division) {
            for y in 0...Int(Double(canvas.imageInfo.height) / self.grid.division) {
                canvas.drawFilledPath(path: createPoint(center: Point(x: Double(x) * self.grid.division, y: Double(y) * self.grid.division)), color: ColorUInt(r: 88, g: 88, b: 88, a: 255))
            }
        }
    }
    
    private func translatePointToGrid(point: Point) -> Point {
        return Point(x: round(point.x / grid.division) * grid.division, y: round(point.y / grid.division) * grid.division)
    }
}
