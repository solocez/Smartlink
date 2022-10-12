import UIKit
import RxSwift

protocol MoveUpScreenWhenKeyboardAppears: AnyObject {
    func setupMoveUp()
}

extension MoveUpScreenWhenKeyboardAppears where Self: RxViewController {
    func setupMoveUp() {
        NotificationCenter.default.rx.notification(UIResponder.keyboardWillShowNotification)
            .subscribe(onNext: { [unowned self] notification in
                if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                    if self.view.frame.origin.y == 0 {
                        self.view.frame.origin.y -= keyboardSize.height
                    }
                }
            })
            .disposed(by: bag)

        NotificationCenter.default.rx.notification(UIResponder.keyboardWillHideNotification)
            .subscribe(onNext: { [unowned self] notification in
                if (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue != nil {
                    if self.view.frame.origin.y != 0 {
                        self.view.frame.origin.y = 0
                    }
                }
            })
            .disposed(by: bag)
    }
}
