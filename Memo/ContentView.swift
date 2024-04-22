//
//  ContentView.swift
//  Memo
//
//  Created by 황규상 on 4/22/24.
//

import SwiftUI
import Foundation

/// MemoStore Class 정의할 때 필요한 메모의 내용, 색상, 생성 날짜 ID 정의
struct Memo: Identifiable {
    var id: UUID = UUID()
    var text: String
    var color: Color
    var created: Date
    
    var createdString: String {
        get {
            let dateFormatter: DateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            return dateFormatter.string(from: created)
        }
    }
}

/// 메모 목록 관리 (추가,삭제)
class MemoStore: ObservableObject {
    @Published var memos: [Memo] = []
    
    /// 메모 추가
    /// - Parameters:
    ///   - text: 추가할 내용
    ///   - color: 메모지 색상
    func addMemo(_ text: String, color: Color) {
        let memo: Memo = Memo(text: text, color: color, created: Date())
        memos.insert(memo, at: 0)
    }
    
    /// 메모 삭제
    /// - Parameter targetMemo: 삭제할 메모
    func removeMemo(_ targetMemo: Memo) {
        if let index = memos.firstIndex(where: { $0.id == targetMemo.id }) {
            memos.remove(at: index)
        }
    }
}

struct ContentView: View {
    @ObservedObject var memoStore: MemoStore = MemoStore()
    
    @State var isSheetShowing: Bool = false
    @State var memoText: String = ""
    @State var memoColor: Color = .blue
    
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
                        isSheetShowing = true
                    }
                }
            }
            .sheet(isPresented: $isSheetShowing) {
                MemoAddView(memoStore: memoStore, isSheetShowing: $isSheetShowing, memoText: $memoText, memoColor: $memoColor, colors: colors)
            }
        }
    }
}

#Preview {
    ContentView()
}
