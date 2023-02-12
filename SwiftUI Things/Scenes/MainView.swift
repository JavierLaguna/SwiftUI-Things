
import SwiftUI

struct MainView: View {
    
    let things = Thing.allThings()
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(things.getByType(), id: \.0.title) { typeAndThings in
                        if !typeAndThings.1.isEmpty {
                            Section(typeAndThings.0.title) {
                                ForEach(typeAndThings.1) { thing in
                                    NavigationLink(destination: thing.destination.getView) {
                                        Text(thing.title)
                                    }
                                }
                            }
                        }
                    }
                }
                
                Text("👨🏻‍💻 Javier Laguna 📱")
            }
            .navigationTitle(" SwiftUI Things! ")
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
