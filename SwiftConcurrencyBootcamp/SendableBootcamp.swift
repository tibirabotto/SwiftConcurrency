//
//  SendableBootcamp.swift
//  SwiftConcurrencyBootcamp
//
//  Created by Tibirica Neto on 2022-11-19.
//

import SwiftUI

actor CurrentUserManager {
    
    func updateDatabase(userInfor: MyClassUserInfo) {
        
    }
}

struct MyUserInfo: Sendable {
    let name: String
}

final class MyClassUserInfo: Sendable {
    let name: String
    
    init(name: String) {
        self.name = name
    }
}

class SendableBootcampViewModel: ObservableObject {
    let manager = CurrentUserManager()
    
    func updateCurrentUserInfo() async {
        
        let info = MyClassUserInfo(name: "info")
        
        await manager.updateDatabase(userInfor: info)
    }
}


struct SendableBootcamp: View {
    
    @StateObject private var vm = SendableBootcampViewModel()
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .task {
                
            }
    }
}

struct SendableBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        SendableBootcamp()
    }
}
