//
//  TextFieldRow.swift
//  PomodoroHub (iOS)
//
//  Created by 鈴木航 on 2020/08/11.
//

import SwiftUI

struct TextFieldRow: View {
    @Binding var isEditing: Bool
    @Binding var editableText: String
    @State private var texting = false
    var placeHolder: String
    
    var body: some View {
        if !isEditing {
            TextRow(placeHolder: placeHolder, editableText: editableText)
        } else {
            TextField(placeHolder,
                      text: $editableText,
                      onEditingChanged: { begin in
                        self.texting = begin
                      },
                      onCommit: {
                        print("onCommit: \(editableText)")
                      }
            )
            .shadow(color: texting ? .blue : .clear, radius: 3)
        }
    }
}

struct EditableTextView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            TextFieldRow(
                isEditing: .constant(false),
                editableText: .constant(""),
                placeHolder: "Normal mode")
            TextFieldRow(
                isEditing: .constant(true),
                editableText: .constant(""),
                placeHolder: "Edit mode")
        }
    }
}
