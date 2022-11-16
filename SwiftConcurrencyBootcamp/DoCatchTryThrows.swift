//
//  DoCatchTryThrows.swift
//  SwiftConcurrencyBootcamp
//
//  Created by Tibirica Neto on 2022-11-16.
//

import SwiftUI

class DoCatchTryThrowsDataManager {
    
    let isActive: Bool = true
    
    func getTitle() -> (title: String?, error: Error?) {
        if isActive {
            return ("NEW TEXT", nil)
        } else {
            return (nil, URLError(.badURL))
        }
        
    }
    
    func getTitle2() -> Result<String, Error> {
        if isActive {
            return .success("NEW TEXT")
        } else {
            return .failure(URLError(.badURL))
        }
        
    }
    
    func getTitle3() throws -> String {
        if isActive {
            return "NEW TEXT"
        } else {
            throw URLError(.badServerResponse)
        }

    }
    
    func getTitle4() throws -> String {
        if isActive {
            return "FINAL TEXT"
        } else {
            throw URLError(.badServerResponse)
        }

    }
}

class DoCatchTryThrowsViewModel: ObservableObject {
    @Published var text: String = "Starting text."
    let manager = DoCatchTryThrowsDataManager()
    
    func fetchTitle() {
        //        let returnedValue = manager.getTitle()
        //
        //        if let newTitle = returnedValue.title {
        //            self.text = newTitle
        //        } else if let error = returnedValue.error {
        //            self.text = error.localizedDescription
        //        }
        
        //        let result = manager.getTitle2()
        //
        //        switch result {
        //        case .success(let newTitle):
        //            self.text = newTitle
        //        case .failure(let error):
        //            self.text = error.localizedDescription
        //        }
        
        let newTitle = try? manager.getTitle3()
        guard let newTitle = newTitle else {return}
        self.text = newTitle
        
//        do {
//            let newTitle = try manager.getTitle3()
//            self.text = newTitle
//            let finalTitle = try manager.getTitle4()
//            self.text = finalTitle
//            
//        } catch {
//            self.text = error.localizedDescription
//        }
    }
}

struct DoCatchTryThrows: View {
    
    @StateObject private var vm = DoCatchTryThrowsViewModel()
    var body: some View {
        Text(vm.text)
            .frame(width: 300, height: 300)
            .background(Color.blue)
            .onTapGesture {
                vm.fetchTitle()
            }
            
    }
}

struct DoCatchTryThrows_Previews: PreviewProvider {
    static var previews: some View {
        DoCatchTryThrows()
    }
}
