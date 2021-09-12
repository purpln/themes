import UIKit

protocol ThemesProtocol {
    static func apply(_ theme: UIColor)
}

class Themes {
    static let shared = Themes()
    private init() { }
    
    //enum Theme: String { case blue, grey, purple, navy, azure, ocean }
    enum Style: String { case system, light, dark }
    enum Assets: String { case background, text, button }
    
    func applyTheme(_ theme: Theme) {
        UserDefaults.standard.set(theme.description, forKey: "theme")
        UserDefaults.standard.synchronize()
        UIApplication.shared.windows.reload()
    }
    
    func applyStyle(_ style: Style) {
        UserDefaults.standard.set(style.rawValue, forKey: "style")
        UserDefaults.standard.synchronize()
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
//        if #available(iOS 13.0, *) {
//            appDelegate.window?.overrideUserInterfaceStyle = interfaceStyle(style)
//            guard let sceneDelegate = UIApplication.shared.connectedScenes
//                    .first?.delegate as? SceneDelegate else { return }
//            sceneDelegate.window?.overrideUserInterfaceStyle = interfaceStyle(style)
//        }
    }
    
    @available(iOS 12.0, *)
    func interfaceStyle(_ style: Style?) -> UIUserInterfaceStyle {
        switch style {
        case .light: return .light
        case .dark: return .dark
        case .system: return .unspecified
        case .none: return .unspecified
        }
    }
    
    var currentTheme: Theme? {
        guard let theme = UserDefaults.standard.string(forKey: "theme") else { return nil }
        return theme.theme
    }
    
    var currentStyle: Style? {
        guard let style = UserDefaults.standard.string(forKey: "style") else { return nil }
        return Style(rawValue: style)
    }
    
    func configure() {
        reg(type: blue.self)
        if currentTheme == nil { applyTheme(blue()) }
        if currentStyle == nil { applyStyle(.light) }
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
//        if #available(iOS 13.0, *) {
//            appDelegate.window?.overrideUserInterfaceStyle = interfaceStyle(currentStyle)
//            guard let sceneDelegate = UIApplication.shared.connectedScenes
//                    .first?.delegate as? SceneDelegate else { return }
//            sceneDelegate.window?.overrideUserInterfaceStyle = interfaceStyle(currentStyle)
//        }
    }
}

extension UIColor {
    static func color(_ asset: Assets) -> UIColor? {
        guard let theme = UserDefaults.standard.string(forKey: "theme") else { return nil }
        return theme.theme?.asset(asset)
    }
}
enum Assets: String { case background, text, button }

protocol Theme {
    var description: String { get }
    var background: UIColor { get }
    init()
}

extension Theme {
    var description: String { "" }
    func asset(_ asset: Assets) -> UIColor? {
        switch asset {
        case .background: return background
        default: return nil
        }
    }
}

struct blue: Theme {
    var description: String { "blue" }
    var background: UIColor { .blue }
}

struct gray: Theme {
    var description: String { "gray" }
    var background: UIColor { .gray }
}

struct purple: Theme {
    var description: String { "purple" }
    var background: UIColor { .blue }
}

struct navy: Theme {
    var description: String { "navy" }
    var background: UIColor { .blue }
}

struct azure: Theme {
    var description: String { "azure" }
    var background: UIColor { .blue }
}

struct ocean: Theme {
    var description: String { "ocean" }
    var background: UIColor { .blue }
}

extension String {
    var theme: Theme? {
        guard let object = registered[self] as? Theme.Type else { return nil }
        return object.init()
    }
}

var registered: [String: Any.Type] = [:]
func reg(type: Any.Type) {
    registered[String(describing:type)] = type
}
