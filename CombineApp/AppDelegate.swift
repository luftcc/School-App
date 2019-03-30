

import UIKit
import IQKeyboardManagerSwift
import UserNotifications
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = MainTabBarController()
        self.window?.makeKeyAndVisible()
        
        IQKeyboardManager.sharedManager().enable = true
        
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        center.requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            print("granted = \(granted)")
            if error != nil {
                print(error!)
            }
        }
        
        UIApplication.shared.applicationIconBadgeNumber = 0;
        
        return true
    }
    
    public func registerNotification(note: Note) {
        let center = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        content.title = note.title
        content.body = note.desc
        content.sound = UNNotificationSound.default()
        let badge = UIApplication.shared.applicationIconBadgeNumber+1;
        content.badge = NSNumber.init(value: badge);
        let calendar = Calendar.current;
        let mainComponents = calendar.dateComponents(in: TimeZone.current, from: note.time! as Date)
        let tempComponents = DateComponents(calendar: nil, timeZone: nil, era: nil, year: mainComponents.year, month: mainComponents.month, day: mainComponents.day, hour: mainComponents.hour, minute: mainComponents.minute, second: 1, nanosecond: nil, weekday: nil, weekdayOrdinal: nil, quarter: nil, weekOfMonth: nil, weekOfYear: nil, yearForWeekOfYear: nil);
        let trigger = UNCalendarNotificationTrigger.init(dateMatching: tempComponents, repeats: false)
        let request = UNNotificationRequest(identifier: "string", content: content, trigger: trigger)
        center.add(request) { error in
            if error != nil {
                print(error!)
            }
        }
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        self.saveContext()
    }

    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "NoteBook")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("接受到通知")
        completionHandler([.alert, .sound, .badge]);
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }


}

