

import UIKit
import CoreData

class ViewController: UIViewController, JHGridViewDelegate {
    
    /// 这个是一周每一行的数据
    var rows: [RowModel] = Array()
    var courses: [CourseModel]?
    var titleButton: UIButton = UIButton(type: .custom)

    var gridView: JHGridView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "课程表"
        self.view.backgroundColor = UIColor.white
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(addCourse))
        var currentweek = UserDefaults.standard.integer(forKey: "currentweek")
        if currentweek == 0 {
            currentweek = 1;
        }
        titleButton.setTitle("第\(currentweek)周", for: .normal)
        titleButton.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        titleButton.setTitleColor(UIColor.black, for: .normal)
        titleButton.addTarget(self, action: #selector(weekButtonClick(_:)), for: .touchUpInside)
        self.navigationItem.titleView = titleButton
    }
    
    @objc func weekButtonClick(_ sender: UIButton) {
        let v = Bundle.main.loadNibNamed("WeekPickerView", owner: nil, options: nil)?.first as! WeekPickerView
        v.frame = UIScreen.main.bounds
        v.finished = { () -> () in
            let str = UserDefaults.standard.string(forKey: "currentweek")
            self.titleButton.setTitle("第\(str ?? "一")周", for: .normal)
            self.reloadGridView()
        }
        self.view.addSubview(v)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.reloadGridView()
    }
    
    func reloadGridView() {
        if self.gridView != nil {
            self.gridView?.removeFromSuperview()
        }
        self.gridView = JHGridView(frame: CGRect(x: 0, y: 20, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))!
        gridView!.delegate = self
        self.courses?.removeAll()
        self.rows.removeAll()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request: NSFetchRequest<CourseModel> = CourseModel.fetchRequest()
        var currentWeek = UserDefaults.standard.integer(forKey: "currentweek")
        if currentWeek == 0 {
            currentWeek = 1
        }
        do {
            let result = try context.execute(request) as! NSAsynchronousFetchResult<CourseModel>
            let courses:[CourseModel] = result.finalResult!
            self.courses = courses
            for course in courses {
                for i in 0..<course.lessonsNum {
                    course.processNum.append(Int(course.lessons+i))
                }
            }
            for i in 1..<15 {
                //这个是一行的数据
                let row = RowModel()
                row.title = "\(i)"
                for course in courses {
                    if (currentWeek >= course.startWeek && currentWeek <= course.endWeek) {
                        if (course.processNum.contains(i)) {
                            if course.weekday == 1 {
                                row.one = NSString(format:"%@\n%@\n%@", course.courseName!, course.teacherName!, course.claRoom!) as String
                            }
                            if course.weekday == 2 {
                                row.two = NSString(format:"%@\n%@\n%@", course.courseName!, course.teacherName!, course.claRoom!) as String
                            }
                            if course.weekday == 3 {
                                row.three = NSString(format:"%@\n%@\n%@", course.courseName!, course.teacherName!, course.claRoom!) as String
                            }
                            if course.weekday == 4 {
                                row.four = NSString(format:"%@\n%@\n%@", course.courseName!, course.teacherName!, course.claRoom!) as String
                            }
                            if course.weekday == 5 {
                                row.five = NSString(format:"%@\n%@\n%@", course.courseName!, course.teacherName!, course.claRoom!) as String
                            }
                            if course.weekday == 6 {
                                row.six = NSString(format:"%@\n%@\n%@", course.courseName!, course.teacherName!, course.claRoom!) as String
                            }
                            if course.weekday == 7 {
                                row.seven = NSString(format:"%@\n%@\n%@", course.courseName!, course.teacherName!, course.claRoom!) as String
                            }
                        }
                    }
                }
                print(row)
                rows.append(row)
            }
            gridView!.setTitles(["课程", "周一", "周二", "周三", "周四", "周五", "周六", "周日"], andObjects: rows, withTags: ["title","one","two","three","four","five","six","seven"])
            self.view.addSubview(gridView!)
        } catch {
            let nserror = error as NSError
            print(nserror.localizedDescription)
        }
    }
    
    @objc func addCourse() {
        let vc = UIStoryboard(name: "AddCourseTVC", bundle: nil).instantiateInitialViewController()
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func textColorForGrid(at gridIndex: GridIndex) -> UIColor! {
        return UIColor.blue
    }
    
    func widthForCol(at index: Int) -> CGFloat {
        if index == 0 {
            return 60
        } else {
            return 90
        }
    }
    
    func heightForTitles() -> CGFloat {
        return 44
    }
    
    func heightForRow(at index: Int) -> CGFloat {
        return 100
    }
    
    func didSelectRow(at gridIndex: GridIndex) {
        if gridIndex.col == 0 {
            return
        }
        
        let row = rows[gridIndex.row]
        var str: String?
        switch gridIndex.col {
        case 1:
            str = row.one
        case 2:
            str = row.two
        case 3:
            str = row.three
        case 4:
            str = row.four
        case 5:
            str = row.five
        case 6:
            str = row.six
        case 7:
            str = row.seven
        default:
            str = ""
        }
        if str!.characters.count != 0 {
            let subStr = str!.components(separatedBy: "\n").first!
            guard self.courses?.count != 0 else {
                return
            }
            for course in self.courses! {
                guard course.courseName != nil else {
                    return
                }
                if subStr == course.courseName {
                    let vc = UIStoryboard(name: "AddCourseTVC", bundle: nil).instantiateInitialViewController() as! AddCourseTVC
                    vc.course = course
                    self.navigationController?.pushViewController(vc, animated: true)
                    break
                }
            }
        }

    }

}

