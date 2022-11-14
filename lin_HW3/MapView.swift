//
//  MapView.swift
//  lin_HW3
//
//  Created by User01 on 2022/11/14.
//

import SwiftUI
import MapKit
import CoreLocation

struct MapView: View {
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 25.013651, longitude: 121.214229), latitudinalMeters: 120000, longitudinalMeters: 120000)
    let stations = [
        IdentifiablePlace(lat: 25.052824, long: 121.607155, name: "南港"),
        IdentifiablePlace(lat: 25.047782, long: 121.51715, name: "台北"),
        IdentifiablePlace(lat: 25.013621, long: 121.464241, name: "板橋"),
        IdentifiablePlace(lat: 25.013651, long: 121.214229, name: "桃園"),
        IdentifiablePlace(lat: 24.808256, long: 121.04021, name: "新竹"),
        IdentifiablePlace(lat: 24.60555, long: 120.825509, name: "苗栗")
    ]
    var body: some View {
        Map(coordinateRegion: $region, annotationItems: stations) { station in
            MapAnnotation(coordinate: station.location) {
                Text(station.name)
                    .foregroundColor(.black)
                    .background(Capsule())
            }
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}

struct IdentifiablePlace: Identifiable {
    let id = UUID()
    let location: CLLocationCoordinate2D
    let name: String
    init(lat: Double, long: Double, name: String) {
        location = CLLocationCoordinate2D(
            latitude: lat,
            longitude: long)
        self.name = name
    }
}
