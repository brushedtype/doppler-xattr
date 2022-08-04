import Foundation
import ExtendedAttributes

enum DopplerExtendedAttributeError: Error {
    case unexpectedDataForAttribute
}

struct DopplerRefreshExtendedAttributeOptionSet: OptionSet {
    let rawValue: UInt16

    static let isMetadataChanged = DopplerRefreshExtendedAttributeOptionSet(rawValue: 1 << 0)
}

/// The full extended attribute name for marking a file as having updated metadata and
/// triggering an automatic refresh within Doppler
public let DopplerRefreshMetadataExtendedAttributeName = "co.brushedtype.doppler-refresh#PCN"

/// Set the Doppler refresh xattr, marking a file as having updated metadata
///
/// - Parameter url: The file URL for the file that should have the extended attribute written to
public func setDopplerMetadataChangedAttribute(for url: URL) throws {
    let data = Data([0x00, 0x01]) // UInt16, BE = 1
    try url.setExtendedAttributeData(data, rawAttributeName: DopplerRefreshMetadataExtendedAttributeName)
}

/// Remove the Doppler refresh xattr, marking a file as not needing a refresh
///
/// Typically, metadata apps should not use this function. Doppler will call this function after reading
/// metadata and updating it's internal database.
///
/// - Parameter url: The file URL for the file that should have the extended attribute removed from
public func clearDopplerMetadataChangedAttribute(for url: URL) throws {
    try url.removeExtendedAttribute(rawAttributeName: DopplerRefreshMetadataExtendedAttributeName)
}

/// Read Doppler refresh xattr for file url and and return whether the metadata changed flag is set
///
/// Typically, metdata apps should not need to use this function. Doppler will call this function as part of
/// its scheduled updates (or when the system notifies Doppler that a file has changed).
///
/// Doppler uses this function to check if it should refresh metadata.
///
/// - Parameter url: The file URL for the file to test for the Doppler refresh metadata flag
public func isDopplerMetadataChangedAttributeSet(for url: URL) throws -> Bool {
    let data = try url.extendedAttributeData(rawAttributeName: DopplerRefreshMetadataExtendedAttributeName)

    guard data.count == 2 else {
        if data.isEmpty {
            return false
        }

        throw DopplerExtendedAttributeError.unexpectedDataForAttribute
    }

    let uint = data.withUnsafeBytes({ $0.load(as: UInt16.self) }).bigEndian
    let opt = DopplerRefreshExtendedAttributeOptionSet(rawValue: uint)

    return opt.contains(.isMetadataChanged)
}
