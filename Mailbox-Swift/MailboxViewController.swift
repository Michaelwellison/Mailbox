//
//  MailboxViewController.swift
//  Mailbox-Swift
//
//  Created by Michael Ellison on 9/24/14.
//  Copyright (c) 2014 MichaelWEllison. All rights reserved.
//

import UIKit

class MailboxViewController: UIViewController {
    @IBOutlet weak var feedScrollView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()

        feedScrollView.contentSize = CGSize(width: 320, height: 1597)
//        feedScrollView.contentOffset = CGPoint(x: 40, y: )
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
