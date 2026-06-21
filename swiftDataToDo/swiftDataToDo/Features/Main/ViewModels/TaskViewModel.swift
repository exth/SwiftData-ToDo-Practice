import Foundation
import SwiftData


@Observable
final class TaskViewModel {
    private var context: ModelContext?
    
    //
    func configure(with context: ModelContext) {
        self.context = context
    }
    
    //
    func addTask(title: String, note: String?, priority: Priority) {
        guard let context else {
            return
        }
        
        let trimmedTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedTitle.isEmpty else {
            return
        }
        
        let task = Task(
            title: trimmedTitle,
            note: note?.isEmpty == true ? nil : note,
            priority: priority
        )
        
        context.insert(task)
    }
    
    //
    func deleteTask(_ task: Task) {
        guard let context else {
            return
        }
        
        context.delete(task)
    }
    
// MARK: In the future, add the commented func below to display completed tasks separately
//    func toggleComplete(_ task: Task) {
//        task.isCompleted.toggle()
//    }
}
