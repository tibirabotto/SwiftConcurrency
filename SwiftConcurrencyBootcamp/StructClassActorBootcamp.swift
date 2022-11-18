//
//  StructClassActorBootcamp.swift
//  SwiftConcurrencyBootcamp
//
//  Created by Tibirica Neto on 2022-11-18.
//

/*

 */



import SwiftUI

struct StructClassActorBootcamp: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onAppear {
//                classTest2()
//                structTest2()
//                structTest1()
//                printDivider()
//                classTest1()
                actorTest1()
            }
    }
}

struct MyStruct {
    var title: String
}



struct StructClassActorBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        StructClassActorBootcamp()
    }
}

extension StructClassActorBootcamp {
    private func runTest() {
        print("Test started")
    }
    
    private func printDivider() {
        print("""
             - - - - - - - - - - - - - -
        """)
    }
    
    private func structTest1() {
        print("structTest1")
        let objectA = MyStruct(title: "Starting title!")
        print("ObjectA: \(objectA.title)")
        
        print("Pass the VALUES of objectA to objectB.")
        var objectB = objectA
        print("ObjectB: \(objectB.title)")
        
        objectB.title = "Seconde title!"
        print("ObjectB: title changed")
        
        print("ObjectA: \(objectA.title)")
        print("ObjectB: \(objectB.title)")
    }
    
    private func classTest1() {
        print("classTest1")
        var objectA = Myclass(title: "Starting title!")
        print("ObjectA: \(objectA.title)")
        
        var objectB = objectA
        print("ObjectB: \(objectB.title)")
        
        objectB.title = "Seconde title!"
        print("ObjectB: title changed")
        
        print("ObjectA: \(objectA.title)")
        print("ObjectB: \(objectB.title)")
    }
    
    private func actorTest1() {
        Task {
            print("classTest1")
            let objectA = MyActor(title: "Starting title!")
            await print("ObjectA: \(objectA.title)")
            
            let objectB = objectA
            await print("ObjectB: \(objectB.title)")
            
            await objectB.updateTitle(newTitle: "Second Title")
            print("ObjectB: title changed")
            
            await print("ObjectA: \(objectA.title)")
            await print("ObjectB: \(objectB.title)")
        }
    }
}


struct CustomStruct {
    let title: String
    
    init(title: String) {
        self.title = title
    }
    
    func updateTitle(newTitle: String) -> CustomStruct{
        CustomStruct(title: newTitle)
    }
}

struct MutatingStruct {
    private(set) var title: String
    
    mutating func updateTitle(newTitle: String) {
       title = newTitle
    }
}

extension StructClassActorBootcamp {
    private func structTest2() {
        print("structTest2")
        
        var struct1 = MyStruct(title: "title1")
        print("Struct1:  \(struct1.title)")
        struct1.title = "Title2"
        print("Struct1: \(struct1.title)")
        
        var struct2 = CustomStruct(title: "Title1")
        print("Struct2: \(struct2.title)")
        struct2 = CustomStruct(title: "Title2")
        print("Struct2: \(struct2.title)")
        
        var struct3 = CustomStruct(title: "Title1")
        print("Struct3: \(struct3.title)")
        struct3 = struct3.updateTitle(newTitle: "Title2")
        print("Struct3: \(struct3.title)")
        printDivider()
        var struct4 = MutatingStruct(title: "Title1")
        print("Struct4: \(struct4.title)")
        struct4.updateTitle(newTitle: "Title2")
        print("Struct: \(struct4.title)")
    }
}

class Myclass {
    var title: String
    
    init(title: String) {
        self.title = title
    }
    
    func updateTitle(newTitle: String) {
            title = newTitle
    }
}

actor MyActor {
    var title: String
    
    init(title: String) {
        self.title = title
    }
    
    func updateTitle(newTitle: String) {
            title = newTitle
    }
}

extension StructClassActorBootcamp {
    
    private func classTest2() {
        print("classTest2")
        
        let class1 = Myclass(title: "Title2")
        print("Class1: \(class1.title)")
        class1.title = "Title2"
        print("Class1: \(class1.title)")
        
        let class2 = Myclass(title: "Title1")
        print("Class2: \(class2.title)")
        class2.updateTitle(newTitle: "Title2")
        print("Class2: \(class2.title)")
    }
}
