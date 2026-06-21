import XCTest
import SwiftData

@testable import swiftDataToDo


@MainActor
final class TaskViewModelTests: XCTestCase {
    var container: ModelContainer!
    var context: ModelContext!
    var vm: TaskViewModel!

    override func setUp() {
        super.setUp()
        container = try! ModelContainer(
            for: Task.self,
            configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        context = container.mainContext
        vm = TaskViewModel()
        vm.configure(with: context)
    }

    override func tearDown() {
        container = nil
        context = nil
        vm = nil
        super.tearDown()
    }
    
    private func fetchAll() -> [Task] {
        let descriptor = FetchDescriptor<Task>()
        return (try? context.fetch(descriptor)) ?? []
    }
    
    func test_addTask_shouldAddOneTask() {
        let title = "task one"
        
        vm.addTask(title: title, note: nil, priority: .medium)
 
        let tasks = fetchAll()
        XCTAssertEqual(tasks.count, 1)
        XCTAssertEqual(tasks.first?.title, title)
    }
    
    
    func test_addTask_shoudDeleteSpaces() {
        let title = "   test, delete spaces      "
        
        vm.addTask(title: title, note: nil, priority: .medium)
        
        let task = fetchAll().first
        XCTAssertEqual(task?.title, "test, delete spaces")
    }
    
    
    func test_addTask_shouldNotAddOnlySpaces() {
        let title = "      "
        
        vm.addTask(title: title, note: nil, priority: .medium)

        XCTAssertEqual(fetchAll().count, 0)
    }
    
    
    func test_delete_shouldRemoveTask() {
        vm.addTask(title: "test title", note: nil, priority: .medium)
        let task = fetchAll().first!
        
        vm.deleteTask(task)
        
        XCTAssertEqual(fetchAll().count, 0)
    }
}
