# NetworkManager

This Swift Package provides the implementation of a Network Manager for dispatching URL Requests based on URLSession. 

## Getting Started

The following are the main concepts about the NetworkManager:

* APIPerformer is the singleton instance which manages the connection to the url endpoints and retrieve the answer;
* APIRequest is the base class for creating a request;
* CustomDecodable is the protocol to which each response object should conform;
* A NetworkError is returned in case of the process fails.

This Package relies on [ReactiveSwift](https://github.com/ReactiveCocoa/ReactiveSwift) and [OSLogger](https://github.com/NPasini/OSLogger).

### Installation

To integrate the package in your application you need to use Swift Package Manager and add NetworkManager as a dependency of your package in Package.swift:

.package(url: "https://github.com/NPasini/NetworkManager.git", from: "1.0.0"),

### Example

First thing you have to do is to create the model parsing the response:

```swift
struct YourResponse {
    let example: String
    
    init(example: String) {
        self.example = example
    }
}

extension YourResponse: CustomDecodable {
    static func decode(_ data: Data) -> CustomDecodable? {
        return try? JSONDecoder().decode(YourResponse.self, from: data)
    }
}

```

Then you have to create your request:

```swift
class YourRequest: GetRequest<YourResponse> {
    init() {
        let host = "yourhost.com"
        let path = "path"
        let version = "1"
        
        super.init(host: host, path: path, version: version)
    }
}
```

Finally you have to use the APIPerformer to connect to the endpoint:

```swift
let subscriptionToEndpoint: SignalProducer<Result<YourResponse, NSError>, NSError> = SignalProducer {
            (observer, lifetime) in
            
            let subscription = APIPerformer.shared.performApi(YourRequest(), QoS: .default, completionQueue: .global(qos: .userInteractive)) { (result: Result<YourResponse, NSError>) in
                
                switch result {
                case .success(let response):
                    observer.send(value: Result.success(response))
                    observer.sendCompleted()
                case .failure(let error):
                    observer.send(value: Result.failure(error))
                    observer.sendCompleted()
                }
            }
            
            lifetime.observeEnded {
                subscription.dispose()
      }
}
```

## Author

**Nicolò Pasini**


