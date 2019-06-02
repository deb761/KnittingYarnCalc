// Copyright 2012-2016 Amazon.com, Inc. or its affiliates. All Rights Reserved.
// Licensed under the Apache License, Version 2.0 (the "License").
// You may not use this file except in compliance with the License.
// A copy of the License is located at http://aws.amazon.com/apache2.0/
// or in the "license" file accompanying this file.
// This file is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import UIKit

class TabBarController: UITabBarController, AmazonAdViewDelegate {

    @IBOutlet var amazonAdView: AmazonAdView!
    static var tabbarHeight:CGFloat = 100


    override func viewDidLoad() {
        super.viewDidLoad()
        loadAmazonAd()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: nil, completion: { (context) -> Void in
            // Reload Amazon Ad upon rotation.
            // Important: Amazon expandable rich media ads target landscape and portrait mode separately.
            // If your app supports device rotation events, your app must reload the ad when rotating between portrait and landscape mode.
            self.loadAmazonAd();
        });
    }
    /*
    override func viewWillLayoutSubviews() {
        if !didStyleTabBar {
            self.tabBar.invalidateIntrinsicContentSize()
            var tabFrame = self.tabBar.frame
            
            tabFrame.size.height = tabBarHeight
            tabFrame.origin.y = tabFrame.origin.y - 44
            self.tabBar.frame = tabFrame
            
            didStyleTabBar = true
        }
    }*/
    @IBAction func loadAmazonAd(){
        if ((amazonAdView) != nil) {
            amazonAdView.removeFromSuperview()
            amazonAdView = nil
        }
        
        // Initialize Auto Ad Size View
        let adFrame: CGRect = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 90);
        amazonAdView = AmazonAdView.init(frame: adFrame)
        amazonAdView.autoresizingMask = [.flexibleWidth, .flexibleLeftMargin, .flexibleRightMargin, .flexibleBottomMargin]
        amazonAdView.setHorizontalAlignment(.center)
        amazonAdView.setVerticalAlignment(.fitToContent)
        
        // Register the ViewController with the delegate to receive callbacks.
        amazonAdView.delegate = self
       
        // Set Ad Loading Options & Load Ad
        let options = AmazonAdOptions()
        options.isTestRequest = true
        amazonAdView.loadAd(options)
    }
    
    // MARK: AmazonAdViewDelegate
    func viewControllerForPresentingModalView() -> UIViewController {
        return self
    }
    
    func adViewDidLoad(_ view: AmazonAdView!) -> Void {
        // Add the newly created Amazon Ad view to our view.
        self.view.addSubview(amazonAdView)
        amazonAdView.bottomAnchor.constraint(equalTo: self.tabBar.topAnchor, constant: 0).isActive = true
        TabBarController.tabbarHeight = self.tabBar.frame.height + amazonAdView.frame.height
    }
    
    func adViewDidFail(toLoad view: AmazonAdView!, withError: AmazonAdError!) -> Void {
        Swift.print("Ad Failed to load. Error code \(withError.errorCode): \(withError.errorDescription ?? "There was an unknown error")")
        TabBarController.tabbarHeight = self.tabBar.frame.height
    }
    
    func adViewWillExpand(_ view: AmazonAdView!) -> Void {
        Swift.print("Ad will expand")
    }
    
    func adViewDidCollapse(_ view: AmazonAdView!) -> Void {
        Swift.print("Ad has collapsed")
    }
    
}

extension UITabBar {
    
    open override func sizeThatFits(_ size: CGSize) -> CGSize {
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = TabBarController.tabbarHeight
        return sizeThatFits
    }
}
