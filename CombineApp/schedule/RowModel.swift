

import UIKit

class RowModel: NSObject {
    @objc var title: String = ""
    @objc var one: String = ""
    @objc var two: String = ""
    @objc var three: String = ""
    @objc var four: String = ""
    @objc var five: String = ""
    @objc var six: String = ""
    @objc var seven: String = ""
    
    override var description: String {
        return "\(String(describing: title)) \(String(describing: one)) \(String(describing: two)) \(String(describing: three)) \(String(describing: four)) \(String(describing: five)) \(String(describing: six)) \(String(describing: seven))"
    }
    
}
