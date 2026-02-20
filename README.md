# MicroCreditSDK

iOS SDK for integrating Micro-Credit and Credit Card product flows into host applications on the Birbank Business platform.

---

## Table of Contents

- [Requirements](#requirements)
- [Installation](#installation)
- [Integration](#integration)
- [Support](#support)

---

## Requirements

| | Minimum |
|---|---|
| iOS | 15.0+ |
| Swift | 5.9+ |
| Xcode | 16.0+ |

---

## Installation

### Swift Package Manager

Add the dependency in your `Package.swift`:

```swift
dependencies: [
    .package(url: "<REPO_URL>", .upToNextMajor(from: "1.0.0"))
]
```

Or in Xcode: **File → Add Package Dependencies** → enter the repo URL.

### Manual

1. Download `MicroCreditSDK.xcframework` from the releases page
2. Drag it into your Xcode project
3. In your target settings → **General** → **Frameworks, Libraries, and Embedded Content** → set to **Embed & Sign**

---

## Integration

### 1. Import

```swift
import MicroCreditSDK
```

### 2. Setup DI Container

Initialize `MicroDIContainer` with your configuration. Keep it as a lazy property so it is created once:

```swift
private lazy var microDI: MicroDIContainer = {
    MicroDIContainer(
        config: MicroConfiguration(
            accesstoken: token,
            language: "az",
            userAgent: buildUserAgent(),
            environment: .debug
        ),
        unAuthorizedHandler: { [weak self] in
            DispatchQueue.main.async {
                self?.router.showMessage("Unauthorized error")
                // Handle 401 — e.g. navigate to login
            }
        }
    )
}()
```

**MicroConfiguration parameters:**

| Parameter | Type | Description |
|---|---|---|
| `accesstoken` | `String` | Bearer token for API authorization |
| `language` | `String` | Request language header (e.g. `"az"`, `"en"`) |
| `userAgent` | `UserAgent` | Device and app info for the User-Agent header |
| `environment` | `Environment` | `.debug` for staging, `.release` for production |

**Environment URLs:**

| Value | Base URL |
|---|---|
| `.debug` | `https://pre-my.birbank.business/m/api/v1` |
| `.release` | `https://my.birbank.business/m/api/v1` |

### 3. Build UserAgent

```swift
private func buildUserAgent() -> UserAgent {
    let device = UIDevice.current
    let info = Bundle.main.infoDictionary ?? [:]
    let appVersion = "\(info["CFBundleShortVersionString"] ?? "")(\(info["CFBundleVersion"] ?? ""))"

    return UserAgent(
        os: device.systemName,
        osVersion: device.systemVersion,
        deviceVersion: device.systemVersion,
        deviceModel: device.model,
        deviceType: device.deviceType,
        appVersion: appVersion,
        deviceId: UUID().uuidString
    )
}
```

### 4. Start MicroCredit Flow

Create a `MicroCoordinator` using the DI container and start it from your coordinator:

```swift
private func startMicroCreditFlow() {
    let coordinator = MicroCoordinator(
        router: rootNavigationController,
        diContainer: microDI
    )
    coordinator.parentCoordinator = self
    addChild(coordinator)
    coordinator.start()
}
```

---

## Support

- **Author:** [Aslanli Faqan](mailto:aslanli.faqan@kapitalbank.az)
