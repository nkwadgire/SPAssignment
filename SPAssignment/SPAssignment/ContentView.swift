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
        ActivityIndicatorView(isShowing: $viewModel.loading) {
            NavigationView {
                VStack {
                    //MapView(annotationPoints: $viewModel.annotations).edgesIgnoringSafeArea(.bottom)
                    if self.viewModel.annotations.isEmpty {
                        Text("Unable to fetch the PSIndex values, please try after some  time by pressing Refresh button.")
                        
                    } else {
                        MapView(annotationPoints: self.$viewModel.annotations).edgesIgnoringSafeArea(.bottom)
                        
                    }
                }
                .navigationBarTitle(Text("PSIndex"), displayMode: .inline)
                .navigationBarItems(trailing:
                    Button("Refresh") {
                        DispatchQueue.main.async {
                                self.viewModel.updatePSIndex()
                        }
                })
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
