//
//  Task.swift
//  SwiftConcurrencyBootcamp
//
//  Created by Tibirica Neto on 2022-11-17.
//

import SwiftUI

@MainActor
class TaskBootcampViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    @Published var image2: UIImage? = nil
    
    func fetchImage() async {
        try? await Task.sleep(nanoseconds: 5_000_000_000)
        
        do {
            guard let url = URL(string: "https://picsum.photos/200") else {return}
            let (data, _) = try await URLSession.shared.data(from: url)
            let image = UIImage(data: data)
            self.image2 = image
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchImage2() async {
        do {
            guard let url = URL(string: "https://picsum.photos/200") else {return}
            let (data, _) = try await URLSession.shared.data(from: url)
            let image = UIImage(data: data)
            self.image = image
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct TaskBootcampHomeView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                NavigationLink("CLICK ME 🤓") {
                    TaskBootcamp()
                }
            }
        }
    }
}

struct TaskBootcamp: View {
    
    @StateObject private var vm = TaskBootcampViewModel()
//    @State private var fetchImageTask: Task<(), Never>? = nil
    
    var body: some View {
        VStack(spacing: 40.0) {
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 200.0, height: 200.0)
                    .scaledToFit()
            }
            
            if let image2 = vm.image2 {
                Image(uiImage: image2)
                    .resizable()
                    .frame(width: 200.0, height: 200.0)
                    .scaledToFit()
            }
        }
        .task {
            await vm.fetchImage()
        }
//        .onDisappear {
//            fetchImageTask?.cancel()
//        }
//        .onAppear {
//            fetchImageTask = Task {
//                await vm.fetchImage()
//            }
//            Task(priority: .low) {
//                print("LOW: \(Thread.current) : \(Task.currentPriority)")
//            }
//            Task(priority: .medium) {
//                print("MEDIUM: \(Thread.current) : \(Task.currentPriority)")
//            }
//            Task(priority: .high) {
//                print("HIGH: \(Thread.current) : \(Task.currentPriority)")
//            }
//            Task(priority: .background) {
//                print("BACKGROUND: \(Thread.current) : \(Task.currentPriority)")
//            }
//            Task(priority: .utility) {
//                print("UTILITY: \(Thread.current) : \(Task.currentPriority)")
//            }
//            Task(priority: .userInitiated) {
//                print("USER INITIATED: \(Thread.current) : \(Task.currentPriority)")
//            }
        //}
    }
}

struct TaskBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        TaskBootcamp()
    }
}
