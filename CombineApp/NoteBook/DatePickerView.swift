

import UIKit

protocol DatePickerViewDelegate: NSObjectProtocol {
    func confirmCLick(date: Date)
}

class DatePickerView: UIView {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    weak var delegate: DatePickerViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        datePicker.timeZone = NSTimeZone.local
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.removeFromSuperview()
    }
    
    @IBAction func confirm(_ sender: Any) {
        self.removeFromSuperview()
        
        if (delegate != nil && delegate?.responds(to: #selector(confirm(_:))) != nil) {
            delegate?.confirmCLick(date: datePicker.date)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.removeFromSuperview()
    }
    
}
