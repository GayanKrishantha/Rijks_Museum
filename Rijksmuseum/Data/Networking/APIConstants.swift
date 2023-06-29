
//  Created by Gayan Dias on 27/06/2023.

import Foundation
import UIKit

public struct Constants {

    struct API {
        static let BASE_URL = valueForAPIKey(keyname: "API_BASE_URL")
        static let API_KEY = valueForAPIKey(keyname: "API_KEY")
    }
}

func valueForAPIKey(keyname:String) -> String {
    let bundle = Bundle.main
    let KeyFileName = bundle.object(forInfoDictionaryKey: "KeyFileName") as? String
    let path = bundle.path(forResource: KeyFileName, ofType: "plist")
    let plist = NSDictionary(contentsOfFile: path!)
    let value = plist!.object(forKey: keyname) as? String
    return value!
}
