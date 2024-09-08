import SwiftUI

fileprivate extension UIView {
    
    func renderedImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: bounds.size)
        let image = renderer.image { context in
            layer.render(in: context.cgContext)
        }
        return image
    }
    
}

extension Color {
    
    static let background = Color("Colors/Background", bundle: nil)
    static let backgroundSecondary = Color("Colors/Background Secondary", bundle: nil)
    static let text = Color("Colors/Text", bundle: nil)
    static let textSecondary = Color("Colors/Text Secondary", bundle: nil)
    
    var components: (red: CGFloat, green: CGFloat, blue: CGFloat, opacity: CGFloat) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        guard UIColor(self).getRed(&red, green: &green, blue: &blue, alpha: &alpha) else { return (0, 0, 0, 0) }
        return (red, green, blue, alpha)
    }
    
    var luminance: Double {
        var red = Double(components.red)
        var green = Double(components.green)
        var blue = Double(components.blue)
        red = red <= 0.03928 ? red / 12.92 : pow((red + 0.055) / 1.055, 2.4)
        green = green <= 0.03928 ? green / 12.92 : pow((green + 0.055) / 1.055, 2.4)
        blue = blue <= 0.03928 ? blue / 12.92 : pow((blue + 0.055) / 1.055, 2.4)
        return 0.2126 * red + 0.7152 * green + 0.0722 * blue
    }
    
    func shaded(by percentage: Double) -> Color {
        let red = components.red * percentage
        let green = components.green * percentage
        let blue = components.blue * percentage
        return Color(red: red, green: green, blue: blue)
    }
    
    func tinted(by percentage: Double) -> Color {
        let red = components.red + (1 - components.red) * percentage
        let green = components.green + (1 - components.green) * percentage
        let blue = components.blue + (1 - components.blue) * percentage
        return Color(red: red, green: green, blue: blue)
    }
    
}

extension View {
    
    func renderedImage(for size: CGSize) -> UIImage {
        let view = self.frame(width: size.width, height: size.height, alignment: .center)
        let window = UIWindow(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let controller = UIHostingController(rootView: ZStack { view.offset(x: 0, y: ProcessInfo.processInfo.isiOSAppOnMac ? 0 : -10) })
        controller.view.backgroundColor = .clear
        controller.view.frame = window.frame
        window.addSubview(controller.view)
        window.makeKeyAndVisible()
        return controller.view.renderedImage()
    }
    
}
