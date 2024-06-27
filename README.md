# API Call With DispatchGroup()
APICallWithDispatchGroupDemo is the used to see DispatchGroup()

## Usage

### REST 3 API Calls and get status after finish all 3 calls

```swift
    viewModel.getHomeDataWithDispatchGroup { (restaurants, topPick, cuisines, nofifyValue) in
        print("restaurants[0].name - \(restaurants[0].name)")
        print("topPick[0].name - \(topPick[0].name)")
        print("cuisines[0].name - \(cuisines[0].name)")
        print("\(nofifyValue)")
    }
```


## License

APICallWithDispatchGroupDemo is free to use.
