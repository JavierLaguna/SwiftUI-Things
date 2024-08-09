import SwiftUI
import MapKit

struct MapExample: View {
    
    private let location = CLLocationCoordinate2D(
        latitude: 41.8902,
        longitude: 12.4922
    )
    
    @State private var style = 0
    
    private var mapStyle: MapStyle {
        switch style {
        case 0: .standard
        case 1: .standard(
            elevation: .realistic,
            emphasis: .muted,
            pointsOfInterest: .excluding([
                .bakery,
                .airport,
                .amusementPark
            ]),
            showsTraffic: true
        )
        case 2: .imagery
        case 3: .imagery(elevation: .realistic)
        case 4: .hybrid
        case 5: .hybrid(
            elevation: .realistic,
            pointsOfInterest: .excludingAll,
            showsTraffic: true
        )
        default: .standard
        }
    }
    
    var body: some View {
        VStack {
            
            Map(initialPosition:
                    .camera(MapCamera(
                        centerCoordinate: .init(
                            latitude: location.latitude,
                            longitude: location.longitude
                        ),
                        distance: 800,
                        heading: 40,
                        pitch: 80
                    ))
            ) {
                Marker("Colosseum", coordinate: location)
            }
            .mapControls {
                MapUserLocationButton()
                
                /// Shows up when you pitch to zoom
                MapScaleView()
                /// Shows up when you rotate the map
                MapCompass()
                /// 3D and 2D button on the top right
                MapPitchToggle()
            }
            .mapStyle(mapStyle)
            
            Picker("Map Style", selection: $style) {
                Text("Standard").tag(0)
                Text("Standard Custom").tag(1)
                Text("Imagery").tag(2)
                Text("Imagery Custom").tag(3)
                Text("Hybrid").tag(4)
                Text("Hybrid Custom").tag(5)
            }
            .padding()
        }
    }
}

#Preview {
    MapExample()
}
