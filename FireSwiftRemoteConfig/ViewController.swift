//
//  ViewController.swift
//  FireSwiftRemoteConfig
//
//  Created by Ashish Kakkad on 20/11/16.
//  Copyright © 2016 Kode. All rights reserved.
//

import UIKit
import FirebaseRemoteConfig

class ViewController: UIViewController {

    var remoteConfig: FIRRemoteConfig!
    let sampleURLConfigKey = "sampleURL"
    @IBOutlet weak var btnFetch: UIButton!
    @IBOutlet weak var lblResult: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        remoteConfig = FIRRemoteConfig.remoteConfig()
        let remoteConfigSettings = FIRRemoteConfigSettings(developerModeEnabled: true)
        remoteConfig.configSettings = remoteConfigSettings!
        remoteConfig.setDefaultsFromPlistFileName("FireSwiftRemoteConfigDefaults")
        fetchConfig()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func fetchConfig() {
        lblResult.text = remoteConfig[sampleURLConfigKey].stringValue
        
        var expirationDuration = 3600
        if remoteConfig.configSettings.isDeveloperModeEnabled {
            expirationDuration = 0
        }

        remoteConfig.fetch(withExpirationDuration: TimeInterval(expirationDuration)) { (status, error) -> Void in
            if status == .success {
                print("Config fetched!")
                self.remoteConfig.activateFetched()
            } else {
                print("Config not fetched")
                print("Error \(error!.localizedDescription)")
            }
            self.display()
        }
    }
    
    func display() {
        lblResult.text = remoteConfig[sampleURLConfigKey].stringValue
    }

    @IBAction func fetchButtonPressed(_ sender: AnyObject) {
        fetchConfig()
    }
}

