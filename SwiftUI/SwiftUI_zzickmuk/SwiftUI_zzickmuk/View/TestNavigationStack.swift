//
//  TestNavigationStack.swift
//  SwiftUI_zzickmuk
//
//  Created by 박현준 on 2/29/24.
//

import SwiftUI

struct TestNavigationStack: View {
    let appleProducts = ["Mac", "Macbook", "iPhone", "iPad"]
    @State private var stackPath: NavigationPath = .init()
    
    var body: some View {
        NavigationStack(path: $stackPath) {
            List(appleProducts, id: \.self) { product in
                Button {
                    stackPath.append(product)
                } label: {
                    Text(product)
                        .font(.body)
                        .bold()
                }
                
                Button {
                    stackPath.append(1)
                } label: {
                    Text("넘버로 Nav")
                }
            }
            .navigationTitle("네비게이션 스택")
            .navigationDestination(for: String.self) { product in
                AppleProductView(product: product, path: $stackPath)
            }
            .navigationDestination(for: Int.self) { number in
                Text("\(number)가 선택되었습니다.")
            }
        }
    }
}

struct AppleProductView: View {
    let product: String
    @Binding var path: NavigationPath
    
    var body: some View {
        VStack(spacing: 20) {
            Text(product)
                .font(.largeTitle)
                .onTapGesture {
                    path.append("세번째 혹은 더 깊이")
                }
            
            Text("모두 없애기")
                .onTapGesture {
                    path = .init()
                }
        }
    }
}

//@MainActor
//class FirstDestinationViewModel: ObservableObject {
//    @Published var image: UIImage? = nil
//    
//    init() {
//        downloadImage()
//    }
//    
//    func downloadImage() {
//        Task {
//            let url = URL(string: "https://picsum.photos/200")!
//            let (data, response) = try await URLSession.shared.data(from: url)
//            
//            if let image = UIImage(data: data) {
//                self.image = image
//                print("이미지 다운로드 완료")
//            }
//        }
//    }
//}

//struct FirstDestinationView: View {
//    @StateObject private var viewModel: FirstDestinationViewModel
//    
//    init(viewModel: FirstDestinationViewModel) {
//        _viewModel = StateObject(wrappedValue: viewModel)
//        print("목적지뷰 생성")
//    }
//    
//    var body: some View {
//        VStack {
//            if let image = viewModel.image {
//                Image(uiImage: image)
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 200, height: 200)
//            }
//            Text("목적지")
//        }
//    }
//}

#Preview {
    TestNavigationStack()
}
