

import UIKit
import HealthKit

class HealthViewController: UIViewController {

    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var stepCountLabel: UILabel!
    @IBOutlet weak var calorieLabel: UILabel!
    @IBOutlet weak var apptitleLabel: UILabel!
    
    let healthStore = HKHealthStore()
    
    func createType() -> Set<HKSampleType> {
        let stepCountType = HKObjectType.quantityType(forIdentifier: .stepCount)!
        let distanceType = HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!
        return Set(arrayLiteral: stepCountType, distanceType)
    }
    
    func authorizeForHealth(){
        healthStore.requestAuthorization(toShare: createType(), read: createType()){
            success, error in
            if success {
                let stepType: HKQuantityType? = HKObjectType.quantityType(forIdentifier: .stepCount)
                let distance: HKQuantityType? = HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)
                var calorie: Double = 0.0
                self.fetchSumOfStepsToday(for: stepType!, unit: HKUnit.count()){ (stepCount, error) in
                    self.fetchSumOfDistanceToday(for: distance!, unit: HKUnit.meter()){
                        (distanceCount,error) in
                        DispatchQueue.main.async {
                            self.stepCountLabel.text = "步数：\(String(describing: stepCount!))"
                            self.distanceLabel.text = "距离：\(String(describing: distanceCount!))m"
                            calorie = (distanceCount!) / 1000 * 70 * 1.036
                            self.calorieLabel.text = "卡路里： \(calorie)cal"
                        }
                    }
                }
            } else {
                self.showTitle("出错")
            }
        }
    }
    
    func fetchSumOfDistanceToday(for quantityType: HKQuantityType, unit: HKUnit, completion completionHandler: @escaping (Double?, NSError?)->()) {
        let predicate: NSPredicate? = self.predicateForSamplesToday()
        
        let query = HKStatisticsQuery(quantityType: quantityType, quantitySamplePredicate: predicate, options: .cumulativeSum) { query, result, error in
            
            if result == nil{
                completionHandler(nil,error as NSError?)
                return
            }
            var distance = 0.0
            if let quantity = result?.sumQuantity() {
                let unit = HKUnit.meter()
                distance = quantity.doubleValue(for: unit)
                print("\(distance)")
            }
            completionHandler(distance, error as NSError?)
        }
        
        self.healthStore.execute(query)
    }
    
    func fetchSumOfStepsToday(for quantityType: HKQuantityType, unit: HKUnit, completion completionHandler: @escaping (Double?, NSError?)->()) {
        let predicate: NSPredicate? = self.predicateForSamplesToday()
        
        let query = HKStatisticsQuery(quantityType: quantityType, quantitySamplePredicate: predicate, options: .cumulativeSum) { query, result, error in
            
            if result == nil{
                completionHandler(nil,error as NSError?)
                return
            }
            var step = 0.0
            if let quantity = result?.sumQuantity() {
                let unit = HKUnit.count()
                step = quantity.doubleValue(for: unit)
                print("\(step)")
            }
            completionHandler(step, error as NSError?)
        }
        
        self.healthStore.execute(query)
    }
    
    func showTitle(_ title: String) -> Void {
        let alertC = UIAlertController.init(title: "提示", message: title, preferredStyle: .alert)
        let action = UIAlertAction.init(title: "取消", style: .cancel, handler: nil)
        alertC.addAction(action)
        self.present(alertC, animated: true, completion: nil)
    }
    
    func predicateForSamplesToday() -> NSPredicate {
        let calendar = Calendar.current
        let now = Date()
        let startDate: Date? = calendar.startOfDay(for: now)
        let endDate: Date? = calendar.date(byAdding: .day, value: 1, to: startDate!)
        return HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        authorizeForHealth()
        apptitleLabel.layer.cornerRadius = 5
        apptitleLabel.clipsToBounds = true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        authorizeForHealth()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
