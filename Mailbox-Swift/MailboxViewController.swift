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
    
    // MARK: Variables
    
    var contentViewCenter: CGPoint!
    var messageImageCenter: CGPoint!
    var messageLaterIconCenter: CGPoint!
    var loadCount = 0
    var messageImageOrigin: CGPoint!
    
    // MARK: View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        println("view did load")
        
        configureScrollView()
        configureContentView()
    }
    
    override func viewDidAppear(animated: Bool) {
        if loadCount > 0 {
            
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                self.messageContainerView.backgroundColor = UIColor(red: 196/255, green: 195/255, blue: 197/197, alpha: 1)
                self.messageContainerView.frame.origin.y -= self.messageContainerView.frame.height
                self.feedImageView.frame.origin.y -= self.messageContainerView.frame.height
            })
        }
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
        var messageImageRightFrameEdge = messageImage.center.x + messageImage.frame.width/2
        var messageImageOrigin = messageImage.frame.origin.x
        
        if messagePan.state == UIGestureRecognizerState.Began {
            
            messageImageCenter = messageImage.center
            messageLaterIconCenter = messageLaterIcon.center
            messageLaterIcon.alpha = 0.0
            messageArchiveIcon.alpha = 0.0
            
        } else if messagePan.state == UIGestureRecognizerState.Changed {
            
            messageImage.center.x = translation.x + messageImageCenter.x
            
            switch messageImageRightFrameEdge {
            
            case 581...640:
                println("test case 6 because right frame edge = \(messageImageRightFrameEdge)")
                messageArchiveIcon.image = UIImage(named: "delete_icon")
                messageContainerView.backgroundColor = UIColor(red: 0.867, green: 0.396, blue: 0.263, alpha: 1)
                messageArchiveIcon.center.x = messageImage.frame.origin.x - 20
                messageArchiveIcon.alpha = 1
            case 381...580:
                println("test case 5 because right frame edge = \(messageImageRightFrameEdge)")
                messageContainerView.backgroundColor = UIColor(red: 0.545, green: 0.812, blue: 0.392, alpha: 1)
                messageArchiveIcon.center.x = messageImage.frame.origin.x - 20
                messageArchiveIcon.alpha = 1
            case 321...380:
                println("test case 4 because right frame edge = \(messageImageRightFrameEdge)")
                messageArchiveIcon.center.x = messageImage.frame.origin.x - 20
                messageArchiveIcon.alpha += 0.025
                println(messageLaterIcon.alpha)
            case 260...320:
                println("test case 1 because right frame edge = \(messageImageRightFrameEdge)")
                messageLaterIcon.center.x = messageImage.center.x + 183
                messageLaterIcon.alpha += 0.025
                println(messageLaterIcon.alpha)
            case 60...259:
                println("test case 2 because right frame edge = \(messageImageRightFrameEdge)")
                messageContainerView.backgroundColor = UIColor(red: 0.969, green: 0.816, blue: 0.278, alpha: 1)
                messageLaterIcon.center.x = messageImage.center.x + 183
                messageLaterIcon.alpha = 1
            case 0...59:
                println("test case 3 because right frame edge = \(messageImageRightFrameEdge)")
                messageLaterIcon.image = UIImage(named: "list_icon")
                messageContainerView.backgroundColor = UIColor(red: 0.824, green: 0.655, blue: 0.478, alpha: 1)
                messageLaterIcon.center.x = messageImage.center.x + 183
                messageLaterIcon.alpha = 1
            default:
                println("this is default")
            }
            
        } else if messagePan.state == UIGestureRecognizerState.Ended {
            switch messageImageRightFrameEdge {
            case 581...640:
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.messageImage.transform = CGAffineTransformMakeTranslation(320, self.messageImage.frame.origin.y)
                    self.messageArchiveIcon.transform = CGAffineTransformMakeTranslation(320, 0)
                    }, completion: { (Bool) -> Void in
                        
                        UIView.animateWithDuration(0.5, animations: { () -> Void in
                            self.messageContainerView.backgroundColor = UIColor(red: 0.918, green: 0.922, blue: 0.925, alpha: 1)
                            self.messageContainerView.frame.origin.y -= self.messageContainerView.frame.height
                            self.feedImageView.frame.origin.y -= self.messageContainerView.frame.height
                        })
                        self.loadCount += 1
                })
            case 381...580:
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.messageImage.transform = CGAffineTransformMakeTranslation(320, self.messageImage.frame.origin.y)
                    self.messageArchiveIcon.transform = CGAffineTransformMakeTranslation(320, 0)
                }, completion: { (Bool) -> Void in
 
                        UIView.animateWithDuration(0.5, animations: { () -> Void in
                            self.messageContainerView.backgroundColor = UIColor(red: 0.918, green: 0.922, blue: 0.925, alpha: 1)
                            self.messageContainerView.frame.origin.y -= self.messageContainerView.frame.height
                            self.feedImageView.frame.origin.y -= self.messageContainerView.frame.height
                        })
                    self.loadCount += 1
                })
                
            case 321...380:
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.messageImage.frame = CGRectMake(0, self.messageImage.frame.origin.y, self.messageImage.frame.width, self.messageImage.frame.height)
                    self.messageLaterIcon.frame = CGRectMake(messageImageRightFrameEdge + 20, self.messageLaterIcon.frame.origin.y, self.messageLaterIcon.frame.width, self.messageLaterIcon.frame.height)
                    self.messageArchiveIcon.frame = CGRectMake(self.messageImage.frame.origin.x - 20, self.messageArchiveIcon.frame.origin.y, self.messageArchiveIcon.frame.width, self.messageArchiveIcon.frame.height)
                }, completion: nil)
            case 261...320:
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.messageImage.frame = CGRectMake(0, self.messageImage.frame.origin.y, self.messageImage.frame.width, self.messageImage.frame.height)
                    self.messageLaterIcon.frame = CGRectMake(messageImageRightFrameEdge + 20, self.messageLaterIcon.frame.origin.y, self.messageLaterIcon.frame.width, self.messageLaterIcon.frame.height)
                    
                    
//                    self.messageLaterIcon.transform = CGAffineTransformMakeTranslation(-translation.x, 0)
                    println("translation.x = \(translation.x) -translation.x = \(-translation.x)")
                })
            case 60...260:
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.messageImage.transform = CGAffineTransformMakeTranslation(-320, self.messageImage.frame.origin.y)
                    self.messageLaterIcon.transform = CGAffineTransformMakeTranslation(-300, 0)
                    }, completion: {(Bool) -> Void in
                        self.performSegueWithIdentifier("rescheduleSegue", sender: self)
                })
                loadCount += 1
                
            case 0...59:
    
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.messageImage.transform = CGAffineTransformMakeTranslation(-320, self.messageImage.frame.origin.y)
                    self.messageLaterIcon.transform = CGAffineTransformMakeTranslation(-300, 0)
                }, completion: { (Bool) -> Void in
                    self.performSegueWithIdentifier("listSegue", sender: self)
                })
                loadCount += 1
            default:
                println("default view")
            }
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
