//
/**
 *  * *****************************************************************************
 *  * Filename: ContentView.swift                                                 *
 *  * Author  : Nagraj Wadgire                                                    *
 *  * Creation Date: 19/12/19                                                     *
 *  * *
 *  * *****************************************************************************
 *  * Description:                                                                *
 *  * ContentView                                                                 *
 *  *                                                                             *
 *  * *****************************************************************************
 */

import SwiftUI
import Combine

struct ContentView: View {
    @ObservedObject var viewModel = PSIndexViewModel()
    var body: some View {
        NavigationView {
            VStack {
                MapView(annotationPoints: $viewModel.annotations).edgesIgnoringSafeArea(.bottom)
            }
            .navigationBarTitle(Text("PSIndex"), displayMode: .inline)
            .navigationBarItems(trailing:
                Button("Refresh") {
                    self.viewModel.updatePSIndex()
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
