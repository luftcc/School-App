

import UIKit
import MBProgressHUD
import CoreData

class DetailVC: UIViewController, DatePickerViewDelegate {
    
    @IBOutlet weak var titleL: UITextField!
    @IBOutlet weak var detailL: UITextView!
    @IBOutlet weak var timeL: UILabel!
    
    var noteModel: Note?
    var selectTime: Date?
    
    let datePickerView = Bundle.main.loadNibNamed("DatePickerView", owner: nil, options: nil)?.first as! DatePickerView
    
    convenience init(noteModel: Note) {
        let nib = "DetailVC"
        self.init(nibName: nib, bundle: nil)
        self.noteModel = noteModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "详情"
        datePickerView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        datePickerView.delegate = self
        self.titleL.text = noteModel?.title
        self.detailL.text = noteModel?.desc
        if noteModel?.time != nil {
            self.timeL.text = Common.dateAsString(convertDate: noteModel!.time! as Date)
        }
        
    }

    @IBAction func pickTime(_ sender: Any) {
        self.view.addSubview(datePickerView)
    }
    
    @IBAction func save(_ sender: Any) {
        if !titleL.hasText {
            let hud = MBProgressHUD.init()
            hud.mode = .text
            hud.label.text = "请输入标题"
            hud.show(animated: true)
            return
        }
        if !detailL.hasText {
            let hud = MBProgressHUD.init()
            hud.mode = .text
            hud.label.text = "请输入内容"
            hud.show(animated: true)
            return
        }
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let note: Note = NSEntityDescription.insertNewObject(forEntityName: "Note", into: context) as! Note
        note.title = titleL.text!
        note.desc = detailL.text!
        if noteModel?.time != nil {
            note.time = noteModel?.time
        }
        
        if selectTime != nil {
            note.time = selectTime! as NSDate
        }
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                let hud = MBProgressHUD.init()
                hud.mode = .text
                hud.label.text = nserror.localizedDescription
                hud.show(animated: true)
            }
        }
        if note.time != nil {
            appDelegate.registerNotification(note: note)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    func confirmCLick(date: Date) {
        selectTime = date as Date
        self.timeL.text = Common.dateAsString(convertDate: date)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}
