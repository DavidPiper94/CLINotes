import ArgumentParser
import Foundation

struct CLINotes: ParsableCommand {
    static let configuration: CommandConfiguration = CommandConfiguration(
        commandName: "clinotes",
        abstract: "Manage your notes from the command line",
        discussion: "Create your nodes from the command-line. Each file generated with this tool has the extension \(fileExtension).",
        subcommands: [Write.self]
    )

    static let fileExtension = ".clinote"

    struct Write: ParsableCommand {
        static let configuration: CommandConfiguration = CommandConfiguration(
            commandName: "write",
            abstract: "Writes given text to file at given file path."
        )

        @Option(name: [.customLong("file")], help: "The file path to write the note to.")
        var filePath: String

        @Argument(help: "The note to write to file.")
        var note: String

        @Flag(name: .shortAndLong, help: "Overrides existing file.")
        var force = false

        func validate() throws {
            let filePathWithExtension = "\(filePath)\(fileExtension)"
            if FileManager.default.fileExists(atPath: filePathWithExtension) && force == false {
                throw ValidationError("Given file already exists. To override it, please add `--force`.")
            }
        }

        mutating func run() throws {
            let filePathWithExtension = "\(filePath)\(fileExtension)"
            do {
                try note.write(toFile: filePathWithExtension, atomically: true, encoding: .utf8)
            } catch {
                throw RuntimeError("Couldn't write to `\(filePath)`!")
            }
        }
    }
}

struct RuntimeError: Error, CustomStringConvertible {
    var description: String

    init(_ description: String) {
        self.description = description
    }
}
