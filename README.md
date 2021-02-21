# WoofKit

WoofKit is a Swift library for interacting with the [Dog CEO](https://dog.ceo/dog-api/) API.

## Installation

### Swift Package Manager

The Swift Package Manager is a tool for automating the distribution of Swift code and is integrated into the swift compiler. It is in early development, but WoofKit supports its use on supported platforms.

Once you have your Swift package set up, adding WoofKit as a dependency is as easy as adding it to the dependencies value of your Package.swift.

dependencies: [
    .package(url: "https://github.com/arvindravi/WoofKit.git")
]

## Usage

1. Import WoofKit

```swift
import WoofKit
```
2. Fetch a list of Dog breeds

```swift
WoofKit.shared.fetchBreeds { result in
    // `result` contains an array of type `Breed` for a successful fetch.
}
```

3. Fetch a list of images for a breed, and optionally subBreed

```swift
WoofKit.shared.fetchImages(for: breedName, subBreed: subBreed) { result in 
    // `result` contains an array of `UIImage`s for a successfult fetch.
}
```

## Contributing
Pull requests are welcome.

## License
[MIT](https://choosealicense.com/licenses/mit/)
