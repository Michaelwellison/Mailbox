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
    @IBOutlet weak var messageImage: UIImageView!
    @IBOutlet weak var searchImage: UIImageView!
    @IBOutlet weak var helpImage: UIImageView!
    @IBOutlet weak var messageContainerView: UIView!
    @IBOutlet weak var messageLaterIcon: UIImageView!
    @IBOutlet weak var messageArchiveIcon: UIImageView!
    @IBOutlet weak var feedImageView: UIImageView!
    
    var messageImageCenter: CGPoint!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        feedScrollView.contentSize = CGSize(width: 320, height: feedImageView.frame.size.height)
        feedScrollView.frame.size = view.frame.size
       // feedScrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        feedScrollView.scrollEnabled = true
    
//        feedScrollView.frame.size.height - searchImage.frame.height
        
        println(feedImageView.frame.size.height)
        
        
    }

    
    func animateContentInset() {
        
        UIView.animateWithDuration(2.0, animations: { () -> Void in
            self.feedScrollView.contentInset = UIEdgeInsets(top: -86, left: 0, bottom: 0, right: 0)
        })
    }
    
    
    @IBAction func onMessagePanGesture(messagePan: UIPanGestureRecognizer) {
        
        var location = messagePan.locationInView(view)
        var translation = messagePan.translationInView(view)
        var velocity = messagePan.velocityInView(view)
        
        if messagePan.state == UIGestureRecognizerState.Began {
            
            messageImageCenter = messageImage.center
            
        } else if messagePan.state == UIGestureRecognizerState.Changed {
            
            messageImage.center.x = translation.x + messageImageCenter.x
            
        } else if messagePan.state == UIGestureRecognizerState.Ended {
            
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
