import Foundation

struct SweepEntry: Identifiable, Codable, Equatable {
    var id: UUID = UUID()
    var date: Date = Date()
    var cordsOnHand: Double = 0
    var notes: String = ""
}
