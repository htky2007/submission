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
    
    var currentCapacity = 0
    
    func detach() {
        heating.isEnergizationing = false
    }
    
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
        let aboveCapacity = currentCapacity >= maximumCapacity
        if aboveCapacity {
            heating.stoppedHeating = true
            print("容量オーバーです。加熱できません。")
        }
           
    }
}

class Heating {
    var currentTmperature = 0
    var stoppedHeating = false
    var delegate : HeatingDelegate?
    var energizationCheck = true
    var isEnergizationing = false
    
    func hoge() {
        delegate?.energizationCheck(isEnergizationing: false)
    }
    
    func continuedHeating() {
        while !stoppedHeating {
            if !isEnergizationing {
                break//ループから抜ける
            }
            currentTmperature += 1 //1℃ずつ加熱）
            print("今の温度は\(currentTmperature)です。")
            delegate?.notificationTemperature(currentTmperature: currentTmperature)
        }
        print("温め終了")
    }
}

let heatingControl = HeatingControl()
heatingControl.currentCapacity = 3000
heatingControl.registerDelegate()
heatingControl.detach()
heatingControl.HeatingStart()
