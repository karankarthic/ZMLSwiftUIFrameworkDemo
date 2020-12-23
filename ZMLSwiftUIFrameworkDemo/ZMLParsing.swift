//
//  ZMLParsing.swift
//  ZMLSwiftUIFrameworkDemo
//
//  Created by Karan Karthic Neelamegan on 11/12/20.
//  Copyright © 2020 Karan Karthic Neelamegan. All rights reserved.
//

import Foundation
import ZMLKit


let strng = """
<panel>
  <pr height='fill' width='fill'>
    <pc width='100%' bgColor='#FFFFFF' padding='20px' hAlign='right' vAlign='top'>
      <pr height='auto' width='auto'>
        <pc>
          <pr>
            <pc>
              <text type='Text' value='385' size='36px' color='#FF4C2F' bold='true'> </text>
            </pc>
          </pr>
          <pr>
            <pc>
              <text type='Text' value='New employees this month' size='16px' color='#333333'> </text>
            </pc>
          </pr>
        </pc>
      </pr>
    </pc>
  </pr>
</panel>
"""

class ZMlParser {
    
    static func parse() -> PagePanel? {
        guard let xmlNode = try? XMLNode.node(for: strng) else{
            return nil
        }
        
       let pagePannel = PagePanel.init(xmlNode)
        return pagePannel
    }
}
