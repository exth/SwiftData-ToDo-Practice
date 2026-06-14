import SwiftUI
import SwiftData


struct TasksView: View {
    @Query(
        filter: #Predicate<Task> {
            $0.isCompleted == false
        },
        sort: \Task.createdAt,
        order: .reverse,
        animation: .bouncy
    ) var tasks: [Task]
    
    @Environment(\.modelContext) private var context
    
    @State private var vm = TaskViewModel()
    
    @State private var showSheet = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.brown.opacity(0.1)
                    .ignoresSafeArea()
                
                if tasks.isEmpty {
                    Text("Please, add task")
                        .opacity(0.7)
                        .offset(y: -50)
                } else {
                    ScrollView {
                        VStack {
                            ForEach(tasks) { task in
                                RowTaskView(task: task, vm: vm)
                            }
                        }
                        .padding(.top, 10)
                    }
                }
            }
            .navigationTitle("Tasks")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showSheet = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showSheet) {
                AddTaskView(vm: vm)
            }
            .onAppear {
                vm.configure(with: context)
            }
        }
    }
}

#Preview {
    TasksView()
        .modelContainer(for: Task.self, inMemory: true)
}
