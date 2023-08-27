import UIKit
protocol HeatingDelegate {
    func notificationTemperature(currentTmperature: Int)
    func energizationCheck()
}

class HeatingControl: HeatingDelegate {
    let heating = Heating()
    let boilingPoint = 100 //℃
    
    func registerDelegate() {
        heating.delegate = self
    }
    
    func HeatingStart() {
        heating.continuedHeating()
    }
    
    func notificationTemperature(currentTmperature: Int) {
        let stoppedHeating = currentTmperature >= boilingPoint
        if stoppedHeating {
            heating.stoppedHeating = true
            print("加熱終了")
        }
    }
    
    func energizationCheck() {
        let emergencyTeleservice = energizationCheck
        if energizationCheck() -> Bool {
            heating.energizationCheck = false
            print("通電が確認できないので加熱停止します。")
        }
    }
}

class Heating {
    var currentTmperature = 0
    var stoppedHeating = false
    var delegate : HeatingDelegate?
    var energizationCheck = true
    
    func continuedHeating() {
        while !stoppedHeating {
            currentTmperature += 1 //1℃ずつ加熱）
            print("今の温度は\(currentTmperature)です。")
            delegate?.notificationTemperature(currentTmperature: currentTmperature)
        }
    }
}

let heatingControl = HeatingControl()
heatingControl.registerDelegate()
heatingControl.HeatingStart()

