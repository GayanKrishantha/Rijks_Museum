
//  Created by Gayan Dias on 27/06/2023.

import MBProgressHUD
import Alamofire

extension UIViewController {
    
    func showIndicator(withTitle title: String, and Description:String) {
        let Indicator = MBProgressHUD.showAdded(to: self.view, animated: true)
        Indicator.label.text = title
        Indicator.isUserInteractionEnabled = false
        Indicator.detailsLabel.text = Description
        Indicator.show(animated: true)
    }
    
    func hideIndicator() {
        MBProgressHUD.hide(for: self.view, animated: true)
    }
    
    func showAlert(title: String,
                   message: String,
                   alertStyle:UIAlertController.Style,
                   actionTitles:[String],
                   actionStyles:[UIAlertAction.Style],
                   actions: [((UIAlertAction) -> Void)]){
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: alertStyle)
        for(index, indexTitle) in actionTitles.enumerated(){
            let action = UIAlertAction(title: indexTitle, style: actionStyles[index], handler: actions[index])
            alertController.addAction(action)
        }
        self.present(alertController, animated: true)
    }
}

extension UIFont {
    
    static func ubuntuLight(size: CGFloat) -> UIFont? {
        return UIFont(name: "Ubuntu-Light",
                      size: size) ?? .systemFont(ofSize: 32)
    }
    
    static func ubuntuBolt(size: CGFloat) -> UIFont? {
        return UIFont(name: "Ubuntu-Bold",
                      size: size)
    }
    
    static func ubuntuMedium(size: CGFloat) -> UIFont? {
        return UIFont(name: "Ubuntu-Medium",
                      size: size)
    }
    
    static func ubuntuRegular(size: CGFloat) -> UIFont? {
        return UIFont(name: "Ubuntu-Regular",
                      size: size)
    }
    
    static func ubuntuItalic(size: CGFloat) -> UIFont? {
        return UIFont(name: "Ubuntu-Italic",
                      size: size)
    }
}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}

extension UIImageView {
    
    func setCustomImage(_ imgURLString: String?) {
        guard let imageURLString = imgURLString else {
            self.image = UIImage(named: "detail_background.png")
            return
        }
        DispatchQueue.global().async { [weak self] in
            let data = try? Data(contentsOf: URL(string: imageURLString)!)
            DispatchQueue.main.async {
                self?.image = data != nil ? UIImage(data: data!) : UIImage(named: "detail_background.png")
            }
        }
    }
}

extension AFError {
    
    var isTimeout: Bool {
        if isSessionTaskError,
           let error = underlyingError as NSError?,
           error.code == NSURLErrorTimedOut || error.code == NSURLErrorUnknown {
            return true
        }
        return false
    }
    
    var isConnectedToTheInternet: Bool {
        if isSessionTaskError,
           let error = underlyingError as NSError?,
           error.code == NSURLErrorNotConnectedToInternet || error.code == NSURLErrorDataNotAllowed {
            return true
        }
        return false
    }
}

extension URL {
    
    static var settings: URL {
        URL(string: UIApplication.openSettingsURLString)!
    }
    
    static var rijksmuseum: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = Constants.API.BASE_URL
        return components.url!
    }
}
