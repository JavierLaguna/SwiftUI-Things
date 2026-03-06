import SwiftUI

extension TagStatusExample: CustomComponentThing {
    static let title = "TagStatus"
    static func makeView() -> some View { Self() }
}

struct TagStatusExample: View {
    
    var body: some View {
        VStack(spacing: 16) {
            TagStatusView(status: .pending)
            TagStatusView(status: .inProgress)
            TagStatusView(status: .submitted)
            TagStatusView(status: .inReview)
            TagStatusView(status: .success)
            TagStatusView(status: .failed)
            TagStatusView(status: .expired)
        }
        .padding(32)
        .background(Color.white)
    }
}

struct TagStatusView: View {
    
    let status: Status
    
    var body: some View {
        HStack(spacing: 6) {
            Image(systemName: status.icon)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(status.textColor)
            
            Text(status.label)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(status.textColor)
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 8)
        .background(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(status.backgroundColor)
        )
    }
}

enum Status {
    case pending
    case inProgress
    case submitted
    case inReview
    case success
    case failed
    case expired
    
    var label: String {
        switch self {
        case .pending:    "Pending"
        case .inProgress: "In progress"
        case .submitted:  "Submitted"
        case .inReview:   "In review"
        case .success:    "Success"
        case .failed:     "Failed"
        case .expired:    "Expired"
        }
    }
    
    var icon: String {
        switch self {
        case .pending:    "exclamationmark.triangle"
        case .inProgress: "circle.dashed"
        case .submitted:  "paperplane"
        case .inReview:   "arrow.clockwise.circle"
        case .success:    "checkmark.circle"
        case .failed:     "xmark.circle"
        case .expired:    "clock"
        }
    }
    
    var textColor: Color {
        switch self {
        case .pending:    Color(red: 0.89, green: 0.55, blue: 0.18)
        case .inProgress: Color(red: 0.25, green: 0.55, blue: 0.95)
        case .submitted:  Color(red: 0.53, green: 0.35, blue: 0.85)
        case .inReview:   Color(red: 0.89, green: 0.45, blue: 0.20)
        case .success:    Color(red: 0.18, green: 0.65, blue: 0.35)
        case .failed:     Color(red: 0.85, green: 0.25, blue: 0.25)
        case .expired:    Color(red: 0.50, green: 0.50, blue: 0.50)
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case .pending:    Color(red: 1.00, green: 0.95, blue: 0.85)
        case .inProgress: Color(red: 0.88, green: 0.94, blue: 1.00)
        case .submitted:  Color(red: 0.93, green: 0.89, blue: 0.99)
        case .inReview:   Color(red: 1.00, green: 0.93, blue: 0.85)
        case .success:    Color(red: 0.88, green: 0.97, blue: 0.90)
        case .failed:     Color(red: 1.00, green: 0.90, blue: 0.90)
        case .expired:    Color(red: 0.94, green: 0.94, blue: 0.94)
        }
    }
}

#Preview {
    TagStatusExample()
}
