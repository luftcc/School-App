

import UIKit

class WeekPickerView: UIView, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var picker: UIPickerView!
    
    var finished: (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        picker.dataSource = self
        picker.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.removeFromSuperview()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 12
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "第\(row+1)周"
    }
    
    @IBAction func confirm(_ sender: Any) {
        UserDefaults.standard.setValue(self.picker.selectedRow(inComponent: 0)+1, forKey: "currentweek");
        self.finished!()
        self.removeFromSuperview()
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.finished!()
        self.removeFromSuperview()
    }

}
