

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let vc3 = UIStoryboard(name: "HealthStoryboard", bundle: nil).instantiateViewController(withIdentifier: "1")
        vc3.tabBarItem.image = UIImage(named: "100")
        vc3.tabBarItem.selectedImage = UIImage(named: "100")
        vc3.tabBarItem.title = "健康"
        self.addChildViewController(vc3)
        let vc4 = UIStoryboard(name: "MapStoryboard", bundle: nil).instantiateViewController(withIdentifier: "2")
        vc4.tabBarItem.image = UIImage(named: "300")
        vc4.tabBarItem.selectedImage = UIImage(named: "300")
        vc4.tabBarItem.title = "导航"
        self.addChildViewController(vc4)
        let vc1 = UINavigationController(rootViewController: MainVC())
        vc1.tabBarItem.image = UIImage(named: "aaa")
        vc1.tabBarItem.selectedImage = UIImage(named: "aaa")
        vc1.tabBarItem.title = "备忘录"
        self.addChildViewController(vc1)
        let vc2 = UINavigationController(rootViewController: ViewController())
        vc2.tabBarItem.image = UIImage(named: "bbb")
        vc2.tabBarItem.selectedImage = UIImage(named: "bbb")
        vc2.tabBarItem.title = "课程表"
        self.addChildViewController(vc2)
        
    }

}
