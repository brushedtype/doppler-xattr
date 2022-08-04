import Foundation
import DopplerExtendedAttributes

func printHelp() {
    let helpText = """
    CLI util to quickly access/edit the Doppler xattr for files.

    Usage:

      doppler-xattr-util mark-changed <path to file>

      doppler-xattr-util clear <path to file>

      doppler-xattr-util is-changed <path to file>
    """
    print(helpText)
}

func markChanged(_ pathToFile: String) throws {
    let cwd = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
    let fileURL = URL(fileURLWithPath: pathToFile, relativeTo: cwd).standardizedFileURL
    try setDopplerMetadataChangedAttribute(for: fileURL)
}

func clearAttr(_ pathToFile: String) throws {
    let cwd = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
    let fileURL = URL(fileURLWithPath: pathToFile, relativeTo: cwd).standardizedFileURL
    try clearDopplerMetadataChangedAttribute(for: fileURL)
}

func checkIsChanged(_ pathToFile: String) throws {
    let cwd = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
    let fileURL = URL(fileURLWithPath: pathToFile, relativeTo: cwd).standardizedFileURL

    let isChanged = try isDopplerMetadataChangedAttributeSet(for: fileURL)

    if isChanged {
        print("file is marked as having changed metadata")
    } else {
        print("file is NOT marked as having changed metadata")
    }
}

enum Error: Swift.Error {
    case unknownCommand
    case missingCommand
    case missingArgument(String)
}

func runMain() throws {
    var args = CommandLine.arguments.dropFirst()

    guard args.count >= 1 else {
        throw Error.missingCommand
    }

    let command = args.removeFirst()

    switch command {
    case "help":
        printHelp()

    case "mark-changed":
        guard let pathToFile = args.first else {
            throw Error.missingArgument("<path to file>")
        }
        try markChanged(pathToFile)

    case "clear":
        guard let pathToFile = args.first else {
            throw Error.missingArgument("<path to file>")
        }
        try clearAttr(pathToFile)

    case "is-changed":
        guard let pathToFile = args.first else {
            throw Error.missingArgument("<path to file>")
        }
        try checkIsChanged(pathToFile)

    default:
        throw Error.unknownCommand
    }

    exit(EXIT_SUCCESS)
}

do {
    try runMain()

} catch let err as Error {
    switch err {
    case .missingArgument(let arg):
        print("error: missing \(arg)")

    case .missingCommand:
        print("error: missing command")

    case .unknownCommand:
        print("error: unknown command")
    }

    print("")
    printHelp()
    exit(EXIT_FAILURE)

} catch let err {
    print("error: \((err as NSError).localizedDescription)")
    print("")
    printHelp()
    exit(EXIT_FAILURE)
}
