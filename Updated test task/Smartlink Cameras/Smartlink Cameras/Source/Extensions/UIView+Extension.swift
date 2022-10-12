//
//  UIView+Extension.swift
//  Smartlink Cameras
//
//  Created by Zakhar Sukhanov on 11.10.2022.
//  Copyright © 2022 SecureNet Technologies, LLC. All rights reserved.
//

import UIKit

enum ContraintsSet {
    case top(value: CGFloat = 0, safeArea: Bool = true)
    case bottom(value: CGFloat = 0, safeArea: Bool = true)
    case leading(value: CGFloat = 0)
    case trailing(value: CGFloat = 0)
    case centerX(value: CGFloat)
    case centerY(value: CGFloat)
    case height(value: CGFloat, isEqual: Bool)
    case width(value: CGFloat, isEqual: Bool)
    
    static var allAround: [ContraintsSet] {
        [.top(), .bottom(), .leading(), .trailing()]
    }
}

extension UIView {
    func place(in view: UIView, withVerticalConstraint vert: CGFloat = 0, andHorizontalConstraints hoz: CGFloat = 0) {
        view.addSubview(self)

        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: view.topAnchor, constant: vert).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: vert).isActive = true
        leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: hoz).isActive = true
        trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: hoz).isActive = true
    }

    func place(in view: UIView, constraints: [ContraintsSet] = ContraintsSet.allAround) {
        view.addSubview(self)
        translatesAutoresizingMaskIntoConstraints = false
        
        for constraint in constraints {
            switch constraint {
            case let .top(value, safeArea):
                if safeArea {
                    topAnchor.constraint(equalTo: view.safeTopAnchor, constant: value).isActive = true
                } else {
                    topAnchor.constraint(equalTo: view.topAnchor, constant: value).isActive = true
                }
            case let .bottom(value, safeArea):
                if safeArea {
                    bottomAnchor.constraint(equalTo: view.safeBottomAnchor, constant: -value).isActive = true
                } else {
                    bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -value).isActive = true
                }
            case .leading(let value):
                leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: value).isActive = true
            case .trailing(let value):
                trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -value).isActive = true
            case .centerX(let value):
                centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: value).isActive = true
            case .centerY(let value):
                centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: value).isActive = true
            case let .height(value, isEqual):
                if isEqual {
                    heightAnchor.constraint(equalTo: view.heightAnchor, constant: value).isActive = true
                } else {
                    heightAnchor.constraint(equalToConstant: value).isActive = true
                }
            case let .width(value, isEqual):
                if isEqual {
                    widthAnchor.constraint(equalTo: view.widthAnchor, constant: value).isActive = true
                } else {
                    widthAnchor.constraint(equalToConstant: value).isActive = true
                }
            }
        }
    }
}

extension UIView {
    var safeTopAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.topAnchor
        }
        return self.topAnchor
    }

    var safeLeadingAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.leadingAnchor
        }
        return self.leadingAnchor
    }

    var safeTrailingAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.trailingAnchor
        }
        return self.trailingAnchor
    }

    var safeBottomAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.bottomAnchor
        }
        return self.bottomAnchor
    }

    var safeCenterYAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.centerYAnchor
        }
        return self.centerYAnchor
    }
}
