import Foundation

struct Mission: Codable, Identifiable, Hashable {
    struct CrewMember: Codable, Hashable {
        let name: String
        let role: String
    }

    let id: Int
    let crew: [CrewMember]
    let description: String
    let launchDate: String?

    var displayName: String { "Apollo \(id)" }
    var image: String { "apollo\(id)" }


    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd" // matches JSON format
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()

    var formattedLaunchDate: String {
        guard let launchDate = launchDate,
              let date = Mission.dateFormatter.date(from: launchDate) else {
            return "N/A"
        }

        // Convert into readable format, e.g. "May 18, 1969"
        let outputFormatter = DateFormatter()
        outputFormatter.dateStyle = .long
        outputFormatter.timeStyle = .none
        return outputFormatter.string(from: date)
    }
}
