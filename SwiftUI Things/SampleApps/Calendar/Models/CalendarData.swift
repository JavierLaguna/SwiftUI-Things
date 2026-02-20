import Foundation

struct Month: Identifiable {
    var id: String = UUID().uuidString
    var name: String
    var weels: [Week]
}

struct Week: Identifiable {
    var id: String = UUID().uuidString
    var days: [Day]
    var isLast: Bool = false
}

struct Day: Identifiable {
    var id: String = UUID().uuidString
    var value: Int?
    var date: Int?
    var isPlaceholder: Bool
}
