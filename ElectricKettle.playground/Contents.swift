import UIKit
protocol HeatingDelegate {
    func notificationTemperature(currentTmperature: Int)
    func energizationCheck(isEnergizationing: Bool)
    func capacityCheck(currentCapacity: Int)
}

class HeatingControl: HeatingDelegate {
    let heating = Heating()
    let boilingPoint = 100 //℃
    let maximumCapacity = 2000 //cc
    
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
    
    func energizationCheck(isEnergizationing: Bool) {
        if !isEnergizationing {
            heating.stoppedHeating = true
            print("通電が確認できないので加熱を停止します。")
        }
    }
    
    func capacityCheck(currentCapacity: Int) {
        let　aboveCapacity = currentCapacity >= maximumCapacity
        if aboveCapacity {
            heating.stoppedHeating = true
            print("容量オーバーです。加熱できません。")
    }
}

class Heating {
    var currentTmperature = 0
    var currentCapacity = 0
    var stoppedHeating = false
    var delegate : HeatingDelegate?
    var energizationCheck = true
    
    func hoge() {
        delegate?.energizationCheck(isEnergizationing: false)
    }
    
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
currentCapacity = 3000
