import UIKit
protocol HeatingDelegate {
    func notificationTemperature(currentTmperature: Int)
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
}

class Heating {
    var currentTmperature = 0
    var stoppedHeating = false
    var delegate : HeatingDelegate?
    
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

