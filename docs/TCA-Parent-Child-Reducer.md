# TCA 1.5を使用した親子関係を持つReducerの実装

## 概要

この記事では、The Composable Architecture (TCA) 1.5を使用して、親子関係を持つReducerを実装する方法を解説します。具体的には、ナビゲーションバーとメインコンテンツを持つアプリケーションを例に、TCAの新しい書き方と画面遷移の実装方法を説明します。

## 参考リンク

- [TCA公式ドキュメント](https://pointfreeco.github.io/swift-composable-architecture/)
- [TCA 1.5マイグレーションガイド](https://pointfreeco.github.io/swift-composable-architecture/main/documentation/composablearchitecture/migratingto1.5)
- [サンプルコードのGitHubリポジトリ](https://github.com/your-username/TCA-sample)

## 実装の特徴

### 1. 新しいTCAの書き方

TCA 1.5では、以下の新しい書き方が導入されました：

```swift
@Reducer
public struct MainFeature {
    @ObservableState
    public struct State: Equatable {
        // ...
    }
    
    public enum Action: ViewAction, BindableAction, Sendable {
        // ...
    }
}
```

- `@Reducer`マクロを使用してReducerを定義
- `@ObservableState`を使用して状態の監視を可能に
- `ViewAction`と`BindableAction`を使用してアクションを整理

### 2. 親子関係を持つReducerの構造

```
AppFeature
└── MainFeature
    ├── NavigationFeature
    └── DetailFeature (オプショナル)
```

各Reducerは独立した状態を持ちながら、親Reducerと連携します：

```swift
// 親Reducerでの子Reducerの組み込み
Scope(state: \.navigation, action: \.navigation) {
    NavigationFeature()
}
```

### 3. 画面遷移の実装

TCA 1.5では、`PresentationState`を使用して画面遷移を管理します：

```swift
@ObservableState
public struct State: Equatable {
    @Presents public var detail: DetailFeature.State?
}

// 画面遷移の実装
.navigationDestination(
    store: store.scope(
        state: \.$detail,
        action: \.detail
    )
) { store in
    DetailView(store: store)
}
```

## 主要なコンポーネント

### 1. NavigationFeature

ナビゲーションバーを管理するReducer：

```swift
@Reducer
public struct NavigationFeature {
    @ObservableState
    public struct State: Equatable {
        public var title: String
    }
    
    public enum Action: ViewAction, BindableAction, Sendable {
        case binding(BindingAction<State>)
        case view(View)
        
        public enum View: Equatable {
            case titleChanged(String)
        }
    }
}
```

### 2. MainFeature

メインコンテンツを管理するReducer：

```swift
@Reducer
public struct MainFeature {
    @ObservableState
    public struct State: Equatable {
        public var navigation: NavigationFeature.State
        public var items: [String]
        @Presents public var detail: DetailFeature.State?
    }
    
    public enum Action: ViewAction, BindableAction, Sendable {
        case binding(BindingAction<State>)
        case view(View)
        case navigation(NavigationFeature.Action)
        case detail(PresentationAction<DetailFeature.Action>)
    }
}
```

### 3. DetailFeature

詳細画面を管理するReducer：

```swift
@Reducer
public struct DetailFeature {
    @ObservableState
    public struct State: Equatable {
        public var items: [String]
        public var title: String
    }
    
    public enum Action: ViewAction, BindableAction, Sendable {
        case binding(BindingAction<State>)
        case view(View)
        
        public enum View: Equatable {
            case itemTapped(String)
        }
    }
}
```

## 状態とアクションの委譲

### 1. 状態の委譲

親Reducerは子Reducerの状態を保持し、必要に応じて更新します：

```swift
// 親の状態
MainFeature.State(
    navigation: NavigationFeature.State(title: "Navigation"),
    items: ["Item 1", "Item 2"]
)
```

### 2. アクションの委譲

子Reducerのアクションは親Reducerに委譲され、適切に処理されます：

```swift
// 子Reducerでのアクション
NavigationFeature.Action.view(.titleChanged("New Title"))

// 親Reducerへの委譲
MainFeature.Action.navigation(.view(.titleChanged("New Title")))
```

## まとめ

TCA 1.5を使用することで、以下のような利点が得られます：

1. より簡潔で型安全なコード
2. 効率的な状態管理
3. 柔軟な画面遷移の実装
4. 親子関係を持つReducerの適切な連携

この実装パターンを使用することで、大規模なアプリケーションでも管理しやすい構造を維持することができます。

## 参考

- [TCA公式ドキュメント](https://pointfreeco.github.io/swift-composable-architecture/)
- [TCA 1.5マイグレーションガイド](https://pointfreeco.github.io/swift-composable-architecture/main/documentation/composablearchitecture/migratingto1.5)
- [サンプルコードのGitHubリポジトリ](https://github.com/your-username/TCA-sample) 