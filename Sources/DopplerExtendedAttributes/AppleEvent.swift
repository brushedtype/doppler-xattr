import Foundation
import Cocoa

extension FourCharCode {

    /// Create a FourCharCode from a static string
    init(staticString value: StaticString) {
        precondition(value.isASCII)
        precondition(value.utf8CodeUnitCount == 4)

        var code: FourCharCode = 0
        for i in 0..<4 {
            code = code << 8 + FourCharCode(value.utf8Start.advanced(by: i).pointee)
        }
        self = code
    }

}

/// The Doppler Apple event class
public let DopplerEventClass: AEEventClass = FourCharCode(staticString: "Dplr")

/// The Doppler Edit Metadata event id
///
/// This is sent by Doppler when opening files inside a metadata editing app. You should
/// use this when registering an Apple event handler.
public let DopplerEditMetadataEventId: AEEventID = FourCharCode(staticString: "EMta")
