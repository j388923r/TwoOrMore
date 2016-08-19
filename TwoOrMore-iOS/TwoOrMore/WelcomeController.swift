//
//  WelcomeController.swift
//  TwoOrMore
//
//  Created by Jamar Brooks on 6/12/16.
//  Copyright © 2016 TwoOrMore. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FirebaseAuth

class WelcomeController: UIViewController, FBSDKLoginButtonDelegate {

    @IBOutlet weak var welcomeText: UITextView!
    
    var user : FIRUser?
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("UUID")
    
    override func viewDidLoad() {
        
        FIRAuth.auth()?.addAuthStateDidChangeListener { auth, user in
            if let user = user {
                // User is signed in.
                self.user = user
            } else {
                if let _ = NSKeyedUnarchiver.unarchiveObjectWithFile(WelcomeController.ArchiveURL.path!) as? String {
                    let verseIndex = Int(arc4random_uniform(UInt32(PrayerScriptureDb.prayerVerses.count)))
                    self.welcomeText.text = PrayerScriptureDb.prayerVerses[verseIndex]
                } else {
                    let uuid = NSUUID().UUIDString
                    NSKeyedArchiver.archiveRootObject(uuid, toFile: WelcomeController.ArchiveURL.path!)
                }
            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        for subview in self.view.subviews {
            if subview.tag == 101993 {
                subview.removeFromSuperview()
            }
        }
    }
    
    @IBAction func toInviteAction(sender: UIButton) {
        if let user = self.user {
            let name = user.displayName
            print(name)
            let email = user.email
            print(email)
            let photoUrl = user.photoURL
            print(photoUrl)
            let uid = user.uid;
            print(uid)
            self.performSegueWithIdentifier("toInviteSegue", sender: self)
        }
        else {
            let loginButton = FBSDKLoginButton()
            loginButton.tag = 101993
            loginButton.delegate = self
            loginButton.center = self.view.center
            self.view.addSubview(loginButton)
        }
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError?) {
        if let error = error {
            print(error.localizedDescription)
            return
        }
        let credential = FIRFacebookAuthProvider.credentialWithAccessToken(FBSDKAccessToken.currentAccessToken().tokenString)
        FIRAuth.auth()?.signInWithCredential(credential) { (user, error) in
            self.user = user
            self.performSegueWithIdentifier("toInviteSegue", sender: self)
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        
    }
    
    func returnHome(segue: UIStoryboardSegue) {
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let inviteController = segue.destinationViewController as? InviteController {
            inviteController.user = self.user
        }
    }
}
