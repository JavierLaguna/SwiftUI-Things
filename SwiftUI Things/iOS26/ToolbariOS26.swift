import SwiftUI

struct ToolbariOS26: View {
    
    var body: some View {
        if #available(iOS 26.0, *) {
            NavigationStack {
                List {
                    ForEach(1...50, id: \.self) { index in
                        NavigationLink(value: "") {
                            Text("Item \(index)")
                        }
                    }
                }
                .navigationTitle("navigationTitle")
                .navigationSubtitle("navigationSubtitle")
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Options", systemImage: "ellipsis") {
                            
                        }
                    }
                    
                    ToolbarSpacer(placement: .topBarLeading)
                    
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Speaker", systemImage: "speaker") {
                            
                        }
                    }
                    .sharedBackgroundVisibility(.hidden)
                    
                    ToolbarItemGroup {
                        Button("Remove", systemImage: "minus") {
                            print("Remove")
                        }
                        
                        Label("Add", systemImage: "plus")
                    }
                    
                    ToolbarItem(placement: .bottomBar) {
                        Button("Person", systemImage: "person") {
                            
                        }
                    }
                    
                    ToolbarItemGroup(placement: .bottomBar) {
                        Button("Person Fill", systemImage: "person.fill") {
                            
                        }
                        
                        Button("NoIcon", systemImage: "") {
                            
                        }
                    }
                }
                .navigationDestination(for: String.self) { value in
                    Text("navigationDestination")
                        .navigationTitle(value)
                        .toolbar {
                            ToolbarItemGroup {
                                Button("Remove", systemImage: "minus") {
                                    print("Remove")
                                }
                                
                                Label("Speaker", systemImage: "speaker")
                                Label("Speaker", systemImage: "speaker.zzz")
                                Label("Speaker", systemImage: "speaker.2")
                                Label("Speaker", systemImage: "badge.plus.radiowaves.right")
                                Label("Speaker", systemImage: "goforward")
                                        
                                Button("Add", systemImage: "plus") {
                                    print("ADD")
                                }
                                
                                Button("Sun", systemImage: "sun.min.fill") {
                                    print("Sun")
                                }
                            }
                            
                            ToolbarItem(placement: .bottomBar) {
                                Button("Person", systemImage: "person") {
                                    
                                }
                            }
                            
                            ToolbarSpacer(.flexible, placement: .bottomBar)
                            
                            ToolbarItemGroup(placement: .bottomBar) {
                                Button("Person Fill", systemImage: "person.fill") {
                                    
                                }
                                
                                Button("Person Slash", systemImage: "person.slash") {
                                    
                                }
                            }
                        }
                }
            }
            
        } else {
            Text("iOS 26 device required")
        }
    }
}

#Preview {
    ToolbariOS26()
}
