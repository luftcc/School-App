

import Foundation
import CoreData


extension CourseModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CourseModel> {
        return NSFetchRequest<CourseModel>(entityName: "CourseModel")
    }

    @NSManaged public var courseName: String?
    @NSManaged public var teacherName: String?
    @NSManaged public var claRoom: String?
    /// 第几节课开始上课
    @NSManaged public var lessons: Int32
    
    /// 上课的节数
    @NSManaged public var lessonsNum: Int32
    @NSManaged public var startWeek: Int32
    @NSManaged public var endWeek: Int32
    @NSManaged public var weekday: Int32
    
}
