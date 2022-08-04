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

This project also include a small command line tool to help with testing.

Usage:

```bash
# write the doppler xattr and mark the file as changed
doppler-xattr-util mark-changed <path to file>

# clear the doppler xattr and mark the file as no-changes
doppler-xattr-util clear <path to file>

# test for whether the file is marked as changed or not
doppler-xattr-util is-changed <path to file>
```

## License

[MIT](/LICENSE).
