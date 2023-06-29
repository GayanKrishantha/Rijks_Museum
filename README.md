# Rijksmuseum - iOS
Rijksmuseum iOS Application 

## Technical Stack
- MVVM pattern
- Combine

## Folder structure
- Stencils
- Generated
- Assets
- Extension
- Util
- Data
- Cordinators
- Presentation

## App development target
 15.0

## Build App
- Configure SPM dependencies.
  (https://developer.apple.com/documentation/xcode/)
- Run Swiftgen configuration to access Assets.
  (https://github.com/SwiftGen/SwiftGen)

## SwiftGen usage
- [SwiftGen: Strings)
- [SwiftGen: Images](#swiftgen-images)
- [SwiftFormat](#swiftformat)

### SwiftGen: Stringss
 Lokalise and then generates Swift Code for the translation keys.

#### Example  

For the keys:
```swift
"navigation.title.movies" = "Movies";
```

The following Swift code will be generated:
```swift
extension String {
  enum L10n {
    enum Navigation {
      /// Movies
      static var title: L10n.tr("Localizable", "navigation.title.movies")
    }
  }
}
```

Which can then be used as follows:
```swift
// Assign to variable
let title = String.Login.Header.title

// Assign to String property
label.text = .Login.Header.title
```

#### Usage

- Step 1: Add new translation key to Lokalise
- Step 2: Run the `swiftgen.sh` script
- Step 3: ...
- Step 4: Profit!

To run the script from the terminal:
```bash
$ ./swiftgen.sh
```

#### Configuration

##### [SwiftGen](https://github.com/SwiftGen/SwiftGen)
The SwiftGen command line tool can be configured in the [swiftgen.yml] configuration file.
> More details on the SwiftGen configuration can be found [here](https://github.com/SwiftGen/SwiftGen#configuration-file).

### SwiftGen: Images

SwiftGen is used to generate static constant extensions on UIImage and Image. This adds a build time check if an image was added to `Assets.xcassets` and gives autocomplete suggestions.

#### Example

Given an image in `Assets.xcassets` with the name `"logo"` in a folder called `"icons"`. 

To use this image before:
```swift
// SwiftUI
Image("icons/logo")

// UIKit
UIImage(named: "icons/logo")
```

Two extensions have been generated for this example image: One for `Image`, and one for `UIImage`.

```swift
// SwiftUI
extension Image {
  enum Icons {
    static var scooter: Image { Image("icons/logo") }  
  }
}

// UIKit
extension UIImage {
  enum Icons {
    static var scooter: UIImage { UIImage(named: "icons/logo")! }  
  }
}
```

That can be used like this:
```swift
// SwiftUI
Image.Icons.logo

// UIKit
UIImage.Icons.logo
```

#### Usage

- Step 1: Add new image to `Assets.xcassets`
- Step 2 (optional): When adding a new folder, make sure the "Provides Namespace" setting is enabled on the folder.
- Step 3: Run the `swiftgen.sh` script
- Step 4: ...
- Step 5: Profit!

To run the script from the terminal:
```bash
$ ./swiftgen.sh
```

#### Configuration

##### [SwiftGen](https://github.com/SwiftGen/SwiftGen)
The SwiftGen command line tool can be configured in the [swiftgen.yml] configuration file.
> More details on the SwiftGen configuration can be found [here](https://github.com/SwiftGen/SwiftGen#configuration-file).

### SwiftFormat

SwiftFormat is a tool for reformatting Swift code to enforce a common coding style. This prevents unnecessary and tedious discussions in Pull Requests about trivial styling issues and lets us focus on the behavior of the code, not its presentation.

#### Usage

To run the script from the terminal:
```bash
$ ./swiftgen.sh
```

#### Configuration

SwiftFormat is configured through a [.swiftformat](/.swiftFormat) configuration file located at the root folder of the project. More details on the SwiftFormat rules and options can be found [here](https://github.com/nicklockwood/SwiftFormat#rules).
