//
//  ReviewingView.swift
//  PomodoroHub (iOS)
//
//  Created by 鈴木航 on 2020/08/06.
//

import SwiftUI

struct ReviewingView: View {
    @ObservedObject var viewModel: SessionViewModel
    
    var body: some View {
        NavigationView {
            List {
                Text("msg_review".localized)
                ForEach(0..<2) { row in
                    HStack(alignment: .center) {
                        ForEach(0..<2) { column in
                            if let result = ReviewResult(rawValue: index(row: row, column: column)) {
                                VStack {
                                    Button(action: {
                                        viewModel.reviewing = false
                                    }, label: {
                                        Image(result.imageName())
                                            .renderingMode(.original)
                                            .resizable()
                                            .scaledToFit()
                                        Text("review_\(result.describing)".localized)
                                    })
                                }
                            } else {
                                Image(systemName: "xmark.circle")
                                    .renderingMode(.original)
                                    .resizable()
                                    .scaledToFit()
                            }
                        }
                    }
                }
            }
            .padding(EdgeInsets.init(top: 0, leading: 0, bottom: 0, trailing: 0))
            .navigationTitle("review".localized)
        }
    }
    
    func index(row: Int, column: Int) -> Int {
        return row + (row == 0 ? column : column + 1)
    }
}

enum ReviewResult: Int {
    case excellent, good, bad, suck
    
    func imageName() -> String {
        return "cat_\(String(describing: self))"
    }
}

struct ReviewingView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewingView(viewModel: SessionViewModel())
    }
}
