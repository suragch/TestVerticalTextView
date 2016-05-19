import UIKit
class ViewController: UIViewController {
    
    let minimumInputWindowSize = CGSize(width: 80, height: 150)
    let inputWindowSizeIncrement: CGFloat = 50
    
    // MARK:- Outlets
    @IBOutlet weak var inputWindow: UIVerticalTextView!
    @IBOutlet weak var topContainerView: UIView!
    @IBOutlet weak var inputWindowHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var inputWindowWidthConstraint: NSLayoutConstraint!
    
    @IBAction func enterTextButtonTapped(sender: UIButton) {
        inputWindow.insertMongolText("a")
        increaseInputWindowSizeIfNeeded()
    }
    @IBAction func newLineButtonTapped(sender: UIButton) {
        inputWindow.insertMongolText("\n")
        increaseInputWindowSizeIfNeeded()
    }
    @IBAction func deleteBackwardsButtonTapped(sender: UIButton) {
        inputWindow.deleteBackward()
        decreaseInputWindowSizeIfNeeded()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // get rid of space at beginning of textview
        self.automaticallyAdjustsScrollViewInsets = false
        
        // hide system keyboard but show cursor
        inputWindow.underlyingTextView.inputView = UIView()
        inputWindow.underlyingTextView.becomeFirstResponder()
    }
    
    private func increaseInputWindowSizeIfNeeded() {
        
        if inputWindow.frame.size == topContainerView.frame.size {
            return
        }
        
        // width
        if inputWindow.contentSize.width > inputWindow.frame.width &&
            inputWindow.frame.width < topContainerView.frame.size.width {
            if inputWindow.contentSize.width > topContainerView.frame.size.width {
                //inputWindow.scrollEnabled = true
                inputWindowWidthConstraint.constant = topContainerView.frame.size.width
            } else {
                self.inputWindowWidthConstraint.constant = self.inputWindow.contentSize.width
            }
        }
        
        // height
        if inputWindow.contentSize.width > inputWindow.contentSize.height {
            if inputWindow.frame.height < topContainerView.frame.height {
                if inputWindow.frame.height + inputWindowSizeIncrement < topContainerView.frame.height {
                    // increase height by increment unit
                    inputWindowHeightConstraint.constant = inputWindow.frame.height + inputWindowSizeIncrement
                } else {
                    inputWindowHeightConstraint.constant = topContainerView.frame.height
                }
            }
        }
    }
    
    private func decreaseInputWindowSizeIfNeeded() {
        
        if inputWindow.frame.size == minimumInputWindowSize {
            return
        }
        
        // width
        if inputWindow.contentSize.width < inputWindow.frame.width &&
            inputWindow.frame.width > minimumInputWindowSize.width {
            
            if inputWindow.contentSize.width < minimumInputWindowSize.width {
                inputWindowWidthConstraint.constant = minimumInputWindowSize.width
            } else {
                inputWindowWidthConstraint.constant = inputWindow.contentSize.width
            }
        }
        
        // height
        if (2 * inputWindow.contentSize.width) <= inputWindow.contentSize.height && inputWindow.contentSize.width < topContainerView.frame.width {
            // got too high, make it shorter
            if minimumInputWindowSize.height < inputWindow.contentSize.height - inputWindowSizeIncrement {
                inputWindowHeightConstraint.constant = inputWindow.contentSize.height - inputWindowSizeIncrement
            } else {
                // Bump down to min height
                inputWindowHeightConstraint.constant = minimumInputWindowSize.height
            }
        }
    }
}

