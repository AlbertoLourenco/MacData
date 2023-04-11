//
//  Util.swift
//  SystemStats
//
//  Created by Alberto Lourenço on 14/09/20.
//  Copyright © 2020 Digit.all. All rights reserved.
//

import SwiftUI

struct Util {
    
    static let timers = ["1", "3", "5", "7", "10"]
    
    static func timerDuration(by index: Int) -> Int {
        if index < timers.count {
            return Int(timers[index]) ?? 1
        }
        return 1
    }
    
    static func timerIndex(by duration: Int) -> Int {
        return timers.firstIndex(of: "\(duration)") ?? 0
    }
    
    static func appVersion() -> String {
        let info = Bundle.main.infoDictionary
        let version = info?["CFBundleShortVersionString"] as! String
        let build = info?["CFBundleVersion"] as! String
        return "Version: \(version) (\(build))"
    }
    
    static private let backgroundColors: Array<Color> = [Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)), Color(#colorLiteral(red: 0.03921568627, green: 0.5176470588, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)), Color(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1))]
    
    static func colorsFan(value: Float) -> Array<Color> {
        var colors: Array<Color> = [Color(#colorLiteral(red: 0.658556902, green: 0.8941805809, blue: 0.9764705896, alpha: 1)), Color(#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1))]
        if value > 0.35 && value <= 0.75 { colors = [Color(#colorLiteral(red: 0.658556902, green: 0.8941805809, blue: 0.9764705896, alpha: 1)), Color(#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)), Color(#colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1))] }
        if value > 0.75 { colors = [Color(#colorLiteral(red: 0.658556902, green: 0.8941805809, blue: 0.9764705896, alpha: 1)), Color(#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)), Color(#colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)), Color(#colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1))] }
        return colors
    }
    
    static func colorsBackground(id: Int) -> Color {
        if id < Util.backgroundColors.count { return Util.backgroundColors[id] }
        return Util.backgroundColors[2]
    }
    
    static func handleBattery(total: String) -> Float {
        return Float(total.replacingOccurrences(of: "%", with: "").trimmingCharacters(in: .whitespacesAndNewlines)) ?? 0
    }
    
    static func handleFANPercentage(current: Int, maximum: Int) -> Float {
        var percentage: Float = 0
        if maximum > 0 { percentage = Float(current)/Float(maximum) }
        return percentage
    }
    
    static func handleFANVelocityPercentage(current: Int, maximum: Int) -> Float {
        let velocity = Float(1.5 * Util.handleFANPercentage(current: current, maximum: maximum))
        return velocity
    }
    
    static func handleRAM(total: String) -> Float {
        return Float(total.replacingOccurrences(of: "GB", with: "").trimmingCharacters(in: .whitespacesAndNewlines)) ?? 0
    }
    
    static func handleRAMFree(total totalStr: String, free freeStr: String) -> Float {
        let total: Float = (Float(totalStr.replacingOccurrences(of: "GB", with: "").replacingOccurrences(of: "MB", with: "").trimmingCharacters(in: .whitespacesAndNewlines)) ?? 0) * 1024
        var free: Float = Float(freeStr.replacingOccurrences(of: "GB", with: "").replacingOccurrences(of: "MB", with: "").trimmingCharacters(in: .whitespacesAndNewlines)) ?? 0
        if freeStr.contains("GB") { free = free * 1024 }
        var result: Float = (total / free)
        if result > 1024 { result = result / 1024 }
        return (100 - (100 / result)) / 100
    }
    
    static func handleRAMBusy(total totalStr: String, free freeStr: String) -> String {
        let total: Float = (Float(totalStr.replacingOccurrences(of: "GB", with: "").trimmingCharacters(in: .whitespacesAndNewlines)) ?? 0) * 1024
        var free: Float = Float(freeStr.replacingOccurrences(of: "GB", with: "").trimmingCharacters(in: .whitespacesAndNewlines)) ?? 0
        if free > 1 { free = free * 1024 }
        var unit: String = "MB"
        var result: Float = (total - free)
        if result > 1024 {
            unit = "GB"
            result = result / 1024
        }
        return NSString(format:"%.2f %@", result, unit) as String
    }
}
