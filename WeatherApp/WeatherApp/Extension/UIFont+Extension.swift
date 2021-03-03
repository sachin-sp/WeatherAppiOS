import UIKit


extension UIFont {
    
    
    
    @nonobjc class var largeTitle: UIFont {
        
        return UIFont.preferredFont(forTextStyle: .largeTitle)
        
    }
    
    
    
    @nonobjc class var title1: UIFont {
        
        return UIFont.preferredFont(forTextStyle: .title1)
        
    }
    
    
    
    @nonobjc class var title2: UIFont {
        
        return UIFont.preferredFont(forTextStyle: .title2)
        
    }
    
    
    
    @nonobjc class var title3: UIFont {
        
        return UIFont.preferredFont(forTextStyle: .title3)
        
    }
    
    
    
    @nonobjc class var headline: UIFont {
        
        return UIFont.preferredFont(forTextStyle: .headline)
        
    }
    
    
    
    @nonobjc class var subheadline: UIFont {
        
        return UIFont.preferredFont(forTextStyle: .subheadline)
        
    }
    
    
    
    @nonobjc class var body: UIFont {
        
        return UIFont.preferredFont(forTextStyle: .body)
        
    }
    
    
    
    @nonobjc class var callout: UIFont {
        
        return UIFont.preferredFont(forTextStyle: .callout)
        
    }
    
    
    
    @nonobjc class var footnote: UIFont {
        
        return UIFont.preferredFont(forTextStyle: .footnote)
        
    }
    
    
    
    @nonobjc class var caption1: UIFont {
        
        return UIFont.preferredFont(forTextStyle: .caption1)
        
    }
    
    
    
    @nonobjc class var caption2: UIFont {
        
        return UIFont.preferredFont(forTextStyle: .caption2)
        
    }
    
    
    
    static func preferredFont(for style: TextStyle, weight: Weight) -> UIFont {
        
        let metrics = UIFontMetrics(forTextStyle: style)
        
        let desc = UIFontDescriptor.preferredFontDescriptor(withTextStyle: style)
        
        let font = UIFont.systemFont(ofSize: desc.pointSize, weight: weight)
        
        return metrics.scaledFont(for: font)
        
    }
    
    
    
}
