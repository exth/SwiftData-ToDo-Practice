import SwiftUI
import SwiftData


@main
struct testSD2App: App {
    var body: some Scene {
        WindowGroup {
            TasksView()
        }
        .modelContainer(for: Task.self)
    }
}
