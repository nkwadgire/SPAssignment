## SPAssignment
This application will fetch the Pollutant Standards Index (PSI) values via GET webservice call and display the PSI index values using MapView. The application has Refresh button on click of which latest PSIndex values will be retrieved from the server and the mapView is updated.

- The application is implemented using MVVM desing pattern
- The application is compatible for both iPhone and iPad and supports iOS 9.0 onwards
- If iOS version is greater than or equal to 13, then the Combine framework is used to fetch the PSIndex values as it provides a declarative Swift API for processing values over time
- If iOS version is less than 13, then traditional URLSession is used to make webservice call
- The SwiftUI is used instead of UIKit of UI implementation
- The SwiftLint tool is installed as it enforces Swift style and conventions
- The Quick (testing framework) and Nimble (matching framework) is installed to perform unit testing

## Requirements

- iOS 9.0+
- Swift 5
  - Xcode 11.0+
- CocoaPods 1.1.1+ (if you use)
