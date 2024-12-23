//
//  UIView+Extensions.swift
//  JustNews
//

import UIKit
var screenWidth: CGFloat { return UIScreen.main.bounds.width }
func screenWidth(with ratio: CGFloat) -> CGFloat {
    return screenWidth * ratio
}
func screenWidthDivide(with percen: CGFloat) -> CGFloat {
    let widthScreen = (screenWidth * percen) / 100
    let totalScreenWidth = screenWidth -  widthScreen
    return totalScreenWidth
}
var screenHeight: CGFloat { return UIScreen.main.bounds.height }
func screenHeight(with ratio: CGFloat) -> CGFloat {
    return screenHeight * ratio
}
extension UIView {
    func setBorder(width: CGFloat, color: UIColor) {
        layer.borderColor = color.cgColor
        layer.borderWidth = width
    }

    func setCorner(radius: CGFloat) {
        layer.cornerRadius = radius
        clipsToBounds = true
    }
}

// MARK: LEFT
extension UIView {
    /// To set left constraint of view
    /// - Parameters:
    ///     - toAnchor: NSLayoutXAxisAnchor
    ///     - space: CGFloat
    ///     - equality: Int, 1 = equalsTo, 2 = greaterThanOrEqualTo, 0 = lessThanOrEqualTo
    ///     - priority: UILayoutPriority
    ///     - isActive: Bool
    @discardableResult
    public func left(toAnchor anchor: NSLayoutXAxisAnchor,
                     space: CGFloat = 0,
                     equality: Int = 1,
                     priority: UILayoutPriority = .required,
                     isActive: Bool = true) -> NSLayoutConstraint {
        let constraint = getXConstraint(fromAnchor: leftAnchor, toAnchor: anchor, space: space, equality: equality)
        setConstraint(constraint, priority: priority, isActive: isActive)
        return constraint
    }

    @discardableResult
    public func left(toView view: UIView,
                     space: CGFloat = 0,
                     priority: UILayoutPriority = .required,
                     isActive: Bool = true) -> NSLayoutConstraint {
        let constraint = leftAnchor.constraint(equalTo: view.leftAnchor, constant: space)
        setConstraint(constraint, priority: priority, isActive: isActive)
        return constraint
    }

    @discardableResult
    func leftToSuperview(space: CGFloat = 0,
                         priority: UILayoutPriority = .required,
                         isActive: Bool = true) -> NSLayoutConstraint? {
        guard let view = superview else { return nil }
        return left(toView: view, space: space, priority: priority, isActive: isActive)
    }

    @discardableResult
    public func left(toViewSafeArea view: UIView,
                     space: CGFloat = 0,
                     priority: UILayoutPriority = .required,
                     isActive: Bool = true) -> NSLayoutConstraint {
        return left(toAnchor: view.safeAreaLayoutGuide.leftAnchor,
                    space: space,
                    priority: priority,
                    isActive:  isActive)
    }

    @discardableResult
    public func leftToSuperviewSafeArea(space: CGFloat = 0,
                                        priority: UILayoutPriority = .required,
                                        isActive: Bool = true) -> NSLayoutConstraint? {
        guard let view = superview else { return nil }
        return left(toAnchor: view.safeAreaLayoutGuide.leftAnchor,
                    space: space,
                    priority: priority,
                    isActive:  isActive)
    }
}

// MARK: RIGHT
extension UIView {
    /// To set right constraint of view
    /// - Parameters:
    ///     - toAnchor: NSLayoutXAxisAnchor
    ///     - space: CGFloat
    ///     - equality: Int, 1 = equalsTo, 2 = greaterThanOrEqualTo, 0 = lessThanOrEqualTo
    ///     - priority: UILayoutPriority
    ///     - isActive: Bool
    @discardableResult
    public func right(toAnchor anchor: NSLayoutXAxisAnchor,
                      space: CGFloat = 0,
                      equality: Int = 1,
                      priority: UILayoutPriority = .required,
                      isActive: Bool = true) -> NSLayoutConstraint {
        let constraint = getXConstraint(fromAnchor: rightAnchor, toAnchor: anchor, space: space, equality: equality)
        setConstraint(constraint, priority: priority, isActive: isActive)
        return constraint
    }

    @discardableResult
    public func right(toView view: UIView,
                      space: CGFloat = 0,
                      priority: UILayoutPriority = .required,
                      isActive: Bool = true) -> NSLayoutConstraint {
        let constraint = rightAnchor.constraint(equalTo: view.rightAnchor, constant: space)
        setConstraint(constraint, priority: priority, isActive: isActive)
        return constraint
    }

    @discardableResult
    func rightToSuperview(space: CGFloat = 0,
                          priority: UILayoutPriority = .required,
                          isActive: Bool = true) -> NSLayoutConstraint? {
        guard let view = superview else { return nil }
        return right(toView: view, space: space, priority: priority, isActive: isActive)
    }

    @discardableResult
    public func right(toViewSafeArea view: UIView,
                      space: CGFloat = 0,
                      priority: UILayoutPriority = .required,
                      isActive: Bool = true) -> NSLayoutConstraint {
        return right(toAnchor: view.safeAreaLayoutGuide.rightAnchor,
                     space: space,
                     priority: priority,
                     isActive:  isActive)
    }

    @discardableResult
    public func rightToSuperviewSafeArea(space: CGFloat = 0,
                                         priority: UILayoutPriority = .required,
                                         isActive: Bool = true) -> NSLayoutConstraint? {
        guard let view = superview else { return nil }
        return right(toAnchor: view.safeAreaLayoutGuide.rightAnchor,
                     space: space,
                     priority: priority,
                     isActive:  isActive)
    }
}

// MARK: HORIZONTAL
extension UIView {
    @discardableResult
    public func horizontal(toView view: UIView,
                           space: CGFloat = 0,
                           priority: UILayoutPriority = .required,
                           isActive: Bool = true) ->
        (leftConstraint: NSLayoutConstraint, rightConstraint: NSLayoutConstraint) {
            let leftConstraint = left(toView: view,
                                      space: space,
                                      priority: priority,
                                      isActive: isActive)
            let rightConstraint = right(toView: view,
                                        space: -space,
                                        priority: priority,
                                        isActive: isActive)
            return (leftConstraint, rightConstraint)
    }

    @discardableResult
    public func horizontal(toViewSafeArea view: UIView,
                           space: CGFloat = 0,
                           priority: UILayoutPriority = .required,
                           isActive: Bool = true) ->
        (leftConstraint: NSLayoutConstraint, rightConstraint: NSLayoutConstraint) {
            let leftConstraint = left(toViewSafeArea: view,
                                      space: space,
                                      priority: priority,
                                      isActive: isActive)
            let rightConstraint = right(toViewSafeArea: view,
                                        space: -space,
                                        priority: priority,
                                        isActive: isActive)
            return (leftConstraint, rightConstraint)
    }

    @discardableResult
    public func horizontalSuperview(space: CGFloat = 0,
                                    priority: UILayoutPriority = .required,
                                    isActive: Bool = true) ->
        (leftConstraint: NSLayoutConstraint, rightConstraint: NSLayoutConstraint)? {
            guard let view = superview else { return nil }
            return horizontal(toView: view, space: space)
    }

    @discardableResult
    public func horizontalSuperviewSafeArea(space: CGFloat = 0,
                                    priority: UILayoutPriority = .required,
                                    isActive: Bool = true) ->
        (leftConstraint: NSLayoutConstraint, rightConstraint: NSLayoutConstraint)? {
            guard let view = superview else { return nil }
            return horizontal(toViewSafeArea: view, space: space)
    }

    @discardableResult
    public func horizontal(toView view: UIView,
                           leftSpace: CGFloat,
                           rightSpace: CGFloat,
                           priority: UILayoutPriority = .required,
                           isActive: Bool = true)
        -> (leftConstraint: NSLayoutConstraint, rightConstraint: NSLayoutConstraint) {
            let leftConstraint = left(toView: view,
                                      space: leftSpace,
                                      priority: priority,
                                      isActive: isActive)
            let rightConstraint = right(toView: view,
                                        space: rightSpace,
                                        priority: priority,
                                        isActive: isActive)
            return (leftConstraint, rightConstraint)
    }

    @discardableResult
    public func horizontal(toViewSafeArea view: UIView,
                           leftSpace: CGFloat,
                           rightSpace: CGFloat,
                           priority: UILayoutPriority = .required,
                           isActive: Bool = true)
        -> (leftConstraint: NSLayoutConstraint, rightConstraint: NSLayoutConstraint) {
            let leftConstraint = left(toViewSafeArea: view,
                                      space: leftSpace,
                                      priority: priority,
                                      isActive: isActive)
            let rightConstraint = right(toViewSafeArea: view,
                                        space: rightSpace,
                                        priority: priority,
                                        isActive: isActive)
            return (leftConstraint, rightConstraint)
    }
}

// MARK: TOP
extension UIView {
    /// To set top constraint of view
    /// - Parameters:
    ///     - toAnchor: NSLayoutXAxisAnchor
    ///     - space: CGFloat
    ///     - equality: Int, 1 = equalsTo, 2 = greaterThanOrEqualTo, 0 = lessThanOrEqualTo
    ///     - priority: UILayoutPriority
    ///     - isActive: Bool
    @discardableResult
    public func top(toAnchor anchor: NSLayoutYAxisAnchor,
                    space: CGFloat = 0,
                    equality: Int = 1,
                    priority: UILayoutPriority = .required,
                    isActive: Bool = true) -> NSLayoutConstraint {
        let constraint = getYConstraint(fromAnchor: topAnchor, toAnchor: anchor, space: space, equality: equality)
        setConstraint(constraint, priority: priority, isActive: isActive)
        return constraint
    }

    @discardableResult
    public func top(toView view: UIView,
                    space: CGFloat = 0,
                    priority: UILayoutPriority = .required,
                    isActive: Bool = true) -> NSLayoutConstraint {
        let constraint = topAnchor.constraint(equalTo: view.topAnchor, constant: space)
        setConstraint(constraint, priority: priority, isActive: isActive)
        return constraint
    }

    @discardableResult
    func topToSuperview(space: CGFloat = 0,
                        priority: UILayoutPriority = .required,
                        isActive: Bool = true) -> NSLayoutConstraint? {
        guard let view = superview else { return nil }
        return top(toView: view, space: space, priority: priority, isActive: isActive)
    }

    @discardableResult
    public func top(toViewSafeArea view: UIView,
                    space: CGFloat = 0,
                    priority: UILayoutPriority = .required,
                    isActive: Bool = true) -> NSLayoutConstraint {
        return top(toAnchor: view.safeAreaLayoutGuide.topAnchor,
                   space: space,
                   priority: priority,
                   isActive:  isActive)
    }

    @discardableResult
    public func topToSuperviewSafeArea(space: CGFloat = 0,
                                       priority: UILayoutPriority = .required,
                                       isActive: Bool = true) -> NSLayoutConstraint? {
        guard let view = superview else { return nil }
        return top(toAnchor: view.safeAreaLayoutGuide.topAnchor,
                   space: space,
                   priority: priority,
                   isActive:  isActive)
    }
}

// MARK: BOTTOM
extension UIView {
    /// To set bottom constraint of view
    /// - Parameters:
    ///     - toAnchor: NSLayoutXAxisAnchor
    ///     - space: CGFloat
    ///     - equality: Int, 1 = equalsTo, 2 = greaterThanOrEqualTo, 0 = lessThanOrEqualTo
    ///     - priority: UILayoutPriority
    ///     - isActive: Bool
    @discardableResult
    public func bottom(toAnchor anchor: NSLayoutYAxisAnchor,
                       space: CGFloat = 0,
                       equality: Int = 1,
                       priority: UILayoutPriority = .required,
                       isActive: Bool = true) -> NSLayoutConstraint {
        let constraint = getYConstraint(fromAnchor: bottomAnchor, toAnchor: anchor, space: space, equality: equality)
        setConstraint(constraint, priority: priority, isActive: isActive)
        return constraint
    }

    @discardableResult
    public func bottom(toView view: UIView,
                       space: CGFloat = 0,
                       priority: UILayoutPriority = .required,
                       isActive: Bool = true) -> NSLayoutConstraint {
        let constraint = bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: space)
        setConstraint(constraint, priority: priority, isActive: isActive)
        return constraint
    }

    @discardableResult
    func bottomToSuperview(space: CGFloat = 0,
                           priority: UILayoutPriority = .required,
                           isActive: Bool = true) -> NSLayoutConstraint? {
        guard let view = superview else { return nil }
        return bottom(toView: view, space: space, priority: priority, isActive: isActive)
    }

    @discardableResult
    public func bottom(toViewSafeArea view: UIView,
                       space: CGFloat = 0,
                       priority: UILayoutPriority = .required,
                       isActive: Bool = true) -> NSLayoutConstraint {
        return bottom(toAnchor: view.safeAreaLayoutGuide.bottomAnchor,
                      space: space,
                      priority: priority,
                      isActive:  isActive)
    }

    @discardableResult
    public func bottomToSuperviewSafeArea(space: CGFloat = 0,
                                          priority: UILayoutPriority = .required,
                                          isActive: Bool = true) -> NSLayoutConstraint? {
        guard let view = superview else { return nil }
        return bottom(toAnchor: view.safeAreaLayoutGuide.bottomAnchor,
                      space: space,
                      priority: priority,
                      isActive:  isActive)
    }
}

// MARK: VERTICAL
extension UIView {
    @discardableResult
    public func vertical(toView view: UIView,
                         space: CGFloat = 0,
                         priority: UILayoutPriority = .required,
                         isActive: Bool = true) ->
        (topConstraint: NSLayoutConstraint, bottomConstraint: NSLayoutConstraint) {
            let topConstraint = top(toView: view,
                                      space: space,
                                      priority: priority,
                                      isActive: isActive)
            let bottomConstraint = bottom(toView: view,
                                        space: -space,
                                        priority: UILayoutPriority(rawValue: priority.rawValue - 1),
                                        isActive: isActive)
            return (topConstraint, bottomConstraint)
    }

    @discardableResult
    public func vertical(toViewSafeArea view: UIView,
                           space: CGFloat = 0,
                           priority: UILayoutPriority = .required,
                           isActive: Bool = true) ->
        (topConstraint: NSLayoutConstraint, bottomConstraint: NSLayoutConstraint) {
            let topConstraint = top(toViewSafeArea: view,
                                      space: space,
                                      priority: priority,
                                      isActive: isActive)
            let bottomConstraint = bottom(toViewSafeArea: view,
                                        space: -space,
                                        priority: UILayoutPriority(rawValue: priority.rawValue - 1),
                                        isActive: isActive)
            return (topConstraint, bottomConstraint)
    }

    @discardableResult
    public func verticalSuperview(space: CGFloat = 0,
                                    priority: UILayoutPriority = .required,
                                    isActive: Bool = true) ->
        (topConstraint: NSLayoutConstraint, bottomConstraint: NSLayoutConstraint)? {
            guard let view = superview else { return nil }
            return vertical(toView: view, space: space)
    }

    @discardableResult
    public func verticalSuperviewSafeArea(space: CGFloat = 0,
                                    priority: UILayoutPriority = .required,
                                    isActive: Bool = true) ->
        (topConstraint: NSLayoutConstraint, bottomConstraint: NSLayoutConstraint)? {
            guard let view = superview else { return nil }
            return vertical(toViewSafeArea: view, space: space)
    }

    @discardableResult
    public func vertical(toView view: UIView,
                           topSpace: CGFloat,
                           bottomSpace: CGFloat,
                           priority: UILayoutPriority = .required,
                           isActive: Bool = true)
        -> (topConstraint: NSLayoutConstraint, bottomConstraint: NSLayoutConstraint) {
            let topConstraint = top(toView: view,
                                      space: topSpace,
                                      priority: priority,
                                      isActive: isActive)
            let bottomConstraint = bottom(toView: view,
                                        space: bottomSpace,
                                        priority: UILayoutPriority(rawValue: priority.rawValue - 1),
                                        isActive: isActive)
            return (topConstraint, bottomConstraint)
    }

    @discardableResult
    public func vertical(toViewSafeArea view: UIView,
                           topSpace: CGFloat,
                           bottomSpace: CGFloat,
                           priority: UILayoutPriority = .required,
                           isActive: Bool = true)
        -> (topConstraint: NSLayoutConstraint, bottomConstraint: NSLayoutConstraint) {
            let topConstraint = top(toViewSafeArea: view,
                                      space: topSpace,
                                      priority: priority,
                                      isActive: isActive)
            let bottomConstraint = bottom(toViewSafeArea: view,
                                        space: bottomSpace,
                                        priority: UILayoutPriority(rawValue: priority.rawValue - 1),
                                        isActive: isActive)
            return (topConstraint, bottomConstraint)
    }
}

// MARK: FILLING
extension UIView {

    @discardableResult
    public func fill(toView view: UIView,
                     space: UIEdgeInsets = .zero,
                     priority: UILayoutPriority = .required,
                     isActive: Bool = true)
        -> (left: NSLayoutConstraint, top: NSLayoutConstraint,
        right: NSLayoutConstraint, bottom: NSLayoutConstraint) {
            let leftCons = left(toView: view, space: space.left, priority: priority, isActive: isActive)
            let rightCons = right(toView: view, space: -space.right, priority: priority, isActive: isActive)
            let topCons = top(toView: view, space: space.top, priority: priority, isActive: isActive)
            let bottomCons = bottom(toView: view, space: -space.bottom, priority: priority, isActive: isActive)
            return (leftCons, topCons, rightCons, bottomCons)
    }

    @discardableResult
    public func fillViewSafeArea(toView view: UIView,
                     space: UIEdgeInsets = .zero,
                     priority: UILayoutPriority = .required,
                     isActive: Bool = true)
        -> (left: NSLayoutConstraint, top: NSLayoutConstraint,
        right: NSLayoutConstraint, bottom: NSLayoutConstraint) {
            let leftCons = left(toViewSafeArea: view, space: space.left, priority: priority, isActive: isActive)
            let rightCons = right(toViewSafeArea: view, space: -space.right, priority: priority, isActive: isActive)
            let topCons = top(toViewSafeArea: view, space: space.top, priority: priority, isActive: isActive)
            let bottomCons = bottom(toViewSafeArea: view, space: -space.bottom, priority: priority, isActive: isActive)
            return (leftCons, topCons, rightCons, bottomCons)
    }

    @discardableResult
    func fillSuperView(space: UIEdgeInsets = .zero,
                       priority: UILayoutPriority = .required,
                       isActive: Bool = true)
    -> (left: NSLayoutConstraint, top: NSLayoutConstraint,
    right: NSLayoutConstraint, bottom: NSLayoutConstraint)? {
        guard let view = superview else { return nil }
        return fill(toView: view, space: space, priority: priority)
    }

    @discardableResult
    func fillSuperviewSafeArea(space: UIEdgeInsets = .zero,
                                 priority: UILayoutPriority = .required,
                                 isActive: Bool = true)
    -> (left: NSLayoutConstraint, top: NSLayoutConstraint,
    right: NSLayoutConstraint, bottom: NSLayoutConstraint)? {
        guard let view = superview else { return nil }
        return fillViewSafeArea(toView: view)
    }
}

// MARK: CORNER
extension UIView {
    @discardableResult
    public func topLeft(toView view: UIView,
                        topSpace: CGFloat = 0,
                        leftSpace: CGFloat = 0,
                        priority: UILayoutPriority = .required,
                        isActive: Bool = true)
        -> (top: NSLayoutConstraint, left: NSLayoutConstraint) {
            let topConstraint = top(toView: view,
                                    space: topSpace,
                                    priority: priority,
                                    isActive: isActive)
            let leftConstraint = left(toView: view,
                                      space: leftSpace,
                                      priority: priority,
                                      isActive: isActive)
            return (topConstraint, leftConstraint)
    }

    @discardableResult
    func topLeftToSuperView(topSpace: CGFloat = 0,
                    leftSpace: CGFloat = 0,
                    priority: UILayoutPriority = .required,
                    isActive: Bool = true)
    -> (top: NSLayoutConstraint, left: NSLayoutConstraint) {
        guard let view = superview else { fatalError() }
        return topLeft(toView: view, topSpace: topSpace, leftSpace: leftSpace, priority: priority, isActive: isActive)
    }

    @discardableResult
    public func topRight(toView view: UIView,
                         topSpace: CGFloat = 0,
                         rightSpace: CGFloat = 0,
                         priority: UILayoutPriority = .required,
                         isActive: Bool = true)
        -> (top: NSLayoutConstraint, right: NSLayoutConstraint) {
            let topConstraint = top(toView: view,
                                    space: topSpace,
                                    priority: priority,
                                    isActive: isActive)
            let rightConstraint = right(toView: view,
                                        space: rightSpace,
                                        priority: priority,
                                        isActive: isActive)
            return (topConstraint, rightConstraint)
    }

    @discardableResult
    func topRightToSuperView(topSpace: CGFloat = 0,
                    rightSpace: CGFloat = 0,
                    priority: UILayoutPriority = .required,
                    isActive: Bool = true)
    -> (top: NSLayoutConstraint, right: NSLayoutConstraint) {
        guard let view = superview else { fatalError() }
        return topRight(toView: view, topSpace: topSpace, rightSpace: rightSpace, priority: priority, isActive: isActive)
    }

    @discardableResult
    public func bottomLeft(toView view: UIView,
                           bottomSpace: CGFloat = 0,
                           leftSpace: CGFloat = 0,
                           priority: UILayoutPriority = .required,
                           isActive: Bool = true)
        -> (bottom: NSLayoutConstraint, left: NSLayoutConstraint) {
            let bottomConstraint = bottom(toView: view,
                                          space: bottomSpace,
                                          priority: priority,
                                          isActive: isActive)
            let leftConstraint = left(toView: view,
                                      space: leftSpace,
                                      priority: priority,
                                      isActive: isActive)
            return (bottomConstraint, leftConstraint)
    }

    @discardableResult
    public func bottomRight(toView view: UIView,
                            bottomSpace: CGFloat = 0,
                            rightSpace: CGFloat = 0,
                            priority: UILayoutPriority = .required,
                            isActive: Bool = true)
        -> (bottom: NSLayoutConstraint, right: NSLayoutConstraint) {
            let bottomConstraint = bottom(toView: view,
                                          space: bottomSpace,
                                          priority: priority,
                                          isActive: isActive)
            let rightConstraint = self.right(toView: view,
                                             space: rightSpace,
                                             priority: priority,
                                             isActive: isActive)
            return (bottomConstraint, rightConstraint)
    }
}

// MARK: SPACING
extension UIView {

    @discardableResult
    public func verticalSpacing(toView view: UIView,
                                space: CGFloat = 0,
                                priority: UILayoutPriority = .required,
                                isActive: Bool = true) -> NSLayoutConstraint {
        return top(toAnchor: view.bottomAnchor,
                   space: space,
                   priority: priority,
                   isActive: isActive)
    }

    @discardableResult
    public func verticalSpacingDown(toView view: UIView,
                                    space: CGFloat = 0,
                                    priority: UILayoutPriority = .required,
                                    isActive: Bool = true) -> NSLayoutConstraint {
        return bottom(toAnchor: view.topAnchor,
                      space: space,
                      priority: priority,
                      isActive: isActive)
    }

    @discardableResult
    public func horizontalSpacing(toView view: UIView,
                                  space: CGFloat = 0,
                                  priority: UILayoutPriority = .required,
                                  isActive: Bool = true) -> NSLayoutConstraint {
        return right(toAnchor: view.leftAnchor,
                     space: -space,
                     priority: priority,
                     isActive: isActive)
    }

    @discardableResult
    public func leftHorizontalSpacing(toView view: UIView,
                                      space: CGFloat = 0,
                                      priority: UILayoutPriority = .required,
                                      isActive: Bool = true) -> NSLayoutConstraint {
        return left(toAnchor: view.rightAnchor, space: space,
                    priority: priority,
                    isActive: isActive)
    }

}

// MARK: WIDTH
extension UIView {
    @discardableResult
    public func width(_ value: CGFloat,
                      priority: UILayoutPriority = .required,
                      isActive: Bool = true) -> NSLayoutConstraint {
        let constraint = widthAnchor.constraint(equalToConstant: value)
        setConstraint(constraint, priority: priority, isActive: isActive)
        return constraint
    }

    @discardableResult
    public func width(toDimension dimension: NSLayoutDimension,
                      multiplier: CGFloat = 1,
                      greater: CGFloat = 0,
                      priority: UILayoutPriority = .required,
                      isActive: Bool = true) -> NSLayoutConstraint {
        let constraint = widthAnchor.constraint(equalTo: dimension,
                                                multiplier: multiplier,
                                                constant: greater)
        setConstraint(constraint, priority: priority, isActive: isActive)
        return constraint
    }

    @discardableResult
    public func width(toView view: UIView,
                      multiplier: CGFloat = 1,
                      greater: CGFloat = 0,
                      priority: UILayoutPriority = .required,
                      isActive: Bool = true) -> NSLayoutConstraint {
        return width(toDimension: view.widthAnchor,
                     multiplier: multiplier,
                     greater: greater,
                     priority: priority,
                     isActive: isActive)
    }
}

// MARK: HEIGHT
extension UIView {
    @discardableResult
    public func height(_ value: CGFloat,
                       priority: UILayoutPriority = .required,
                       isActive: Bool = true) -> NSLayoutConstraint {
        let constraint = heightAnchor.constraint(equalToConstant: value)
        setConstraint(constraint, priority: priority, isActive: isActive)
        return constraint
    }

    @discardableResult
    public func height(toDimension dimension: NSLayoutDimension,
                       multiplier: CGFloat = 1,
                       greater: CGFloat = 0,
                       priority: UILayoutPriority = .required,
                       isActive: Bool = true) -> NSLayoutConstraint {
        let constraint = heightAnchor.constraint(equalTo: dimension,
                                                 multiplier: multiplier,
                                                 constant: greater)
        setConstraint(constraint, priority: priority, isActive: isActive)
        return constraint
    }

    @discardableResult
    public func height(toView view: UIView,
                       multiplier: CGFloat = 1,
                       greater: CGFloat = 0,
                       priority: UILayoutPriority = .required,
                       isActive: Bool = true) -> NSLayoutConstraint {
        return height(toDimension: view.heightAnchor,
                      multiplier: multiplier,
                      greater: greater,
                      priority: priority,
                      isActive: isActive)
    }
}

// MARK: SIZING
extension UIView {
    @discardableResult
    public func size(_ value: CGSize,
                     multiplier: CGFloat = 1,
                     priority: UILayoutPriority = .required,
                     isActive: Bool = true)
        -> (widthConstraint: NSLayoutConstraint, heightConstraint: NSLayoutConstraint) {
            let widthConstraint = width(value.width, priority: priority, isActive: isActive)
            let heightConstraint = height(value.height, priority: priority, isActive: isActive)
            return (widthConstraint, heightConstraint)
    }

    @discardableResult
    public func size(width _width: CGFloat,
                     height _height: CGFloat,
                     multiplier: CGFloat = 1,
                     priority: UILayoutPriority = .required,
                     isActive: Bool = true)
        -> (widthConstraint: NSLayoutConstraint, heightConstraint: NSLayoutConstraint) {
            let widthConstraint = width(_width, priority: priority, isActive: isActive)
            let heightConstraint = height(_height, priority: priority, isActive: isActive)
            return (widthConstraint, heightConstraint)
    }

    @discardableResult
    public func size(toView view: UIView,
                     multiplier: CGFloat = 1,
                     greater: CGSize = .zero,
                     priority: UILayoutPriority = .required,
                     isActive: Bool = true)
        -> (widthConstraint: NSLayoutConstraint, heightConstraint: NSLayoutConstraint) {
            let widthConstraint = width(toView: view,
                                        multiplier: multiplier,
                                        greater: greater.width,
                                        priority: priority,
                                        isActive: isActive)
            let heightConstraint = height(toView: view,
                                          multiplier: multiplier,
                                          greater: greater.height,
                                          priority: priority,
                                          isActive: isActive)
            return (widthConstraint, heightConstraint)
    }

    @discardableResult
    public func square(edge: CGFloat,
                       multiplier: CGFloat = 1,
                       priority: UILayoutPriority = .required,
                       isActive: Bool = true)
        -> (widthConstraint: NSLayoutConstraint, heightConstraint: NSLayoutConstraint) {
            return size(CGSize(width: edge, height: edge),
                        multiplier: multiplier,
                        priority: priority,
                        isActive: isActive)
    }

    public func square(priority: UILayoutPriority = .required,
                       isActive: Bool = true) {
        width(toDimension: heightAnchor,
              multiplier: 1,
              greater: 0,
              priority: priority,
              isActive: isActive)
    }
}

// MARK: CENTER X
extension UIView {

    @discardableResult
    public func centerX(toAnchor anchor: NSLayoutXAxisAnchor,
                        space: CGFloat = 0,
                        priority: UILayoutPriority = .required,
                        isActive: Bool = true) -> NSLayoutConstraint {
        let constraint = centerXAnchor.constraint(equalTo: anchor, constant: space)
        constraint.isActive = isActive
        return constraint
    }

    @discardableResult
    public func centerX(toView view: UIView,
                        space: CGFloat = 0,
                        priority: UILayoutPriority = .required,
                        isActive: Bool = true) -> NSLayoutConstraint {
        return centerX(toAnchor: view.centerXAnchor, space: space, priority: priority, isActive: isActive)
    }

    @discardableResult
    public func centerXToSuperview(space: CGFloat = 0,
                                   priority: UILayoutPriority = .required,
                                   isActive: Bool = true) -> NSLayoutConstraint? {
        guard let view = superview else { return nil }
        return centerX(toView: view, space: space, priority: priority, isActive: isActive)
    }
}

// MARK: CENTER Y
extension UIView {

    @discardableResult
    public func centerY(toAnchor anchor: NSLayoutYAxisAnchor,
                        space: CGFloat = 0,
                        priority: UILayoutPriority = .required,
                        isActive: Bool = true) -> NSLayoutConstraint {
        let constraint = centerYAnchor.constraint(equalTo: anchor, constant: space)
        constraint.isActive = isActive
        return constraint
    }

    @discardableResult
    public func centerY(toView view: UIView,
                        space: CGFloat = 0,
                        priority: UILayoutPriority = .required,
                        isActive: Bool = true) -> NSLayoutConstraint {
        return centerY(toAnchor: view.centerYAnchor, space: space, priority: priority, isActive: isActive)
    }

    @discardableResult
    public func centerYToSuperview(space: CGFloat = 0,
                                   priority: UILayoutPriority = .required,
                                   isActive: Bool = true) -> NSLayoutConstraint? {
        guard let view = superview else { return nil }
        return centerY(toView: view, space: space, priority: priority, isActive: isActive)
    }
}

// MARK: CENTER
extension UIView {

    @discardableResult
    public func center(toView view: UIView,
                       spaceX: CGFloat = 0,
                       spaceY: CGFloat = 0,
                       priority: UILayoutPriority = .required,
                       isActive: Bool = true)
        -> ( NSLayoutConstraint, NSLayoutConstraint) {
            let xConstraint = centerX(toView: view, space: spaceX, priority: priority, isActive: isActive)
            let yConstraint = centerY(toView: view, space: spaceY, priority: priority, isActive: isActive)
            return (xConstraint, yConstraint)
    }

    @discardableResult
    public func centerSuperview(spaceX: CGFloat = 0,
                                spaceY: CGFloat = 0,
                                priority: UILayoutPriority = .required,
                                isActive: Bool = true) -> ( NSLayoutConstraint, NSLayoutConstraint)? {
        guard let superview = superview else { return nil }
        return center(toView: superview, spaceX: spaceX, spaceY: spaceY, priority: priority, isActive: isActive)
    }

}

// MARK: STACK
extension UIView {

    enum StackStickType {
        case left, right, horizontal
        case top, bottom, vertical
        case none
    }

    func stackHorizontally(views: [UIView],
                           viewSpaces: CGFloat = 0,
                           leftSpace: CGFloat? = nil,
                           rightSpace: CGFloat? = nil) {
        var constraintsString = "H:"
        if let space = leftSpace {
            constraintsString += "|-\(space)-"
        }

        for index in 0 ..< views.count - 1 {
            constraintsString += "[v\(index)]-\(viewSpaces)-"
        }

        constraintsString += "[v\(views.count - 1)]"

        if let space = rightSpace {
            constraintsString += "-\(space)-|"
        }
        addConstraints(withFormat: constraintsString, arrayOf: views)
    }

    func stackVertically(views: [UIView],
                         viewSpaces: CGFloat,
                         topSpace: CGFloat? = nil,
                         bottomSpace: CGFloat? = nil) {
        var constraintsString = "V:"
        if let space = topSpace {
            constraintsString += "|-\(space)-"
        }

        for index in 0 ..< views.count - 1 {
            constraintsString += "[v\(index)]-\(viewSpaces)-"
        }

        constraintsString += "[v\(views.count - 1)]"

        if let space = bottomSpace {
            constraintsString += "-\(space)-|"
        }
        addConstraints(withFormat: constraintsString, arrayOf: views)
    }
}

// MARK: GENERIC THINGS
extension UIView {
    @discardableResult
    func addConstraint(attribute: NSLayoutConstraint.Attribute,
                       equalTo view: UIView,
                       toAttribute: NSLayoutConstraint.Attribute,
                       multiplier: CGFloat = 1,
                       constant: CGFloat = 0,
                       isActive: Bool = true) -> NSLayoutConstraint {
        let myConstraint = NSLayoutConstraint(
            item: self,
            attribute: attribute,
            relatedBy: .equal,
            toItem: view,
            attribute: toAttribute,
            multiplier: multiplier,
            constant: constant)
        myConstraint.isActive = isActive
        return myConstraint
    }

    func addConstraints(withFormat format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()

        for index in 0 ..< views.count {
            let key = "v\(index)"
            views[index].translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = views[index]
        }

        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
    }

    func addConstraints(withFormat format: String, arrayOf views: [UIView]) {
        var viewsDictionary = [String: UIView]()

        for index in 0 ..< views.count {
            let key = "v\(index)"
            views[index].translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = views[index]
        }

        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
    }

    func removeAllConstraints() {
        removeConstraints(constraints)
    }

    func addSubviews(views: UIView...) {
        for view in views {
            view.translatesAutoresizingMaskIntoConstraints = false
            addSubview(view)
        }
    }

    private func setConstraint(_ constraint: NSLayoutConstraint,
                               priority: UILayoutPriority,
                               isActive: Bool) {
        constraint.priority = priority
        constraint.isActive = isActive
    }
    
    private func getXConstraint(fromAnchor: NSLayoutXAxisAnchor,
                                toAnchor anchor: NSLayoutXAxisAnchor,
                                space: CGFloat = 0,
                                equality: Int = 1) -> NSLayoutConstraint {
        
        var constraint: NSLayoutConstraint
        if equality == 2 {
            constraint = fromAnchor.constraint(greaterThanOrEqualTo: anchor, constant: space)
        } else if equality == 0 {
            constraint = fromAnchor.constraint(lessThanOrEqualTo: anchor, constant: space)
        } else {
            constraint = fromAnchor.constraint(equalTo: anchor, constant: space)
        }
        return constraint
    }
    
    private func getYConstraint(fromAnchor: NSLayoutYAxisAnchor,
                                toAnchor anchor: NSLayoutYAxisAnchor,
                                space: CGFloat = 0,
                                equality: Int = 1) -> NSLayoutConstraint {
        
        var constraint: NSLayoutConstraint
        if equality == 2 {
            constraint = fromAnchor.constraint(greaterThanOrEqualTo: anchor, constant: space)
        } else if equality == 0 {
            constraint = fromAnchor.constraint(lessThanOrEqualTo: anchor, constant: space)
        } else {
            constraint = fromAnchor.constraint(equalTo: anchor, constant: space)
        }
        return constraint
    }
    
}
