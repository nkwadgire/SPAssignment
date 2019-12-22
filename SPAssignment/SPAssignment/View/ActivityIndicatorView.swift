//
/**
*  * *****************************************************************************
*  * Filename: ActivityIndicatorView.swift                                       *
*  * Author  : Nagraj Wadgire                                                    *
*  * Creation Date: 22/12/19                                                     *
*  * *
*  * *****************************************************************************
*  * Description:                                                                *
*  * ActivityIndicatorView will load the loading indicator with label till we get*
*  * the response from server or requeet gets timeout                            *
*  *                                                                             *
*  * *****************************************************************************
*/

import SwiftUI

struct ActivityIndicator: UIViewRepresentable {

    typealias UIViewType = UIActivityIndicatorView

    let style: UIActivityIndicatorView.Style

    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> ActivityIndicator.UIViewType {
        return UIActivityIndicatorView(style: style)
    }

    func updateUIView(_ uiView: ActivityIndicator.UIViewType, context: UIViewRepresentableContext<ActivityIndicator>) {
        uiView.startAnimating()
    }
}

struct ActivityIndicatorView<Content>: View where Content: View {
    @Binding var isShowing: Bool
    var content: () -> Content

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                if !self.isShowing {
                    self.content()
                } else {
                    self.content()
                        .disabled(true)
                        .blur(radius: 3)

                    VStack {
                        Text("Loading ...")
                        ActivityIndicator(style: .large)
                    }
                    .frame(width: geometry.size.width / 2,
                           height: geometry.size.height / 5)
                    .background(Color.secondary.colorInvert())
                    .foregroundColor(Color.primary)
                    .cornerRadius(20)
                    .opacity(self.isShowing ? 1 : 0)
                }
            }
        }
    }
}
