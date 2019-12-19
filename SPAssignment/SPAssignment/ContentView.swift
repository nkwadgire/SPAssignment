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
                MapView(annotationPoints: $viewModel.annotations).edgesIgnoringSafeArea(.top)
            }
            .navigationBarTitle(Text("PSI"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
