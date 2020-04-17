//
//  TextRow.swift
//  PomodoroHub (iOS)
//
//  Created by 鈴木航 on 2020/08/13.
//

import SwiftUI

struct TextRow: View {
    var placeHolder: String
    var editableText: String

    var body: some View {
        HStack {
            Text(placeHolder)
            Spacer()
            Text(editableText)
        }
    }
}

struct TextRow_Previews: PreviewProvider {
    static var previews: some View {
        TextRow(placeHolder: "title", editableText: "detail")
    }
}
