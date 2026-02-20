# MicroCreditSDK iOS Framework

- [Overview](#overview)
- [Requirements](#requirements)
- [Installation](#installation)
- [Integration](#integration)
- [Configuration](#configuration)
- [Navigation](#navigation)
- [Support](#support)

## Overview

MicroCreditSDK is an iOS framework providing micro-credit and credit card application flows. It enables host apps to seamlessly integrate credit product functionality with minimal setup.

## Requirements

- iOS: `15.0+`
- Swift: `5.0+`
- Xcode: `16.0+`

## Installation

### Swift Package Manager

Add the following to your `Package.swift` or via Xcode:

```swift
dependencies: [
    .package(url: "<REPO_URL>", .upToNextMajor(from: "1.0.0"))
]
```

### Manual Installation

1. Download the latest `MicroCreditSDK.xcframework` from the releases page
2. Drag and drop the framework into your Xcode project
3. Ensure the framework is added to "Embedded Binaries" in your target settings

## Integration

Import the framework:

```swift
import MicroCreditSDK
```

## Configuration

### Setup

```swift
let config = MicroConfiguration(
    accesstoken: "<ACCESS_TOKEN>",
    language: "az",
    userAgent: userAgent,
    environment: .debug
)

let diContainer = MicroDIContainer(
    config: config,
    unAuthorizedHandler: {
        // Handle 401 unauthorized
    }
)
```

### UserAgent

```swift
let userAgent = UserAgent(
    os: "iOS",
    osVersion: UIDevice.current.systemVersion,
    deviceVersion: UIDevice.current.systemVersion,
    deviceModel: UIDevice.current.name,
    deviceType: "phone",
    appVersion: "1.0.0",
    deviceId: UIDevice.current.identifierForVendor?.uuidString ?? ""
)
```

## Navigation

### MicroCredit Flow

```swift
let coordinator = diContainer.makeMicroCreditCoordinator(router: navigationController)
coordinator.start()
```

## Support

### Contact
- [Aslanli Faqan](mailto:aslanli.faqan@kapitalbank.az)
