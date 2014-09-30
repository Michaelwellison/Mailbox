//
//  MailboxViewController.swift
//  Mailbox-Swift
//
//  Created by Michael Ellison on 9/24/14.
//  Copyright (c) 2014 MichaelWEllison. All rights reserved.
//

import UIKit

class MailboxViewController: UIViewController, UIGestureRecognizerDelegate {
   
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
    @IBOutlet weak var laterBackgroundImage: UIImageView!
    @IBOutlet weak var archiveBackgroundImage: UIImageView!
    
    // MARK: Variables
    
    var contentViewCenter: CGPoint!
    var messageImageCenter: CGPoint!
    var messageLaterIconCenter: CGPoint!
    var loadCount = 0
    var messageImageOrigin: CGPoint!
    var conditionForPanLeft: Bool = false
    
    // MARK: View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureScrollView()
        configureContentView()
    }
    
    override func viewDidAppear(animated: Bool) {
        if loadCount > 0 {
            
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                self.messageContainerView.backgroundColor = UIColor(red: 0.918, green: 0.922, blue: 0.925, alpha: 1)
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
        var leftEdgeGesture = UIScreenEdgePanGestureRecognizer(target: self, action: "onLeftEdgePan:")
        leftEdgeGesture.edges = UIRectEdge.Left
        contentView.addGestureRecognizer(leftEdgeGesture)
        
        var rightEdgeGesture = UIScreenEdgePanGestureRecognizer(target: self, action: "onRightEdgePan:")
        rightEdgeGesture.edges = UIRectEdge.Right
        contentView.addGestureRecognizer(rightEdgeGesture)
    }
    
    // MARK: UI Gesture Recognizer Delegate
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        
        return true
    }
    
    // MARK: Functions
    
    func animateContentInset() {
        
        UIView.animateWithDuration(2.0, animations: { () -> Void in
            self.feedScrollView.contentInset = UIEdgeInsets(top: -86, left: 0, bottom: 0, right: 0)
        })
    }
    
    // MARK: Gesture Actions
    
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
                self.messageContainerView.backgroundColor = UIColor(red: 0.918, green: 0.922, blue: 0.925, alpha: 1)
            case 260...320:
                println("test case 1 because right frame edge = \(messageImageRightFrameEdge)")
                messageLaterIcon.center.x = messageImage.center.x + 183
                messageLaterIcon.alpha += 0.025
                self.messageContainerView.backgroundColor = UIColor(red: 0.918, green: 0.922, blue: 0.925, alpha: 1)
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
                println(messageImage.center.x)
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
    
    // MARK: Edge Pan Actions
    
    @IBAction func onLeftEdgePan(leftEdgePan: UIScreenEdgePanGestureRecognizer) {
        var location = leftEdgePan.locationInView(view)
        var translation = leftEdgePan.translationInView(view)
        var velocity = leftEdgePan.velocityInView(view)
        
        if leftEdgePan.state == UIGestureRecognizerState.Began {
            
            contentViewCenter = contentView.center
            
        } else if leftEdgePan.state == UIGestureRecognizerState.Changed {
            
            contentView.center.x = translation.x + contentViewCenter.x
            
        } else if leftEdgePan.state == UIGestureRecognizerState.Ended {
            if velocity.x < 0 {
                UIView.animateWithDuration(0.25, animations: { () -> Void in
                    self.contentView.center.x = self.contentViewCenter.x
                })
            } else {
                UIView.animateWithDuration(0.25, animations: { () -> Void in
                    self.contentView.frame.origin.x = 280
                })
                conditionForPanLeft = true
            }
        }
    }
    
    @IBAction func onRightEdgePan(rightEdgePan: UIScreenEdgePanGestureRecognizer) {
        var translation = rightEdgePan.translationInView(view)
        var velocity = rightEdgePan.velocityInView(view)
        
       
        if conditionForPanLeft == true {
            if rightEdgePan.state == UIGestureRecognizerState.Began {
                
                contentViewCenter = contentView.center
                
            } else if rightEdgePan.state == UIGestureRecognizerState.Changed {
                
                contentView.center.x = translation.x + contentViewCenter.x
                
                println(velocity.x)
                
            } else if rightEdgePan.state == UIGestureRecognizerState.Ended {
                if velocity.x > 0 {
                    UIView.animateWithDuration(0.25, animations: { () -> Void in
                        self.contentView.center.x = self.contentViewCenter.x
                    })
                } else {
                    UIView.animateWithDuration(0.25, animations: { () -> Void in
                        self.contentView.frame.origin.x = 0
                    })
                    
                    conditionForPanLeft = false
                }
            }
        }
        
    }
    
    // MARK: Segmented Control Action
    
    @IBAction func onTapSegmentedControl(segmentedControl: UISegmentedControl) {
        
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            segmentedControl.tintColor = UIColor(red: 0.969, green: 0.816, blue: 0.278, alpha: 1)

            UIView.animateWithDuration(0.5, animations: { () -> Void in
                self.laterBackgroundImage.transform = CGAffineTransformMakeTranslation(self.laterBackgroundImage.frame.width, 0)
                self.archiveBackgroundImage.transform = CGAffineTransformMakeTranslation(self.archiveBackgroundImage.frame.width, 0)
            })
        case 1:
            segmentedControl.tintColor = UIColor(red: 0.502, green: 0.765, blue: 0.871, alpha: 1)

            UIView.animateWithDuration(0.5, animations: { () -> Void in
                self.laterBackgroundImage.transform = CGAffineTransformMakeTranslation(-self.laterBackgroundImage.frame.width, 0)
                self.archiveBackgroundImage.transform = CGAffineTransformMakeTranslation(self.archiveBackgroundImage.frame.width, 0)
            })
        case 2:
            segmentedControl.tintColor = UIColor(red: 0.545, green: 0.812, blue: 0.392, alpha: 1)

            UIView.animateWithDuration(0.5, animations: { () -> Void in
                self.archiveBackgroundImage.transform = CGAffineTransformMakeTranslation(-self.archiveBackgroundImage.frame.width, 0)
                self.laterBackgroundImage.transform = CGAffineTransformMakeTranslation(-self.laterBackgroundImage.frame.width, 0)
            })
        default:
            println("go home")
        }
        
    }
    
    // MARK: Shake Action
    
    override func motionBegan(motion: UIEventSubtype, withEvent event: UIEvent) {
        if loadCount > 0 {
            
            self.messageImage.frame.origin.x = self.feedScrollView.frame.origin.x
            
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                self.messageContainerView.backgroundColor = UIColor(red: 0.918, green: 0.922, blue: 0.925, alpha: 1)
                self.messageImage.frame = CGRectMake(0, 0, 320, 86)
            
                self.feedImageView.frame.origin.y += self.messageContainerView.frame.height
                self.messageContainerView.frame.origin.y += self.messageContainerView.frame.height
            })
            
            loadCount = 0
            
        } else {
        
            println("do nothing")
        
        }
        
    }
    
}
