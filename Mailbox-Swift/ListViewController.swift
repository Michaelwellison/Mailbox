//
//  ListViewController.swift
//  Mailbox-Swift
//
//  Created by Michael Ellison on 9/27/14.
//  Copyright (c) 2014 MichaelWEllison. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTap(sender: UITapGestureRecognizer) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
