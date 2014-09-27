//
//  MailboxViewController.swift
//  Mailbox-Swift
//
//  Created by Michael Ellison on 9/24/14.
//  Copyright (c) 2014 MichaelWEllison. All rights reserved.
//

import UIKit

class MailboxViewController: UIViewController {
   
    // MARK: Outlets
    
    @IBOutlet weak var feedScrollView: UIScrollView!
    @IBOutlet weak var messageImage: UIImageView!
    @IBOutlet weak var searchImage: UIImageView!
    @IBOutlet weak var helpImage: UIImageView!
    @IBOutlet weak var messageContainerView: UIView!
    @IBOutlet weak var messageLaterIcon: UIImageView!
    @IBOutlet weak var messageArchiveIcon: UIImageView!
    @IBOutlet weak var feedImageView: UIImageView!
    @IBOutlet weak var contentView: UIView!
    
    
    var contentViewCenter: CGPoint!
    var messageImageCenter: CGPoint!
    
    // MARK: View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureScrollView()
        configureContentView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Configuration
    
    func configureScrollView() {
        feedScrollView.contentSize = CGSize(width: 320, height: feedImageView.frame.size.height)
        feedScrollView.frame.size = view.frame.size
        feedScrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    func configureContentView() {
        var edgeGesture = UIScreenEdgePanGestureRecognizer(target: self, action: "onEdgePan:")
        
        edgeGesture.edges = UIRectEdge.Left
        contentView.addGestureRecognizer(edgeGesture)
    }
    
    // MARK: Functions
    
    func animateContentInset() {
        
        UIView.animateWithDuration(2.0, animations: { () -> Void in
            self.feedScrollView.contentInset = UIEdgeInsets(top: -86, left: 0, bottom: 0, right: 0)
        })
    }
    
    // MARK: Actions
    
    @IBAction func onMessagePanGesture(messagePan: UIPanGestureRecognizer) {
        
        var location = messagePan.locationInView(view)
        var translation = messagePan.translationInView(view)
        var velocity = messagePan.velocityInView(view)
        
        if messagePan.state == UIGestureRecognizerState.Began {
            
            messageImageCenter = messageImage.center
            messageLaterIcon.alpha = 0.0
            
        } else if messagePan.state == UIGestureRecognizerState.Changed {
            
            messageImage.center.x = translation.x + messageImageCenter.x
            messageLaterIcon.alpha += 0.02
            
            if messageLaterIcon.frame.origin.x < 210 {
                messageContainerView.backgroundColor = UIColor.yellowColor()
                messageLaterIcon.image = UIImage(named: "list_icon")
            }
        
            
        } else if messagePan.state == UIGestureRecognizerState.Ended {
            
        }
    }
    
    @IBAction func onEdgePan(edgePan: UIScreenEdgePanGestureRecognizer) {
        var location = edgePan.locationInView(view)
        var translation = edgePan.translationInView(view)
        var velocity = edgePan.velocityInView(view)
        
        if edgePan.state == UIGestureRecognizerState.Began {
            
            contentViewCenter = contentView.center
            
        } else if edgePan.state == UIGestureRecognizerState.Changed {
            
            contentView.center.x = translation.x + contentViewCenter.x
            
        } else if edgePan.state == UIGestureRecognizerState.Ended {
            if velocity.x < 0 {
                UIView.animateWithDuration(0.25, animations: { () -> Void in
                    self.contentView.center.x = self.contentViewCenter.x
                })
            } else {
                UIView.animateWithDuration(0.25, animations: { () -> Void in
                    self.contentView.frame.origin.x = 280
                })
            }
        }
    }
    
    
    

}
