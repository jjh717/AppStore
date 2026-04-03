# AppStore

App Store clone built with **UIKit (ReactorKit)** and **SwiftUI** implementations.

Searches the iTunes API and displays app details including screenshots, ratings, reviews, and compatibility info.

## Features

- iTunes Search API integration
- Search history with UserDefaults persistence
- App detail view (title, screenshots, description, ratings, info)
- Screenshot gallery with horizontal scrolling
- Star rating display
- iPad screenshot support
- Dynamic cell heights

## Requirements

- iOS 17.0+
- Swift 5.9+
- Xcode 15.0+

## Dependencies (SPM)

- [RxSwift 6.x](https://github.com/ReactiveX/RxSwift) - UIKit version
- [RxCocoa 6.x](https://github.com/ReactiveX/RxSwift) - UIKit version
- [ReactorKit 3.x](https://github.com/ReactorKit/ReactorKit) - UIKit version

## Project Structure

```
AppStore/
├── AppStore/                      # UIKit Version (ReactorKit + RxSwift)
│   ├── App/
│   │   ├── AppDelegate.swift
│   │   └── Main.storyboard
│   ├── Model/
│   │   ├── AppInfo.swift
│   │   └── Review.swift
│   ├── Reactor/
│   │   ├── SearchKeywordReactor.swift
│   │   ├── DetailReactor.swift
│   │   └── InfoDetailReactor.swift
│   ├── Service/
│   │   ├── Networking/ (APIService, Constants, UserEndpoint)
│   │   └── UserDefaults/ (UserDefaultsService, UserDefaultsKey)
│   ├── Controller/
│   │   ├── BaseViewController.swift
│   │   ├── SearchViewController.swift
│   │   └── DetailViewController.swift
│   ├── View/
│   │   ├── Detail/ (DetailTableView, InfoDetailTableView, Cells...)
│   │   ├── List/ (SearchListTableView, Cells...)
│   │   ├── History/ (HistoryTableView, Cells...)
│   │   └── Present/ (Protocol-based data presenters)
│   └── Extension/
│
└── AppStoreSwiftUI/               # SwiftUI Version
    ├── App/
    │   └── AppStoreApp.swift
    ├── Models/
    │   └── AppInfo.swift
    ├── Services/
    │   └── APIService.swift (async/await + actor)
    ├── ViewModels/
    │   └── SearchViewModel.swift (@Observable)
    └── Views/
        ├── SearchView.swift
        ├── AppDetailView.swift
        └── StarRatingView.swift
```

## UIKit Version

- **ReactorKit** - Unidirectional data flow (Action/Mutation/State)
- **RxSwift/RxCocoa** - Reactive bindings
- **XIB + Storyboard** - Interface Builder layouts
- **ServiceProvider** - Dependency injection pattern
- **Presenter pattern** - Protocol-based data formatting

## SwiftUI Version

- **@Observable** macro (iOS 17+)
- **async/await** - Native concurrency for API calls
- **actor** - Thread-safe API service
- **AsyncImage** - Native async image loading
- **NavigationStack** - Modern navigation
- **MVVM** architecture

## Modernization Changes

| Before | After |
|---|---|
| CocoaPods (RxSwift 5) | SPM (RxSwift 6) |
| `protocol: class` | `protocol: AnyObject` |
| `guard let \`self\`` | `guard let self` |
| `UserDefaults.synchronize()` | Removed (auto-sync) |
| iOS 10.0+ | iOS 17.0+ |

## License

MIT
