//
//  GlobalActorBootcamp.swift
//  SwiftConcurrencyBootcamp
//
//  Created by Tibirica Neto on 2022-11-19.
//

import SwiftUI
//
//@globalActor final class MyFirstGlobalActor {
//        static var shared = MyNewDataManager()
//}

class MyNewDataManager {
    
    func getDataFromDatabase()  -> [String] {
        return ["One", "Two", "Three", "Four", "Five", "Six"]
    }
}

@MainActor
class GlobalActorBootcampModalView: ObservableObject {
    @Published var dataArray: [String] = []
    let manager = MyNewDataManager()
    

    func getData() async {
        let data = manager.getDataFromDatabase()
        self.dataArray = data
    }
}

struct GlobalActorBootcamp: View {
    
    @StateObject private var vm = GlobalActorBootcampModalView()
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(vm.dataArray, id: \.self) {
                    Text($0)
                        .font(.headline)
                }
            }
        }
        .task {
             await vm.getData()
        }
    }
}

struct GlobalActorBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        GlobalActorBootcamp()
    }
}
