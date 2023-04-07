//
//  UIPreview.swift
//  Core Base
//
//  Created by Puttheavy tep on 18/1/2566 BE.
//

import SwiftUI

// ============================= PREVIEW CONROLLER===================================
//==================================================================================

// Preview controller with swift ui View
struct ControllerView: View{
    var body: some View {
        VStack {
            WrapperUIViewControllerRepresentable().edgesIgnoringSafeArea(.all)
        }
    }
}

struct ControllerPreviews: PreviewProvider {
    static var previews: some View {
        ControllerView()
    }
}

// Wrapper Controller to View
struct WrapperUIViewControllerRepresentable: UIViewControllerRepresentable{
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        return   // nothing to do here
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<WrapperUIViewControllerRepresentable>) -> UIViewController {
        let viewController = UINavigationController(rootViewController: EwalletViewController())
        return viewController
    }
}


