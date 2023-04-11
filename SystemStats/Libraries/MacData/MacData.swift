//
//  SystemData.swift
//  SystemStats
//
//  Created by Alberto Lourenço on 12/09/20.
//  Copyright © 2020 Digit.all. All rights reserved.
//

import Foundation

protocol MacDataDelegate {
    func macDataLoaded(data: MacData)
}

final class MacData: Identifiable {
    
    static let shared = MacData()
    
    var delegates: Array<MacDataDelegate?> = []
    
    var cpu = MacCPU()
    var gpu = MacGPU()
    var power = MacPower()
    var battery = MacBattery()
    var memory = MacMemory()
    var system = MacInfo()
    var fans: Array<MacFan> = []
    
    var timerDuration: TimeInterval = 1
    
    func startMonitor() {
        
        DispatchQueue.global().async {
            
            self.parseSMC()
            self.parseSystemKit()
            
            if self.delegates.count > 0 {
                
                for delegate in self.delegates {
                    DispatchQueue.main.async {
                        delegate?.macDataLoaded(data: self)
                    }
                }
            }else{
                self.stopMonitor()
            }
            
            DispatchQueue.global().asyncAfter(deadline: .now() + self.timerDuration) {
                if self.timerDuration > 0 {
                    self.startMonitor()
                }
            }
        }
    }
    
    func stopMonitor() {
        timerDuration = -1
    }
    
    func countFANs() -> Int {
        return SMC.shared.fans().count
    }
    
    private func parseSMC() {
        
        //--------------
        //  Fan
        //--------------
        
        fans = []
        
        for item in SMC.shared.fans() {
            fans.append(MacFan(identifier: item.identifier,
                               currentRPM: item.currentRPM ?? 0,
                               minimumRPM: item.minimumRPM ?? 0,
                               maximumRPM: item.maximumRPM ?? 0))
        }
        
        //--------------
        //  CPU
        //--------------
        
        let counts = System.processCounts()
        
        self.cpu.threads = counts.threadCount
        self.cpu.processes = counts.processCount
        
        for sensor in Sensor.CPU.allCases {
            
            let temperature: Temperature? = SMC.shared.cpuTemperature(sensor: sensor)
            
            switch sensor {
                case .core_01, .core_02, .core_03, .core_04, .core_05, .core_06, .core_07, .core_08:
                    self.cpu.cores.append(MacCPU.Core(name: sensor.title,
                                                      identifier: sensor.key,
                                                      temperature: temperature?.celsius ?? 0.0))
                case .die:
                    self.cpu.die = temperature?.celsius ?? 0.0
                case .diode:
                    self.cpu.diode = temperature?.celsius ?? 0.0
                case .heatsink:
                    self.cpu.heatsink = temperature?.celsius ?? 0.0
                case .peci:
                    self.cpu.peci = temperature?.celsius ?? 0.0
                case .proximity:
                    self.cpu.proximity = temperature?.celsius ?? 0.0
            }
        }
        
        //--------------
        //  GPU
        //--------------
        
        for sensor in Sensor.GPU.allCases {
            
            let temperature: Temperature? = SMC.shared.gpuTemperature(sensor: sensor)
            
            switch sensor {
                case .diode:
                    self.gpu.diode = temperature?.celsius ?? 0.0
                case .heatsink:
                    self.gpu.heatsink = temperature?.celsius ?? 0.0
                case .peci:
                    self.gpu.peci = temperature?.celsius ?? 0.0
                case .proximity:
                    self.gpu.proximity = temperature?.celsius ?? 0.0
            }
        }
    }
    
    private func parseSystemKit() {
        
        //--------------
        //  System
        //--------------
        
        var system = System()
        let uptime = System.uptime()
        
        self.system.model = System.modelName()
        self.system.uptime = "\(uptime.days)d \(uptime.hrs)h \(uptime.mins)m \(uptime.secs)s"
        self.system.factor = System.machFactor()
        self.system.average = System.loadAverage()

        //--------------
        //  Power
        //--------------
        
//        let powerStatus = System.CPUPowerLimit()
//
//        self.power.limitCPUSpeed = "\(powerStatus.processorSpeed)%"
//        self.power.limitScheduler = "\(powerStatus.schedulerTime)%"

        //--------------
        //  CPU
        //--------------
        
        let usageCPU = system.usageCPU()
        
        self.cpu.amountLogical = System.logicalCores()
        self.cpu.amountPhysical = System.physicalCores()
        self.cpu.usage = MacCPU.Usage(user: Int(usageCPU.user),
                                      idle: Int(usageCPU.idle),
                                      nice: Int(usageCPU.nice),
                                      system: Int(usageCPU.system))
        
        //--------------
        //  Memory
        //--------------
        
        let usageMemory = System.memoryUsage()
        self.memory = MacMemory(free: memoryUnit(usageMemory.free),
                                wired: memoryUnit(usageMemory.wired),
                                active: memoryUnit(usageMemory.active),
                                inactive: memoryUnit(usageMemory.inactive),
                                totalSize: memoryUnit(System.physicalMemory()),
                                compressed: memoryUnit(usageMemory.compressed))
        
        //--------------
        //  Power
        //--------------
        
        var battery = Battery()
        
        if battery.open() != kIOReturnSuccess { exit(0) }
        
        self.battery = MacBattery(powered: battery.isACPowered(),
                                  charged: battery.isCharged(),
                                  charging: battery.isCharging(),
                                  charge: "\(battery.charge())%",
                                  capacity: "\(battery.currentCapacity()) mAh",
                                  maxCapacity: "\(battery.maxCapactiy()) mAh",
                                  designCapacity: "\(battery.designCapacity()) mAh",
                                  cycles: battery.cycleCount(),
                                  maxCycles: battery.designCycleCount(),
                                  temperature: "\(Int(battery.temperature()))°C",
                                  timeRemaining: "\(battery.timeRemainingFormatted())")
        _ = battery.close()
    }
    
    private func memoryUnit(_ value: Double) -> String {
        if value < 1.0 {
            return String(Int(value * 1000.0)) + " MB"
        }else{
            return NSString(format:"%.2f", value) as String + " GB"
        }
    }
}

//----------------------------------------------
//  MARK: - Data
//----------------------------------------------

struct MacCPU {
    
    // SMC
    
    var die: Double = 0
    var peci: Double = 0
    var diode: Double = 0
    var heatsink: Double = 0
    var proximity: Double = 0
    var cores: Array<Core> = []

    struct Core {
        var name: String = ""
        var identifier: String = ""
        var temperature: Double = 0
    }

    // SytemKit
    
    var usage: Usage = Usage()
    var threads: Int = 0
    var processes: Int = 0
    var amountLogical: Int = 0
    var amountPhysical: Int = 0

    struct Usage {
        var user: Int = 0
        var idle: Int = 0
        var nice: Int = 0
        var system: Int = 0
    }
}

struct MacGPU {
    var peci: Double = 0
    var diode: Double = 0
    var heatsink: Double = 0
    var proximity: Double = 0
}

struct MacFan: Hashable {
    var id = UUID()
    var identifier: Int = 0
    var currentRPM: Int = 0
    var minimumRPM: Int = 0
    var maximumRPM: Int = 0
}

struct MacMemory {
    var free: String = ""
    var wired: String = ""
    var active: String = ""
    var inactive: String = ""
    var totalSize: String = ""
    var compressed: String = ""
}

struct MacInfo {
    var model: String = ""
    var uptime: String = ""
    var factor: Array<Double> = []
    var average: Array<Double> = []
}

struct MacPower {
    var limitCPUSpeed: String = ""
    var limitScheduler: String = ""
}

struct MacBattery {
    var powered: Bool = false
    var charged: Bool = false
    var charging: Bool = false
    var charge: String = ""
    var capacity: String = ""
    var maxCapacity: String = ""
    var designCapacity: String = ""
    var cycles: Int = 0
    var maxCycles: Int = 0
    var temperature: String = ""
    var timeRemaining: String = ""
}
