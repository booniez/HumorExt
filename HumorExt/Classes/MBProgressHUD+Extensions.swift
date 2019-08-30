import MBProgressHUD

public extension MBProgressHUD {
    
    class func dismissHUD(view: UIView?) {
        guard let view = view else { return }
        MBProgressHUD.hide(for: view, animated: true)
    }
    
    class func showIndicator(text: String, onView: UIView?) {
        guard let onView = onView else {return }
        MBProgressHUD.hide(for: onView, animated: false)
        let hud = MBProgressHUD.showAdded(to: onView, animated: true)
        hud.mode = .indeterminate
        hud.label.text = text
    }
    class func show(text: String, onView: UIView?, delay:Float = 1.0, handler: (() -> Void)? = nil) {
        guard let onView = onView else {return }
        
        MBProgressHUD.hide(for: onView, animated: false)
        let hud = MBProgressHUD.showAdded(to: onView, animated: true)
        hud.mode = .text
        hud.label.text = text
        hud.hide(animated: true, afterDelay: TimeInterval.init(delay))
        if let h = handler {
            DispatchQueue.main
                .asyncAfter(deadline: DispatchTime.now() + TimeInterval.init(delay),
                            execute: h)
        }
    }
    
    class func show(CPError: Error, onView: UIView?) {
        MBProgressHUD.dismissHUD(view: UIApplication.shared.keyWindow?.rootViewController?.view)
        guard let onView = onView else {return}
        
        guard let err = CPError as? CPError, err.errorMessage != "" else {
            return
            
        }
        self.show(text: err.errorMessage, onView: onView, delay: 1.0, handler: nil)
    }
}
