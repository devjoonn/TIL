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
    @State private var newPost = Post(username: "유저 이름", content: "")
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach($list) { $post in
                    NavigationLink {
                        PostDetail(post: $post)
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
        .fullScreenCover(isPresented: $showAddView) {
            NavigationView {
                PostAdd(editingPost: $newPost)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button("취소") {
                                newPost = Post(username: "유저 이름", content: "")
                                showAddView = false
                            }
                        }
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button("게시") {
                                list.insert(newPost, at: 0)
                                showAddView = false
                                newPost = Post(username: "유저 이름", content: "")
                            }
                        }
                    }
            }
        }
    }
}

struct PostAdd: View {
    @FocusState private var isFocused: Bool
    @Binding var editingPost: Post
    
    var body: some View {
        VStack {
            TextField("포스트를 입력해주세요..", text: $editingPost.content)
                .font(.title)
                .padding()
                .padding(.top)
                .focused($isFocused)
                .onAppear { isFocused = true }
            Spacer()
        }
        .navigationTitle("포스트 게시")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct PostDetail: View {
    @State private var showEditView: Bool = false
    @Binding var post: Post
    @State private var editingPost = Post(username: "유저 이름", content: "")
    
    var body: some View {
        VStack(spacing: 20) {
            Text(post.username)
                .font(.title)
            Text(post.content)
                .font(.body)
            
            Button {
                editingPost = post
                showEditView.toggle()
            } label: {
                HStack {
                    Image(systemName: "pencil")
                    Text("수정")
                }
                .tint(.indigo)
            }
            .sheet(isPresented: $showEditView) {
                NavigationView {
                    PostAdd(editingPost: $editingPost)
                        .toolbar {
                            ToolbarItem(placement: .navigationBarLeading) {
                                Button("취소") { showEditView = false }
                            }
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Button("게시") {
                                    post = editingPost
                                    showEditView = false
                                }
                            }
                        }
                }
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
    var content: String
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
}
