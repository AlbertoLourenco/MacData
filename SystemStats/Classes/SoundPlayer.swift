//
//  SoundPlayer.swift
//  SystemStats
//
//  Created by Alberto Lourenço on 20/09/20.
//  Copyright © 2020 Digit.all. All rights reserved.
//

import AVKit

struct SoundPlayer {
    
    static func play(fileName: String, fileExtension: String) {
        
        guard let url = Bundle.main.url(forResource: fileName, withExtension: fileExtension) else { return }
        
        do {
            let player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType(fileExtension).rawValue)
            player.play()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                player.stop()
            }
        }catch{
            print(error.localizedDescription)
        }
    }
}
