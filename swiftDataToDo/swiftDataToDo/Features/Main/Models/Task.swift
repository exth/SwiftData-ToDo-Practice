import Foundation
import SwiftData


@Model
final class Task {
    var title: String
    var note: String?
    var priority: Priority
    var isCompleted: Bool
    var createdAt: Date
    
    init(title: String,
         note: String? = nil,
         priority: Priority = .medium
    ) {
        self.title = title
        self.note = note
        self.priority = priority
        self.isCompleted = false
        self.createdAt = Date()
    }
}
