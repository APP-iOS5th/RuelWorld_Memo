//
//  MemoStore.swift
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
