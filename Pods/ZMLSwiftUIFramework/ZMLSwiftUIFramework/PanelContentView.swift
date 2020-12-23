//
//  PanelContentView.swift
//  ZMLSwiftUIFramework
//
//  Created by Karan Karthic Neelamegan on 08/12/20.
//  Copyright © 2020 Karan Karthic Neelamegan. All rights reserved.
//

import SwiftUI
import ZMLKit


public struct PanelContentView: View {
    
    public var pagePanel : PagePanelProperties
    
    public init(pagePanel:PagePanelProperties) {
        self.pagePanel = pagePanel
    }
    
    public var body: some View {
        ZStack(alignment:.center){
            RoundedRectangle(cornerRadius: 5, style: .circular)
                .fill(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                .frame(width: (UIScreen.screenWidth - 20), height: 90)
                .shadow(radius: 0.5)
            
            
            VStack{
                ForEach(0 ..< pagePanel.panelRows.count) {
                    PanelRowView(panelRow: pagePanel.panelRows[$0])
                    
                }
            }
            .padding(20)
            .multilineTextAlignment(.center)
        }
//        .frame(width: (UIScreen.screenWidth - 20), height: )

    }
}

public struct PanelRowView:View{
    
   public var panelRow: PanelRowProperties
    
    public init(panelRow:PanelRowProperties) {
        self.panelRow = panelRow
    }
    public var body: some View{
        HStack{
            ForEach(0 ..< panelRow.panelColumns.count) {
                PanelColunmView(panelColumn: panelRow.panelColumns[$0])
            }
        }
        
    }
    
}

public struct PanelColunmView:View {
    
   public var panelColumn: PanelColumnProperties
    
    public init(panelColumn:PanelColumnProperties) {
        self.panelColumn = panelColumn
    }
    
    public var body: some View{
        
        VStack{
            Spacer()
            if let panelRows = panelColumn.panelRows {
                ForEach(0 ..< panelRows.count) {
                    PanelRowView(panelRow: panelRows[$0])

                }
            }
            else if let component = panelColumn.component {
                
                switch component.type {
                case .text:
                   TextView(textable: component as? TextableProperties)
               case .image:
                    ImageView(imageProperties: component as! ImageProperties)
                default:
                    Text("entered default")
                }
            }
            Spacer()
        }
        .frame(height:30)
    }
}

extension UIScreen{
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
    static let screenSize = UIScreen.main.bounds.size
}

