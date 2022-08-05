# doppler-xattr

## Usage

```swift
import DopplerExtendedAttributes

// A `file://` url pointing to the file that you want to mark as having updates
let fileURL: URL = // ...

// Set the xattr
try setDopplerMetadataChangedAttribute(for: fileURL)
```

## doppler-xattr-util

A small command line tool to help with testing is available at [doppler-xattr-util](https://github.com/brushedtype/doppler-xattr-util).

## License

[MIT](/LICENSE).
