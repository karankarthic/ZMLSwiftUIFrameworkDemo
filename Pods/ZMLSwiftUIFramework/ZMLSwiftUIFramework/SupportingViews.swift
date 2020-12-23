//
//  SupportingViews.swift
//  ZMLSwiftUIFramework
//
//  Created by Karan Karthic Neelamegan on 15/12/20.
//  Copyright © 2020 Karan Karthic Neelamegan. All rights reserved.
//

import SwiftUI
import ZMLKit


struct TextView: UIViewRepresentable {
    var textable: TextableProperties?
    
    func makeUIView(context: Context) -> UITextView {
        let textLabel = UITextView.init()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.isScrollEnabled = false
        textLabel.showsVerticalScrollIndicator = false
        textLabel.showsHorizontalScrollIndicator = false
        textLabel.isEditable = false
        textLabel.backgroundColor = .clear
        textLabel.isUserInteractionEnabled = ((textable?.renderAsHtml) != nil)
        textLabel.textContainerInset = UIEdgeInsets.zero
        textLabel.textContainer.lineFragmentPadding = 0;
        return textLabel
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.attributedText = textable?.attributedString()
    }
    
}

struct ImageView:View{
    var imageProperties : ImageProperties
    
    public var body: some View {
        
                Image("angel")
                    .resizable()
                    .frame(width:30, height:30)
                    .clipped()

    }
    
    func getHeight() ->CGFloat{
        if let height = imageProperties.height {
            switch height {
            case .pixel(let pixel):
                return pixel
            default:
                break
            }
        }
        return 0
    }
    
    func getWidth() -> CGFloat{
        if let width = imageProperties.width {
            switch width {
            case .pixel(let pixel):
                return pixel
            default:
                break
            }
        }
        return 0
    }
    
    private func font(_ imageProperties: ImageProperties) -> String {
        var fontFamily = "nucleo-outline"
        if imageProperties.isSolid {
            fontFamily = "nucleo-solid"
        }
        return fontFamily
    }
    
}

extension TextProperties {
    func attributedString(textable : TextableProperties? = nil) -> NSMutableAttributedString? {
        if self.value.count > 0 {
            let range = NSMakeRange(0, self.value.count)
            let style = NSMutableParagraphStyle()
            style.alignment = self.textAlignment
            
            let finalString = NSMutableAttributedString.init(string: self.isUpperCase ? self.value.uppercased() :self.value)
            
            finalString.addAttribute(NSAttributedString.Key.font, value: UIFont.font(self), range: range)
            finalString.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: range)
            if let color = UIColor.init(named: self.color) {
                finalString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
                finalString.addAttribute(NSAttributedString.Key.underlineColor, value: color, range: range)
            } else if let textable = textable, let color = UIColor.init(named: textable.color) {
                finalString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
                finalString.addAttribute(NSAttributedString.Key.underlineColor, value: color, range: range)
            }
            
            if self.isUnderLine {
                finalString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range)
            }
            return finalString
        }
        return nil
    }
}

extension UIFont
    {
        
    func withTraits(traits:UIFontDescriptor.SymbolicTraits...) -> UIFont {
            let descriptor = self.fontDescriptor
                .withSymbolicTraits(UIFontDescriptor.SymbolicTraits(traits))
            return UIFont(descriptor: descriptor!, size: 0)
        }
        
        func boldItalic() -> UIFont {
            return withTraits(traits: .traitBold, .traitItalic)
        }
        
        func bold() -> UIFont {
            return withTraits(traits: .traitBold)
        }
        
        func italic() -> UIFont {
            return withTraits(traits: .traitItalic)
        }
        
        static func font(_ textProperties: TextProperties) -> UIFont {
            let font = UIFont.systemFont(ofSize: textProperties.size, weight: .regular)
            if textProperties.isBold && textProperties.isItalic {
                return font.boldItalic()
            }
            else if textProperties.isBold {
                return font.bold()
            }
            else if textProperties.isItalic {
                return font.italic()
            }
            return font
        }
        
        static func font(_ titleProperties: TitleProperties) -> UIFont {
            let font = UIFont.systemFont(ofSize: CGFloat(titleProperties.fontSize), weight: .regular)
            if titleProperties.bold && titleProperties.italic {
                return font.boldItalic()
            }
            else if titleProperties.bold {
                return font.bold()
            }
            else if titleProperties.italic {
                return font.italic()
            }
            return font
        }
        
        static func font(_ imageProperties: ImageProperties) -> UIFont? {
            var fontFamily = "nucleo-outline"
            if imageProperties.isSolid {
                fontFamily = "nucleo-solid"
            }
            return UIFont(name: fontFamily, size: imageProperties.size)
        }
        
    
}


extension String{
    func exactUnicodeString() -> String? {
        if let hexValue = Int(self,radix:16), let unicodeScalar = UnicodeScalar(hexValue) {
            return unicodeScalar.description
        }
        return nil
    }
}

