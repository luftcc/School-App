

import UIKit

class NoteCell: UITableViewCell {
    
    @IBOutlet weak var titleL: UILabel!
    @IBOutlet weak var descL: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
}
