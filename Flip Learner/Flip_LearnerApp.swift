//
//  Flip_LearnerApp.swift
//  Flip Learner
//
//  Created by Apple  on 21/05/23.
//

import SwiftUI

@main
struct Flip_LearnerApp: App {
    @StateObject private var dataController = DataController()
    @StateObject private var flashCardVm = FlashCardViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .environmentObject(flashCardVm)
        }
    }
}
