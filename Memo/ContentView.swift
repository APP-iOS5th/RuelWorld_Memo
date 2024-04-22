//
//  ContentView.swift
//  Memo
//
//  Created by 황규상 on 4/22/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var memoStore: MemoStore = MemoStore()
    
    @State var isSheetShowing: Bool = false
    @State var memoText: String = ""
    @State var memoColor: Color = .blue
    @State var editingMemo: Memo?
    
    let colors: [Color] = [.blue, .cyan, .yellow, .indigo]
    
    var body: some View {
        NavigationStack {
            List(memoStore.memos) { memo in
                HStack {
                    VStack(alignment: .leading) {
                        Text("\(memo.text)")
                            .font(.title)
                        Text("\(memo.createdString)")
                            .font(.body)
                            .padding(.top)
                    }
                    Spacer()
                }
                .padding()
                .foregroundColor(.white)
                .background(memo.color)
                .shadow(radius: 3)
                .padding()
                .onTapGesture {
                    editingMemo = memo
                    memoText = memo.text
                    memoColor = memo.color
                    isSheetShowing = true
                }
                .contextMenu {
                    ShareLink(item: memo.text)
                    Button {
                        memoStore.removeMemo(memo)
                    } label: {
                        Image(systemName: "trash.slash")
                        Text("삭제")
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("memo")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("추가") {
                        memoText = ""
                        memoColor = .blue
                        editingMemo = nil
                        isSheetShowing = true
                    }
                }
            }
            .sheet(isPresented: $isSheetShowing) {
                if let editingMemo = editingMemo {
                    MemoAddView(memoStore: memoStore, isSheetShowing: $isSheetShowing, memoText: $memoText, memoColor: $memoColor, colors: colors, editingMemo: editingMemo)
                } else {
                    MemoAddView(memoStore: memoStore, isSheetShowing: $isSheetShowing, memoText: $memoText, memoColor: $memoColor, colors: colors)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
