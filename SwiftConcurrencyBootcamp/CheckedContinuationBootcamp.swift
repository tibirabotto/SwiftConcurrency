//
//  CheckedContinuationBootcamp.swift
//  SwiftConcurrencyBootcamp
//
//  Created by Tibirica Neto on 2022-11-18.
//

import SwiftUI

class CheckedContinuationBootcampViewModelManager {
    func getData(url: URL) async throws -> Data {
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return data
        } catch {
            throw error
        }
    }
    
    func getData2(url: URL) async throws -> Data {
        return try await withCheckedThrowingContinuation { continuation in
            URLSession.shared.dataTask(with: url) { data, _, error in
                if let data = data {
                    continuation.resume(returning: data)
                } else if let error = error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume(throwing: URLError(.badURL))
                }
            }
            .resume()
        }
    }
    
    func getHeartImageFromDatabase(completationHandler: @escaping (_ image: UIImage) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            completationHandler(UIImage(systemName: "heart.fill")!)
        }
    }
    
    func getHeartImageFromDatabase() async -> UIImage {
        return await withCheckedContinuation { contination in
            getHeartImageFromDatabase { image in
                contination.resume(returning: image)
            }
        }
    }
    
}

@MainActor
class CheckedContinuationBootcampViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    let networdManager = CheckedContinuationBootcampViewModelManager()
    
    func getImage() async {
        guard let url = URL(string: "https://picsum.photos/300") else {return}
        do {
            let data = try await networdManager.getData2(url: url)
            if let image = UIImage(data: data) {
                self.image = image
            }
        } catch {
            print(error)
        }
    }
    
    func getHeartImage() async {
//        networdManager.getHeartImageFromDatabase { [weak self] image in
//            self?.image = image
//        }
        let image = await networdManager.getHeartImageFromDatabase()
        self.image = image
    }
}

struct CheckedContinuationBootcamp: View {
    
    @StateObject private var vm = CheckedContinuationBootcampViewModel()
    
    var body: some View {
        ZStack {
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            }
        }
        .task {
            await vm.getHeartImage()
            //await vm.getImage()
        }
    }
}

struct CheckedContinuationBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        CheckedContinuationBootcamp()
    }
}
