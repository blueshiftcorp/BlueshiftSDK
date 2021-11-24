# BlueshiftSDK

[![CI Status](https://img.shields.io/travis/blueshiftcorp/BlueshiftSDK.svg?style=flat)](https://travis-ci.org/blueshiftcorp/BlueshiftSDK)
[![Version](https://img.shields.io/cocoapods/v/BlueshiftSDK.svg?style=flat)](https://cocoapods.org/pods/BlueshiftSDK)
[![License](https://img.shields.io/cocoapods/l/BlueshiftSDK.svg?style=flat)](https://cocoapods.org/pods/BlueshiftSDK)
[![Platform](https://img.shields.io/cocoapods/p/BlueshiftSDK.svg?style=flat)](https://cocoapods.org/pods/BlueshiftSDK)

## BlueshiftSDK
BlueshiftSDK는 Swift, Interface Builder(xib) 기반의 iOS 어플리케이션 개발에 적합하도록 개발되었으며, 블루시프트 내부 개발자를 위한 소프트웨어 개발 툴킷입니다.
일반 개발자를 위해 일부 프레임워크를 공개하고 있으나, 예고없이 기능의 일부 혹은 전부를 비공개로 전환하거나 수정 혹은 삭제될 수 있음을 양해해주십시오.
BlueshiftSDK는 하단메뉴를 포함하는 네비게이션, 테이블뷰 등으로 구성된 어플리케이션 개발에 특히 최적화되어 있습니다. 기본적으로 제공되는 기능은 아래와 같습니다.

* BSTabBarController
* BSViewController
* BSTableViewController
* Networking & API Module
* Common Utilities

소스코드 및 오류사항에 대한 문의에 대해서는 공식적인 답변이나 지원을 하지 않습니다. 
또한 배포된 상태의 소스코드를 사용함에 있어 발생하는 오류, 문제 혹은 법적인 책임에 대하여 블루시프트는 어떠한 책임도 지지 않습니다.

## Example
예제 코드를 실행하려면 저장소를 클론한 후 예제폴더(Example)에서 `pod install`를 실행하여 필요한 라이브러리를 설치하시기 바랍니다.
예제 코드는 항상 업데이트 되는 것이 아니므로 최신 라이브러리에서 정상적으로 작동하지 않을 수 있습니다.

## Installation

BlueshiftSDK is available through [CocoaPods](https://cocoapods.org). To install all of it, simply add the following line to your Podfile:

```ruby
pod 'BlueshiftSDK'
```

To install it separately, add the following line to your Podfile as your need:

```ruby
pod 'BlueshiftSDK/Common'
pod 'BlueshiftSDK/API'
pod 'BlueshiftSDK/Login'
pod 'BlueshiftSDK/BLE'
```

## Author

Blueshift Corporation

## License

BlueshiftSDK is available under the Blueshift SDK license. See the LICENSE file for more info.
