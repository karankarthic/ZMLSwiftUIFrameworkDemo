//
//  ContentView.swift
//  ZMLSwiftUIFrameworkDemo
//
//  Created by Karan Karthic Neelamegan on 04/12/20.
//  Copyright © 2020 Karan Karthic Neelamegan. All rights reserved.
//

import SwiftUI
import ZMLSwiftUIFramework
import ZMLKit

struct ContentView: View {
    var body: some View {
        let prop = ZMlParser.parse()!
        VStack(spacing:10){
            PanelContentView(pagePanel: prop)
        }
            
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .background(Color(#colorLiteral(red: 0.9703430533, green: 0.9705052972, blue: 0.9703217149, alpha: 1)))
            .padding()
    }
}
