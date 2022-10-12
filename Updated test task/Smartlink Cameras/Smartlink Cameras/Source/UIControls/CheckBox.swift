import RxCocoa
import RxSwift
import UIKit

final class Checkbox: UIControl {

    enum Constants {
        static let widthHeight = 20.0
    }

    var text: String? {
        didSet {
            label.text = text
        }
    }
    
    var checked = BehaviorRelay<Bool>(value: false)
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        label.numberOfLines = 0
        label.isAccessibilityElement = false
        //label.font = Font.Nunito.regular(16.0)
//        label.textColor = themeService.attribute({ $0.black }).value
        return label
    }()
    
    private lazy var checkboxImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage()
        imageView.contentMode = .scaleAspectFit
        imageView.widthAnchor.constraint(equalToConstant: Constants.widthHeight).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: Constants.widthHeight).isActive = true
        imageView.layer.masksToBounds = true
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.borderWidth = 1
        return imageView
    }()
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                accessibilityTraits.update(with: .selected)
                //checkboxImageView.image = WLAssets.Generic.GraphicElements.checkBoxChecked.image
                checkboxImageView.image = UIImage(named: "icon-checkmark")
                
            } else {
                accessibilityTraits.remove(.selected)
                //checkboxImageView.image = WLAssets.Generic.GraphicElements.checkBox.image
                checkboxImageView.image = UIImage()
            }
            checked.accept(isSelected)
        }
    }
    
    override var isEnabled: Bool {
        didSet {
            checkboxImageView.isUserInteractionEnabled = isEnabled
            label.isUserInteractionEnabled = isEnabled
        }
    }

    // MARK: - Initializers
    init() {
        super.init(frame: .zero)
        sharedInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        sharedInit()
    }

    func sharedInit() {
        isAccessibilityElement = true

        let stack = UIStackView(arrangedSubviews: [checkboxImageView, label])
        stack.spacing = 12
        stack.place(in: self)
        stack.alignment = .top

        let didTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTap))
        addGestureRecognizer(didTapGestureRecognizer)
    }
    
    @objc private func didTap() {
        isSelected.toggle()
        sendActions(for: .touchUpInside)
    }
}
