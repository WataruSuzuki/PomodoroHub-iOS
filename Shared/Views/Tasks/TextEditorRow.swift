//
//  TextEditorRow.swift
//  PomodoroHub (iOS)
//
//  Created by 鈴木航 on 2020/08/13.
//

import SwiftUI

struct TextEditorRow: View {
    @Binding var isEditing: Bool
    @Binding var editableText: String
    var placeHolder: String
    
    private let minHeight = CGFloat(100)
    
    var body: some View {
        if !isEditing {
            Text(editableText)
                .frame(minHeight: minHeight, maxHeight: .infinity, alignment: .top)
        } else {
            ZStack(alignment: .leading) {
                if editableText.isEmpty {
                    Text(placeHolder)
                        .frame(minHeight: minHeight, maxHeight: .infinity, alignment: .top)
                        .foregroundColor(.gray)
                }
                TextEditor(text: $editableText)
                    .frame(minHeight: minHeight, maxHeight: .infinity)
            }
        }
    }
}

struct TextEditorRow_Previews: PreviewProvider {
    static var previews: some View {
        TextEditorRow(
            isEditing: .constant(false),
            editableText: .constant("editable text"),
            placeHolder: "Normal mode")
        TextEditorRow(
            isEditing: .constant(true),
            editableText: .constant("Edit mode"),
            placeHolder: "Edit mode")
    }
}
