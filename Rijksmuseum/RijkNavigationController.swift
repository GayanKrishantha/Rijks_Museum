
//  Created by Gayan Dias on 27/06/2023.

import UIKit
import Foundation

final class RijkNavigationController: UINavigationController {
    
    override var childForStatusBarStyle: UIViewController? {
        topViewController
    }
    
    override var childForStatusBarHidden: UIViewController? {
        topViewController
    }
    
    convenience init() {
        self.init(style: .opaque)
    }
    
    init(style: UINavigationBar.Style) {
        super.init(nibName: nil, bundle: nil)
        
        navigationBar.apply(style: style)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UINavigationBar {
    
    enum Style {
        case opaque(backgroundColor: UIColor, tintColor: UIColor)
        case transparent(tintColor: UIColor)
        
        static var opaque: Style {
            .opaque(tintColor: .white)
        }
        
        static func opaque(tintColor: UIColor) -> Style {
            .opaque(backgroundColor: .clear
                    ,tintColor: tintColor)
        }
        
        static var transparent: Style {
            .transparent(tintColor: .clear)
        }
        
        var tintColor: UIColor {
            switch self {
            case .opaque(_, let tintColor), .transparent(let tintColor):
                return tintColor
            }
        }
    }
    
    func apply(style: Style) {
        let appearance: UINavigationBarAppearance
        switch style {
        case .opaque(let backgroundColor, let tintColor):
            appearance = .opaque(backgroundColor: backgroundColor, tintColor: tintColor)
        case .transparent(let tintColor):
            appearance = .transparent(tintColor: tintColor)
        }
        
        tintColor = style.tintColor
        standardAppearance = appearance
        compactAppearance = appearance
        scrollEdgeAppearance = appearance
        if #available(iOS 15.0, *) {
            compactScrollEdgeAppearance = appearance
        }
    }
    
    func showShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = .zero
        layer.shadowRadius = 15
        layer.shadowOpacity = 0.08
    }
    
    func hideShadow() {
        layer.shadowOpacity = 0.0
    }
}

extension UINavigationBarAppearance {
    
    // Just setting the original image as backIndicatorImage puts the image all the way to the edge of the screen.
    // To make sure the backIndicatorImage is positioned correctly on all screens the image needs a baked in offset.
    // This will create a new image with a padding offset on the left.
    private static func makeBackIndicatorImage() -> UIImage {
        let config = UIImage.SymbolConfiguration(textStyle: .largeTitle)
        let image = UIImage(systemName: "chevron.backward", withConfiguration: config)
        return image!
    }
    
    private static func baseAppearance(tintColor: UIColor) -> UINavigationBarAppearance {
        let appearance = UINavigationBarAppearance()
        
        let image = makeBackIndicatorImage()
        appearance.setBackIndicatorImage(image, transitionMaskImage: image)
        
        appearance.titleTextAttributes = [
            .font: UIFont.ubuntuBolt(size: 16) ?? UIFont.systemFont(ofSize: 16.0, weight: .bold),
            .foregroundColor: tintColor
        ]
        
        appearance.buttonAppearance = UIBarButtonItemAppearance(style: .plain).configure {
            $0.normal.titleTextAttributes = [
                .font: UIFont.ubuntuRegular(size: 14) ?? UIFont.systemFont(ofSize: 14.0, weight: .regular),
                .foregroundColor: tintColor
            ]
        }
        
        appearance.doneButtonAppearance = UIBarButtonItemAppearance(style: .done).configure {
            $0.normal.titleTextAttributes = [
                .font: UIFont.ubuntuBolt(size: 14) ?? UIFont.systemFont(ofSize: 14.0, weight: .bold),
                .foregroundColor: tintColor
            ]
        }
        
        return appearance
    }
    
    static func opaque(backgroundColor: UIColor, tintColor: UIColor) -> UINavigationBarAppearance {
        let appearance = baseAppearance(tintColor: tintColor)
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = backgroundColor
        appearance.shadowImage = nil
        appearance.shadowColor = .clear
        return appearance
    }
    
    static func transparent(tintColor: UIColor) -> UINavigationBarAppearance {
        let appearance = baseAppearance(tintColor: tintColor)
        appearance.configureWithTransparentBackground()
        return appearance
    }
}

protocol Initializable {
    init()
}

protocol Configurable { }

extension Configurable where Self: Initializable, Self: AnyObject {
    
    init(with configurator: (Self) -> Void) {
        let instance = Self.init()
        configurator(instance)
        self = instance
    }
}

extension Configurable where Self: Initializable {
    
    init(with configurator: (inout Self) -> Void) {
        var instance = Self.init()
        configurator(&instance)
        self = instance
    }
}

extension Configurable where Self: AnyObject {
    
    @discardableResult
    func configure(with configurator: (Self) -> Void) -> Self {
        configurator(self)
        return self
    }
}

extension Configurable {
    
    @discardableResult
    mutating func configure(with configurator: (inout Self) -> Void) -> Self {
        configurator(&self)
        return self
    }
}

extension NSObject: Initializable, Configurable { }
