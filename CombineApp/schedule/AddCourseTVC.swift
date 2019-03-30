

import UIKit
import CoreData
import MBProgressHUD

class AddCourseTVC: UITableViewController {
    
    var course: CourseModel?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    @IBOutlet weak var courseName: UITextField!
    @IBOutlet weak var teacherName: UITextField!
    @IBOutlet weak var claRoom: UITextField!
    @IBOutlet weak var lessons: UITextField!
    @IBOutlet weak var lessonsNum: UITextField!
    @IBOutlet weak var startWeek: UITextField!
    @IBOutlet weak var endWeek: UITextField!
    @IBOutlet weak var weekday: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "添加课程表"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        guard course != nil else {
            return
        }
        if course != nil {
            self.courseName.text = self.course?.courseName
            self.teacherName.text = self.course?.teacherName
            self.claRoom.text = self.course?.claRoom
            self.lessons.text = NSString(format: "%zd", (self.course?.lessons)!) as String
            self.lessonsNum.text = NSString(format: "%zd", (self.course?.lessonsNum)!) as String
            self.startWeek.text = NSString(format: "%zd", (self.course?.startWeek)!) as String
            self.endWeek.text = NSString(format: "%zd", (self.course?.endWeek)!) as String
            self.weekday.text = NSString(format: "%zd", (self.course?.weekday)!) as String
            
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "删除", style: .plain, target: self, action: #selector(deleteCourse(_:)))
            
        }
        
    }
    
    @objc func deleteCourse(_ sender: UIBarButtonItem) {
        let ac = UIAlertController(title: "确定删除吗?", message: nil, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let confirm = UIAlertAction(title: "确定", style: .destructive) { (action) in
            self.context.delete(self.course!)
            do {
                try self.context.save()
                self.navigationController?.popViewController(animated: true)
            } catch {
                let nserror = error as NSError
                let hud = MBProgressHUD.init()
                hud.mode = .text
                hud.label.text = nserror.localizedDescription
                hud.show(animated: true)
            }
        }
        ac.addAction(cancel)
        ac.addAction(confirm)
        self.present(ac, animated: true, completion: nil)
    }
    
    @IBAction func commit(_ sender: Any) {
        
        let course: CourseModel = NSEntityDescription.insertNewObject(forEntityName: "CourseModel", into: context) as! CourseModel
        if (self.courseName.text! as NSString).replacingOccurrences(of: "", with: " ").isEmpty {
            MBProgressHUD .showText("课程名称不合法")
            return
        }
        course.courseName = (self.courseName.text! as NSString).replacingOccurrences(of: "", with: " ") as String
        course.teacherName = (self.teacherName.text! as NSString).replacingOccurrences(of: "", with: " ") as String
        course.claRoom = (self.claRoom.text! as NSString).replacingOccurrences(of: "", with: " ") as String
        
        if !((self.lessons.text! as NSString).intValue>=1 &&  (self.lessons.text! as NSString).intValue<=14) {
            MBProgressHUD.showText("开始节不合法")
            return;
        }
        course.lessons = (self.lessons.text! as NSString).intValue;
        if !((self.lessonsNum.text! as NSString).intValue>=1 &&  (self.lessonsNum.text! as NSString).intValue<=14) {
            MBProgressHUD.showText("节数不合法")
            return;
        }
        course.lessonsNum = (self.lessonsNum.text! as NSString).intValue;
        if !((self.startWeek.text! as NSString).intValue>=1) {
            MBProgressHUD.showText("开始周不合法")
            return;
        }
        course.startWeek = (self.startWeek.text! as NSString).intValue;
        if !((self.endWeek.text! as NSString).intValue<=12) {
            MBProgressHUD.showText("结束周不合法")
            return;
        }
        course.endWeek = (self.endWeek.text! as NSString).intValue;
        if !((self.weekday.text! as NSString).intValue>=1 &&  (self.weekday.text! as NSString).intValue<=7) {
            MBProgressHUD.showText("上课时间不合法")
            return;
        }
        course.weekday = (self.weekday.text! as NSString).intValue;
        if context.hasChanges {
            do {
                try context.save()
                self.navigationController?.popViewController(animated: true)
            } catch {
                let nserror = error as NSError
                let hud = MBProgressHUD.init()
                hud.mode = .text
                hud.label.text = nserror.localizedDescription
                hud.show(animated: true)
            }
        }
    }
    
}
