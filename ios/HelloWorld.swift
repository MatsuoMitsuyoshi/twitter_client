//
//  HelloWorld.swift
//  twitter_client
//
//  Created by mitsuyoshi matsuo on 2019/02/13.
//  Copyright © 2019 Facebook. All rights reserved.
//

import Foundation
import UIKit

@objc(HelloWorld)
class HelloWorld: NSObject {
  
  @objc(say)
  func say() {
    let alert: UIAlertController = UIAlertController(title: "Alert", message: "message", preferredStyle: UIAlertController.Style.alert)
    alert.addAction(UIAlertAction(title: "close", style: .cancel))
    if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
      appDelegate.window.rootViewController?.present(alert, animated: true, completion: nil)
    }
  }
  
  
  
}
