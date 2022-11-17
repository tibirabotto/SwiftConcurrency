//
//  AsyncAwait.swift
//  SwiftConcurrencyBootcamp
//
//  Created by Tibirica Neto on 2022-11-17.
//

import SwiftUI

@MainActor
class AsyncAwaitViewModel: ObservableObject {
    @Published var dataArray: [String] = []
    
    func addTitle1() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.dataArray.append("Title 1 \(Thread.current)")
        }
        
    }
    
    func addTitle2() {
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            let title = "title 2: \(Thread.current)"
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.dataArray.append(title)
                
                let title3 = "Title 2: \(Thread.current)"
                self.dataArray.append(title3)
            }
        }
    }
    
    func addAuthor1() async {
        let author1 = "Author 1"
        self.dataArray.append(author1)
        
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        let author2 = "Author 2"
        self.dataArray.append(author2)
    }
    
    func addSomething() async  {
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        let something1 = "Something 1 "
        self.dataArray.append(something1)
        
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        let something2 = "Something  2 "
        self.dataArray.append(something2)
    }
}

struct AsyncAwait: View {
    
    @StateObject private var vm = AsyncAwaitViewModel()
    
    var body: some View {
        List {
            ForEach(vm.dataArray, id: \.self) { data in
                Text(data)
            }
        }
        .onAppear {
            Task {
                await vm.addAuthor1()
                await vm.addSomething()
            }
           // vm.addTitle1()
            //vm.addTitle2()
        }
    }
}

struct AsyncAwait_Previews: PreviewProvider {
    static var previews: some View {
        AsyncAwait()
    }
}
