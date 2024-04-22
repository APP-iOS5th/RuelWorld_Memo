//
//  MemoAddView.swift
//  Memo
//
//  Created by 황규상 on 4/22/24.
//

import SwiftUI

struct MemoAddView: View {
    var memoStore: MemoStore
    
    @Binding var isSheetShowing: Bool
    @Binding var memoText: String
    @Binding var memoColor: Color
    
    let colors: [Color]
    var editingMemo: Memo?
    
    var body: some View {
        VStack {
            HStack {
                Button("취소") {
                    isSheetShowing = false
                }
                Spacer()
                Button("완료") {
                    if let editingMemo = editingMemo {
                            memoStore.editMemo(editingMemo, newText: memoText, newColor: memoColor)
                        } else {
                            memoStore.addMemo(memoText, color: memoColor)
                        }
                    isSheetShowing = false
                }
                .disabled(memoText.isEmpty)
            }
            
            HStack {
                ForEach(colors, id: \.self) { color in
                    Button {
                        memoColor = color
                    } label: {
                        HStack {
                            Spacer()
                            if color == memoColor {
                                Image(systemName: "checkmark.circle")
                            }
                            Spacer()
                        }
                        .padding()
                        .frame(height: 50)
                        .foregroundColor(.white)
                        .background(color)
                        .shadow(radius: color == memoColor ? 8 : 0)
                    }
                }
            }
            Divider()
                .padding()
            TextField("메모를 입력하세요",text: $memoText, axis: .vertical)
                .padding()
                .foregroundColor(.white)
                .background(memoColor)
                .shadow(radius: 3)
            Spacer()
        }
        .padding()
    }
}

#Preview {
    MemoAddView(memoStore: MemoStore(), isSheetShowing: .constant(false), memoText: .constant(""), memoColor: .constant(.blue), colors: [.blue, .yellow, .red, .green])

}
