// Credits: Kavsoft
// https://www.youtube.com/watch?v=5Bmi8tlb4bg

import SwiftUI

extension CalendarAppExample: SampleAppThing {
    static let title = "Calendar App"
    static func makeView() -> some View { Self() }
}

struct CalendarAppExample: View {
    
    var body: some View {
        CalendarView()
    }
}

#Preview {
    CalendarAppExample()
}
