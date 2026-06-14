import SwiftUI


struct AddTaskView: View {
    let vm: TaskViewModel
    @Environment(\.dismiss) private var dismiss
    
    @State private var title = ""
    @State private var priority = Priority.medium
    @State private var note = ""
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.brown.opacity(0.2)
                    .ignoresSafeArea()
                
            ScrollView {
                    VStack(spacing: 20) {
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Task")
                                .font(.subheadline)
                                .opacity(0.7)
                                .padding(.leading, 8)
                            
                            TextField(text: $title) {
                                Text("Enter title")
                            }
                            .padding(10)
                            .padding(.vertical, 5)
                            .background(.gray.opacity(0.2))
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                        }
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Details")
                                .font(.subheadline)
                                .opacity(0.7)
                                .padding(.leading, 8)
                            
                            VStack(spacing: 10) {
                                HStack {
                                    Text("Priority")
                                    
                                    Spacer()
                                    
                                    Picker("-/-", selection: $priority) {
                                        ForEach(Priority.allCases, id: \.self) { i in
                                            Text(i.rawValue)
                                                .tag(i)
                                        }
                                    }
                                    .tint(.black)
                                    
                                }
                                
                                Divider()
                                    .padding(.horizontal, 15)
                                    .padding(.bottom, 4)
                                
                                TextField(text: $note, axis: .vertical) {
                                    Text("Note (optional)")
                                }
                                .padding(.bottom, 4)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(10)
                            .background(.gray.opacity(0.2))
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                        }
                    }
                }
                .navigationTitle("New task")
                .padding(.horizontal)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            vm.addTask(
                                title: title,
                                       note: note.isEmpty == true ? nil : note,
                                       priority: priority
                            )
                            dismiss()
                        } label: {
                            Text("Add")
                        }
                        .disabled(title.trimmingCharacters(in: .whitespaces).isEmpty)

                    }
                    
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            dismiss()
                        } label: {
                            Text("Cancel")
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    AddTaskView(vm: TaskViewModel())
}
