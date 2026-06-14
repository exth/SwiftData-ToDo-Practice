import SwiftUI
import SwiftData


struct RowTaskView: View {
    let task: Task
    let vm: TaskViewModel
    
    var body: some View {
        HStack {
            Button {
                withAnimation {
                    vm.deleteTask(task)
                }
            } label: {
                Image(systemName: task.isCompleted ? "checkmark.circle" : "circle")
                    .foregroundStyle(.black)
            }
            
            VStack(alignment: .leading, spacing: 3) {
                Text(task.title)
                    .strikethrough(task.isCompleted)
                
                if let note = task.note {
                    Text(note)
                        .font(.caption)
                        .foregroundStyle(.gray)
                }
            }
            
            Spacer()

            Circle()
                .fill(priorityColor)
                .frame(width: 10, height: 10)
        }
        .padding(.horizontal)
    }
    
    
    private var priorityColor: Color {
        switch task.priority {
        case .high:
            return .red
        case .medium:
            return .orange
        case .low:
            return .green
        }
    }
}

#Preview {
    RowTaskView(task: Task(title: "Task number one"), vm: TaskViewModel())
        .modelContainer(for: Task.self, inMemory: true)
}
