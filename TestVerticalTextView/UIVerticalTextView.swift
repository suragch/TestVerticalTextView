import UIKit
@IBDesignable class UIVerticalTextView: UIView {
    
    var textView = UITextView()
    let rotationView = UIView()
    
    var underlyingTextView: UITextView {
        get {
            return textView
        }
        set {
            textView = newValue
        }
    }
    
    
    var contentSize: CGSize {
        get {
            // height and width are swapped because underlying view is rotated 90 degrees
            return CGSize(width: textView.contentSize.height, height: textView.contentSize.width)
        }
        set {
            textView.contentSize = CGSize(width: newValue.height, height: newValue.width)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
        self.setup()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setup()
    }
    
    func setup() {
        
        textView.backgroundColor = UIColor.yellowColor()
        self.textView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(rotationView)
        rotationView.addSubview(textView)
        
        // add constraints to pin TextView to rotation view edges.
        let leadingConstraint = NSLayoutConstraint(item: self.textView, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: rotationView, attribute: NSLayoutAttribute.Leading, multiplier: 1.0, constant: 0)
        let trailingConstraint = NSLayoutConstraint(item: self.textView, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: rotationView, attribute: NSLayoutAttribute.Trailing, multiplier: 1.0, constant: 0)
        let topConstraint = NSLayoutConstraint(item: self.textView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: rotationView, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 0)
        let bottomConstraint = NSLayoutConstraint(item: self.textView, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: rotationView, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 0)
        rotationView.addConstraints([leadingConstraint, trailingConstraint, topConstraint, bottomConstraint])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        rotationView.transform = CGAffineTransformIdentity
        rotationView.frame = CGRect(origin: CGPointZero, size: CGSize(width: self.bounds.height, height: self.bounds.width))
        rotationView.userInteractionEnabled = true
        rotationView.transform = translateRotateFlip()
    }
    
    func translateRotateFlip() -> CGAffineTransform {
        
        var transform = CGAffineTransformIdentity
        
        // translate to new center
        transform = CGAffineTransformTranslate(transform, (self.bounds.width / 2)-(self.bounds.height / 2), (self.bounds.height / 2)-(self.bounds.width / 2))
        // rotate counterclockwise around center
        transform = CGAffineTransformRotate(transform, CGFloat(-M_PI_2))
        // flip vertically
        transform = CGAffineTransformScale(transform, -1, 1)
        
        return transform
    }
    
    func insertMongolText(unicode: String) {
        // This is a simplified version for testing only
        textView.insertText(unicode)
    }
    
    func deleteBackward() {
        // This is a simplified version for testing only
        textView.deleteBackward()
    }
}