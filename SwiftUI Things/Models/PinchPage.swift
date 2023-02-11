
struct PinchPage: Identifiable {
    let id: Int
    let imageName: String
}

extension PinchPage {
    
    var thumbnailName: String {
        return "thumb-" + imageName
    }
}

extension PinchPage {
    
   static var allPages: [PinchPage] {
        return [
            PinchPage(id: 1, imageName: "magazine-front-cover"),
            PinchPage(id: 2, imageName: "magazine-back-cover")
        ]
    }
}
