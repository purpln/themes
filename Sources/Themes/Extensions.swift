import UIKit

public extension Array where Element == UIWindow {
    func reload() {
        forEach {
            $0.reload()
            $0.rootViewController?.setNeedsStatusBarAppearanceUpdate()
        }
    }
}

public extension UIWindow {
    func reload() {
        subviews.forEach { view in
            view.removeFromSuperview()
            addSubview(view)
        }
    }
}
