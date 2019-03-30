

import Foundation
import CoreData

@objc(CourseModel)
public class CourseModel: NSManagedObject {
    /// 这里放的是各个课程上课的节
    var processNum :[Int] = Array()
}
