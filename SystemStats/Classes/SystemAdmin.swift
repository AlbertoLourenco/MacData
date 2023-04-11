//
//  SystemAdmin.swift
//  SystemStats
//
//  Created by Alberto Lourenço on 20/09/20.
//  Copyright © 2020 Digit.all. All rights reserved.
//

import Foundation

struct SystemAdmin {
    
    static let shared = SystemAdmin()
    
    func cleanMemory() {
        
        DispatchQueue.global().async {
            
            let path = "/bin/sh"
            let scriptFile = "script.sh"
            let bundle = Bundle.main.resourcePath
            
            let task = STPrivilegedTask()
            
            task.launchPath = path
            task.arguments = [scriptFile]
            task.currentDirectoryPath = bundle
            
            let status: OSStatus = task.launch()
            
            DispatchQueue.main.async {
                
                if status != 0 { // errAuthorizationSuccess
                    if status == -60006 { // errAuthorizationCanceled
                        print("user canceled")
                    }else{
                        print("something went wrong \(Int(status))")
                    }
                }else{
                    print("memory cleaned")
                    
                    NotificationManager.shared.showNotification(title: "MacData - Status",
                                                                body: "Memory cleaned with success!",
                                                                categoryIdentifier: "MacData_MemoryClean")
                }
            }
            
            task.waitUntilExit()
        }
    }
}
