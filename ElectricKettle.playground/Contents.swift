import UIKit
protocol HeatingDelegate {
    func notificationTemperature(currentTmperature: Int)
    func energizationCheck(isEnergizationing: Bool)
    func capacityCheck()
}

class HeatingControl: HeatingDelegate {
    let heating = Heating()
    let boilingPoint = 100 //℃
    let maximumCapacity = 2000 //cc
    
    var currentCapacity = 2000
    
    func capacityCheck() {
        if currentCapacity > maximumCapacity {
            heating.stoppedHeating = true
            print("容量オーバーです。")
        }
    }
    
    func detach() {
        heating.isEnergizationing = false
    }
    
    func registerDelegate() {
        heating.delegate = self
    }
    
    func heatingStart() {
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
        print("加熱終了")
    }
}

let heatingControl = HeatingControl()
heatingControl.registerDelegate()
heatingControl.detach()
heatingControl.heatingStart()
heatingControl.capacityCheck()

