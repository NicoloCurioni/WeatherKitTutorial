//
//  UserLocationData.swift
//  WeatherKitTutorial
//
//  Created by Nicolò Curioni on 17/08/22.
//

import Foundation
import os.log

@MainActor
class UserLocationData: ObservableObject {
    let logger = Logger(subsystem: "com.example.WeatherKitTutorial.UserLocationData", category: "Model")
    
    /// The list of user locations.
    @Published private(set) var userLocations: [UserLocation]
    
    init(userLocations: [UserLocation] = []) {
        self.userLocations = userLocations
    }
    
    private let store = Store()
    
    /// Asynchronously read the userLocation data from disk.
    func load() async {
        userLocations = await store.load()
    }
}

extension UserLocationData {
    private actor Store {
        let logger = Logger(subsystem: "com.example.WeatherKitTutorial.UserLocationData.Store", category: "ModelIO")
        
        func load() -> [UserLocation] {
            load(from: .main)
        }
        
        private func load(from bundle: Bundle) -> [UserLocation] {
            // Read the data from a background queue.
            logger.debug("Loading the data from disk.")
            
            var userLocations: [UserLocation]
            
            do {
                
                // Load the userLocation data from a binary JSON file.
                let data = try Data(contentsOf: Store.dataURL, options: .mappedIfSafe)
                
                // Decode the data.
                userLocations = try JSONDecoder().decode([UserLocation].self, from: data)
                
            } catch CocoaError.fileReadNoSuchFile {
                logger.debug("No file found -- creating an empty userLocation list.")
                userLocations = []
            } catch {
                logger.error("*** An error occurred while loading the userLocation list: \(error.localizedDescription) ***")
                fatalError()
            }
            
            return userLocations
        }
        
        // Provide the URL for the JSON file that stores the UserLocation data.
        fileprivate static var dataURL: URL {
            get throws {
                let bundle = Bundle.main
                
                guard let path = bundle.path(forResource: "UserLocations", ofType: "json") else {
                    throw CocoaError(.fileReadNoSuchFile)
                }
                
                return URL(fileURLWithPath: path)
            }
        }
        
    }
}
