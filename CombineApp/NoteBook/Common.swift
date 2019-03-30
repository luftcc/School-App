

import UIKit

class Common: NSObject {
    static func dateAsString(convertDate: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.locale = Locale.init(identifier: "zh_CN")
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        let date = formatter.string(from: convertDate)
        return date
    }
}
