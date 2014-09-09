

import UIKit
func delay(delay:Double, closure:()->()) {
    dispatch_after(
        dispatch_time(
            DISPATCH_TIME_NOW,
            Int64(delay * Double(NSEC_PER_SEC))
        ),
        dispatch_get_main_queue(), closure)
}

func animateTimes(times:Int, #duration: NSTimeInterval,
    #delay: NSTimeInterval, #options: UIViewAnimationOptions,
    #animations: () -> Void , #completion: ((Bool) -> Void)?) {
        animHelper(times-1, duration, delay, options, animations, completion)
}

func animHelper(t:Int, dur: NSTimeInterval, del: NSTimeInterval,
    opt: UIViewAnimationOptions,
    anim: () -> Void , com: ((Bool) -> Void)?) {
        UIView.animateWithDuration(dur, delay: del, options: opt,
            animations: anim, completion: {
                done in
                if com != nil {
                    com!(done)
                }
                if t > 0 {
                    animHelper(t-1, dur, del, opt, anim, com)
                }
        })
}

class ViewController: UIViewController {
    @IBOutlet weak var v: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let which = 9
        
        delay(3) {
            println(0)
            println(self.v.center.y)
            switch which {
            case 1:
                UIView.animateWithDuration(0.4, animations: {
                    self.v.backgroundColor = UIColor.redColor()
                })
            case 2:
                UIView.animateWithDuration(0.4, animations: {
                    self.v.backgroundColor = UIColor.redColor()
                    self.v.center.y += 100
                })
            case 3:
                let v2 = UIView()
                v2.backgroundColor = UIColor.blackColor()
                v2.alpha = 0
                v2.frame = self.v.frame
                self.v.superview!.addSubview(v2)
                UIView.animateWithDuration(0.4, animations: {
                    self.v.alpha = 0
                    v2.alpha = 1
                    }, completion: {
                        _ in
                        self.v.removeFromSuperview()
                })
            case 4:
                UIView.animateWithDuration(0.4, animations: {
                    self.v.backgroundColor = UIColor.redColor()
                    UIView.performWithoutAnimation {
                        self.v.center.y += 100
                    }
                })
            case 5:
                UIView.animateWithDuration(2, animations: {
                    println(2)
                    println(self.v.center.y)
                    self.v.center.y = 100
                    println(3)
                    println(self.v.center.y)
                    }, completion: {
                        _ in
                        println(4)
                        println(self.v.center.y)
                })
                self.v.center.y = 300
                println(1)
                println(self.v.center.y)
            case 6:
                UIView.animateWithDuration(2, animations: {
                    self.v.center.y = 100
                    self.v.center.y = 300
                })
            case 7:
                let opts = UIViewAnimationOptions.Autoreverse
                let xorig = self.v.center.x
                UIView.animateWithDuration(1, delay: 0, options: opts, animations: {
                    self.v.center.x += 100
                    }, completion: {
                        _ in
                        self.v.center.x = xorig
                })
            case 8:
                self.animate(2)
            case 9:
                let opts = UIViewAnimationOptions.Autoreverse
                let xorig = self.v.center.x
                animateTimes(3, duration:1, delay:0, options:opts, animations:{
                    self.v.center.x += 100
                    }, completion:{
                        _ in
                        self.v.center.x = xorig
                })
            default:break
            }
        }
    }
    
    func animate(count:Int) {
        let opts = UIViewAnimationOptions.Autoreverse
        let xorig = self.v.center.x
        UIView.animateWithDuration(1, delay: 0, options: opts, animations: {
            self.v.center.x += 100
            }, completion: {
                _ in
                self.v.center.x = xorig
                if count > 0 {
                    self.animate(count-1)
                }
        })
    }
    
}

