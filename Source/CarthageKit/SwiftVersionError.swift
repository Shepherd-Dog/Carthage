import Foundation

internal enum SwiftVersionError: Error {
	/// An error in determining the local Swift version
	case unknownLocalSwiftVersion

	/// An error in determining the framework Swift version
	case unknownFrameworkSwiftVersion(message: String)

	/// The framework binary is not compatible with the local Swift version.
	case incompatibleFrameworkSwiftVersions(local: String, framework: String)

}

extension SwiftVersionError: CustomStringConvertible {
	var description: String {
		switch self {
		case .unknownLocalSwiftVersion:
			return "Unable to determine local Swift version."

		case let .unknownFrameworkSwiftVersion(message):
			return "Unable to determine framework Swift version: \(message)"

		case let .incompatibleFrameworkSwiftVersions(local, framework):
			return "Incompatible Swift version - framework was built with \(framework) and the local version is \(local)."
		}
	}
}

extension SwiftVersionError: Equatable {
	static func == (lhs: SwiftVersionError, rhs: SwiftVersionError) -> Bool {
		switch (lhs, rhs) {
		case (.unknownLocalSwiftVersion, .unknownLocalSwiftVersion):
			return true

		case let (.unknownFrameworkSwiftVersion(lhsMessage), .unknownFrameworkSwiftVersion(rhsMessage)):
			return lhsMessage == rhsMessage

		case let (.incompatibleFrameworkSwiftVersions(la, lb), .incompatibleFrameworkSwiftVersions(ra, rb)):
			return la == ra && lb == rb

		default:
			return false
		}
	}
}
