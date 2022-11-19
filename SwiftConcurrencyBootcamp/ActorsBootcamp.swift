//
//  ActorsBootcamp.swift
//  SwiftConcurrencyBootcamp
//
//  Created by Tibirica Neto on 2022-11-18.
//

import SwiftUI

class MyDataManager {
    static let instance = MyDataManager()
    private init() {}
    var data: [String] = []
    private let lock = DispatchQueue(label: "com.MyApp.MyDataManager")
    
    func getRandomData(complatationHandler: @escaping (_ title: String?) -> ())  {
        lock.async {
            self.data.append(UUID().uuidString)
            
            complatationHandler(self.data.randomElement())

        }
        
    }
}

actor MyActorDataManager {
    static let instance = MyActorDataManager()
    private init() {}
    var data: [String] = []

    
    func getRandomData() -> String? {
        self.data.append(UUID().uuidString)
        return self.getRandomData()
    }
    
    nonisolated func getSaveData() -> String {
        return "New Data"
    }
}

struct HomeView: View {
    
    let manager = MyActorDataManager.instance
    @State private var text: String = ""
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack{
            Color.gray.opacity(0.8).ignoresSafeArea()
            
            Text(text)
                .font(.headline)
        }
        .onAppear {
            
            Task {
                let newString = await manager.getSaveData()
            }
        }
        .onReceive(timer) { _ in
            Task {
                if let data = await manager.getRandomData() {
                    await MainActor.run(body: {
                        self.text = data
                    })
                }
            }
//            DispatchQueue.global(qos: .background).async {
//                manager.getRandomData { title in
//                    if let data = title {
//                        DispatchQueue.main.async {
//                            self.text = data
//                        }
//                    }
//                }
//            }
            
        }
    }
}

struct BrowseView: View {
    let manager = MyActorDataManager.instance
    @State private var text: String = ""
    let timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack{
            Color.yellow.opacity(0.8).ignoresSafeArea()
            Text(text)
                .font(.headline)
        }
        .onReceive(timer) { _ in
            Task {
                if let data = await manager.getRandomData() {
                    await MainActor.run(body: {
                        self.text = data
                    })
                }
            }
//            DispatchQueue.global(qos: .default).async {
//                manager.getRandomData { title in
//                    if let data = title {
//                        DispatchQueue.main.async {
//                            self.text = data
//                        }
//                    }
//                }
//            }
        }
    }
}

struct ActorsBootcamp: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            BrowseView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
        }
    }
}

struct ActorsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ActorsBootcamp()
    }
}
