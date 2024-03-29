//
//  TwitterModule.swift
//  twitter_client
//
//  Created by mitsuyoshi matsuo on 2019/02/20.
//  Copyright © 2019 Facebook. All rights reserved.
//

import Foundation
import TwitterKit

@objc(TwitterModule)
class TwitterModule: NSObject {
  // TwitterKitのLogin機能を記述
  @objc(auth:reject:)
  func auth(resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) {
    TWTRTwitter.sharedInstance().logIn(completion: { (session, error) in
      if let session = session {
        resolve([
          "id": session.userID,
          "name": session.userName,
          ])
      } else {
        reject(nil, nil, error)
      }
    })
  }
  
  // Tweetの投稿機能
  @objc(tweet)
  func tweet() {
    guard let vc = (UIApplication.shared.delegate as? AppDelegate)?.window?.rootViewController else { return }
    let composer = TWTRComposer()
    composer.setText("just setting up my Twitter Kit")
    composer.show(from: vc, completion: {(result) in
      if (result == .done) {
        print("Successfully composed Tweet")
      } else {
        print("Cancelled composing")
      }
    })
  }
  
  // ログイン判定
  @objc(isLogined:reject:)
  func isLogined(resolve: RCTPromiseResolveBlock, reject: RCTPromiseRejectBlock) {
    resolve(TWTRTwitter.sharedInstance().sessionStore.existingUserSessions().count > 0)
  }
  
  // タイムラインの取得
  @objc(getTimeline:reject:)
  func getTimeline(resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) {
    let client = TWTRAPIClient.withCurrentUser()
    let endpoint = "https://api.twitter.com/1.1/statuses/home_timeline.json"
    let request = client.urlRequest(withMethod: "GET", urlString: endpoint, parameters: nil, error: nil)
    client.sendTwitterRequest(request, completion: {(response,data, e) in
      if let e = e {
        print(e);
        return
      }
      do {
        let json = try JSONSerialization.jsonObject(with: data!, options: [])
        resolve(json)
      } catch {
        resolve([])
      }
    })
  }
}
