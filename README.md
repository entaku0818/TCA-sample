# TCA-sample: サンプルToDoアプリ

このプロジェクトは、The Composable Architecture (TCA) を使用したシンプルなToDoアプリケーションのサンプルです。特に、TCAの `BindableAction` と `ViewAction` の概念を実践的に理解するために作成されました。

## 機能

- ToDoアイテムの追加、削除、完了状態の切り替え
- 完了済みToDoのみをフィルタリング表示
- 美しくモダンなUIデザイン
- TCAパターンに準拠した状態管理と副作用の処理

## 技術スタック

- Swift
- SwiftUI
- [The Composable Architecture](https://github.com/pointfreeco/swift-composable-architecture)

## TCAにおける重要な概念の実装例

### BindableAction

BindableActionは、フォームの入力やトグルスイッチなどの双方向バインディングを簡潔に実装するための機能です。このサンプルでは以下のように実装しています：

```swift
enum Action: ViewAction, BindableAction, Sendable {
    case binding(BindingAction<State>)
    // 他のアクション...
}
```

これにより、TextField やToggle などのSwiftUIコンポーネントと状態を簡単にバインドできます：

```swift
TextField("新しいタスク", text: $store.newTodoTitle)
Toggle("完了済みのみ表示", isOn: $store.filterCompleted)
```

### ViewAction

ViewActionは、UIからのユーザーアクションと内部のビジネスロジックを分離するパターンです。ユーザーインターフェースからのイベントをまず `view` アクションとして受け取り、必要に応じて内部アクションに変換します。

```swift
enum Action: ViewAction, BindableAction, Sendable {
    case binding(BindingAction<State>)
    case view(View)
    
    enum View: Equatable {
        case onAppear
        case addTodoButtonTapped
        case todoCheckboxToggled(id: Todo.ID)
        case deleteTodoButtonTapped(id: Todo.ID)
    }
}
```

ViewでのViewActionの使用例：

```swift
Button(action: {
    send(.addTodoButtonTapped)  // @ViewAction マクロにより簡潔に記述可能
}) {
    Image(systemName: "plus.circle.fill")
}
```

Reducerでの処理：

```swift
case .view(.addTodoButtonTapped):
    // ビジネスロジックを実行
    state.todos.append(Todo(title: state.newTodoTitle))
    state.newTodoTitle = ""
    return .none
```

## プロジェクト構成

- **TodoModel.swift**: ToDoアイテムのデータモデルを定義
- **TodoFeature.swift**: TCAの機能（状態、アクション、リデューサー）を定義
- **TodoView.swift**: UIコンポーネントとユーザーインタラクションの実装

## 実行方法

1. リポジトリをクローン
2. Xcodeでプロジェクトを開く
3. 実行ボタンをクリックしてシミュレータまたは実機で実行

## 学習リソース

- [The Composable Architecture ドキュメント](https://pointfreeco.github.io/swift-composable-architecture/main/documentation/composablearchitecture/)
- [Swift Package Index: swift-composable-architecture](https://swiftpackageindex.com/pointfreeco/swift-composable-architecture)

## ライセンス

このプロジェクトはMITライセンスの下で公開されています。詳細については [LICENSE](LICENSE) ファイルを参照してください。 