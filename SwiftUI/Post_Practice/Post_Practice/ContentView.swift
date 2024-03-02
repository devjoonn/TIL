//
//  ContentView.swift
//  Post_Practice
//
//  Created by 박현준 on 3/2/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            TabView {
                Forum()
                    .tabItem {
                        Image(systemName: "bubble.right")
                    }
                Text("두번째 탭")
                    .tabItem {
                        Image(systemName: "house")
                    }
            }
            .navigationTitle("Scrum 스터디 방")
        }
    }
}

struct Forum: View {
    @State private var list: [Post] = Post.list
    @State private var showAddView: Bool = false
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(list) { post in
                    NavigationLink {
                        PostDetail(post: post)
                    } label: {
                        PostRow(post: post)
                    }
                    .tint(.primary)
                }
            }
        }
        .refreshable { }
        .safeAreaInset(edge: .bottom, alignment: .trailing) {
            Button {
                showAddView = true
            } label: {
                Image(systemName: "plus")
                    .font(.largeTitle)
                    .padding()
                    .background(Circle().fill(.white).shadow(radius: 4))
            }
            .padding()
        }
        .sheet(isPresented: $showAddView) {
            // postAdd 에서 게시 버튼을 눌렀을 때 action
            PostAdd { post in
                list.insert(post, at: 0)
            }
        }
    }
}

struct PostAdd: View {
    @FocusState private var isFocused: Bool
    @Environment(\.dismiss) private var dismiss
    @State private var text: String = ""
    
    let postAction: (_ post: Post) -> ()
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("포스트를 입력해주세요..", text: $text)
                    .font(.title)
                    .padding()
                    .padding(.top)
                    .focused($isFocused)
                    .onAppear { isFocused = true }
                Spacer()
            }
            .navigationTitle("포스트 게시")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("취소") { dismiss() }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("게시") {
                        let newPost = Post(username: "유저이름", content: text)
                        postAction(newPost)
                        dismiss()
                    }
                }
            }
        }
    }
}

struct PostDetail: View {
    let post: Post
    
    var body: some View {
        VStack(spacing: 20) {
            Text(post.username)
                .font(.title)
            Text(post.content)
                .font(.body)
            
            Button {
                
            } label: {
                HStack {
                    Image(systemName: "pencil")
                    Text("수정")
                }
                .tint(.indigo)
            }
        }
    }
}

struct PostRow: View {
    let post: Post
    let color: [Color] = [.red, .orange, .yellow, .green, .blue, .purple, .brown, .mint]
    
    var body: some View {
        HStack {
            Circle()
                .fill(color.randomElement() ?? .indigo)
                .frame(width: 30)
            
            VStack(alignment: .leading) {
                Text(post.username)
                    .font(.title)
                Text(post.content)
                    .font(.body)
            }
            Spacer()
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 10)
                .strokeBorder()
        }
        .padding()
    }
}

struct Post: Identifiable {
    let id = UUID()
    let username: String
    let content: String
}

extension Post {
    static var list: [Post] = [
        Post(username: "사용자A", content: "사용자 A의 content입니다."),
        Post(username: "사용자B", content: "사용자 B의 content입니다."),
        Post(username: "사용자C", content: "사용자 C의 content입니다."),
        Post(username: "사용자D", content: "사용자 D의 content입니다."),
        Post(username: "사용자E", content: "사용자 E의 content입니다."),
        Post(username: "사용자F", content: "사용자 F의 content입니다.")
    ]
}

#Preview {
    ContentView()
//    PostRow(post: Post(username: "사용자A", content: "사용자 A의 content입니다."))
//    PostDetail(post: Post(username: "사용자A", content: "사용자 A의 content입니다."))
//    PostAdd()
//    NavigationView {
//        Forum()
//    }
}
