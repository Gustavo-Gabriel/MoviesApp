import UIKit

public class AutoLayout {
    let view: UIView
    
    public var height: NSLayoutDimension { return view.heightAnchor }
    public var widht: NSLayoutDimension { return view.widthAnchor }
    
    init(view: UIView) {
        self.view = view
    }
    
    public func applyConstraint(_ block: ((AutoLayout) -> Void)) {
        view.translatesAutoresizingMaskIntoConstraints = false
        block(self)
    }
    
    public func edges(in superView: UIView,
                      with offSet: UIEdgeInsets? = nil) {
        let constraints = NSLayoutConstraint.inset(view: self.view,
                                                   inSuperView: superView,
                                                   withInset: offSet)
        
        constraints.activate()
    }
    
    public func edges(in superView: UIView,
                      offSet: CGFloat,
                      priority: UILayoutPriority = .required) {
        let inset = UIEdgeInsets(top: offSet, left: offSet, bottom: offSet, right: offSet)
        let constraints = NSLayoutConstraint.inset(view: self.view,
                                                   inSuperView: superView,
                                                   withInset: inset)
        
        constraints.forEach { $0.priority = priority }
        constraints.activate()
    }
    
    @discardableResult
    public func top(alignedWith view: UIView,
                    relation: NSLayoutConstraintType = .equal,
                    offSet: Float = 0,
                    priority: UILayoutPriority = .required) -> NSLayoutConstraint {

        let constraint = NSLayoutConstraint.top(firstView: self.view,
                                                secondView: view,
                                                relation: relation,
                                                constant: offSet)
        
        constraint.priority = priority
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    public func left(alignedWith: UIView,
                    relation: NSLayoutConstraintType = .equal,
                    offSet: Float = 0,
                    priority: UILayoutPriority = .required) -> NSLayoutConstraint {

        let constraint = NSLayoutConstraint.left(firstView: self.view,
                                                secondView: alignedWith,
                                                relation: relation,
                                                constant: offSet)
        
        constraint.priority = priority
        constraint.isActive = true
        return constraint
    }

    @discardableResult
    public func right(alignedWith: UIView,
                    relation: NSLayoutConstraintType = .equal,
                    offSet: Float = 0,
                    priority: UILayoutPriority = .required) -> NSLayoutConstraint {

        let constraint = NSLayoutConstraint.right(firstView: self.view,
                                                secondView: alignedWith,
                                                relation: relation,
                                                constant: -offSet)
        
        constraint.priority = priority
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    public func bottom(alignedWith: UIView,
                    relation: NSLayoutConstraintType = .equal,
                    offSet: Float = 0,
                    priority: UILayoutPriority = .required) -> NSLayoutConstraint {

        let constraint = NSLayoutConstraint.bottom(firstView: self.view,
                                                secondView: alignedWith,
                                                relation: relation,
                                                constant: -offSet)
        
        constraint.priority = priority
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    public func baseLine(alignedWith: UIView,
                    relation: NSLayoutConstraintType = .equal,
                    offSet: Float = 0) -> NSLayoutConstraint {

        let constraint = NSLayoutConstraint.baseLine(firstView: self.view,
                                                secondView: alignedWith,
                                                relation: relation,
                                                constant: -offSet)

        constraint.isActive = true
        return constraint
    }

    @discardableResult
    public func under(view: UIView,
                      relation: NSLayoutConstraintType = .equal,
                      offSet: Float = 0,
                      priority: UILayoutPriority = .required) -> NSLayoutConstraint {

        let constraint = NSLayoutConstraint.over(topItem: view,
                                                 bottomItem: self.view,
                                                 relation: relation,
                                                 constant: offSet)

        constraint.priority = priority
        constraint.isActive = true
        return constraint
    }

    @discardableResult
    public func above(view: UIView,
                      relation: NSLayoutConstraintType = .equal,
                      offSet: Float = 0,
                      priority: UILayoutPriority = .required) -> NSLayoutConstraint {

        let constraint = NSLayoutConstraint.over(topItem: self.view,
                                                 bottomItem: view,
                                                 relation: relation,
                                                 constant: offSet)
        
        constraint.priority = priority
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    public func right(of view: UIView,
                      relation: NSLayoutConstraintType = .equal,
                      offSet: Float = 0) -> NSLayoutConstraint {

        let constraint = NSLayoutConstraint.aside(left: view,
                                                  right: self.view,
                                                  relation: relation,
                                                  constant: offSet)
        
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    public func left(of view: UIView,
                     relation: NSLayoutConstraintType = .equal,
                     offSet: Float = 0) -> NSLayoutConstraint {

        let constraint = NSLayoutConstraint.aside(left: self.view,
                                                  right: view,
                                                  relation: relation,
                                                  constant: offSet)
        
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    public func height(relatedTo view: UIView,
                       relation: NSLayoutConstraintType = .equal,
                       priority: UILayoutPriority = .required,
                       multiplier: CGFloat = 1,
                       _ size: Float = 0) -> NSLayoutConstraint {

        let constraint = NSLayoutConstraint.height(firstView: self.view,
                                                   secondView: view,
                                                   relation: relation,
                                                   constant: size,
                                                   multiplier: multiplier)
        
        constraint.priority = priority
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    public func height(relation: NSLayoutConstraintType = .equal,
                       priority: UILayoutPriority = .required,
                       _ size: Float = 0) -> NSLayoutConstraint {

        let constraint = NSLayoutConstraint.height(view: self.view,
                                                   relation: relation,
                                                   constant: size)
        
        constraint.priority = priority
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    public func height(equalTo dimension: NSLayoutDimension,
                       priority: UILayoutPriority = .required,
                       multiplier: Float = 1,
                       _ size: Float = 0) -> NSLayoutConstraint {

        return anchor(\.heightAnchor, to: dimension, priority: priority, multiplier: multiplier, size)
    }
    
    @discardableResult
    public func widht(relatedTo view: UIView,
                       relation: NSLayoutConstraintType = .equal,
                       multiplier: CGFloat = 1,
                       _ size: Float = 0) -> NSLayoutConstraint {

        let constraint = NSLayoutConstraint.width(firstView: self.view,
                                                  secondView: view,
                                                  relation: relation,
                                                  constant: size,
                                                  multiplier: multiplier)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    public func widht(relation: NSLayoutConstraintType = .equal,
                      _ size: Float) -> NSLayoutConstraint {

        let constraint = NSLayoutConstraint.width(view: self.view,
                                                  relation: relation,
                                                  constant: size)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    public func width(equalTo dimension: NSLayoutDimension,
                       priority: UILayoutPriority = .required,
                       multiplier: Float = 1,
                       _ size: Float = 0) -> NSLayoutConstraint {

        return anchor(\.widthAnchor, to: dimension, priority: priority, multiplier: multiplier, size)
    }
    
    @discardableResult
    public func topSafeArea(alignedWith: UIView,
                            relation: NSLayoutConstraintType = .equal,
                            offset: CGFloat = 0,
                            priority: UILayoutPriority = .required) -> NSLayoutConstraint {

        let constraint = self.view.topAnchor.constraint(equalTo: alignedWith.safeAreaLayoutGuide.topAnchor,
                                                        constant: offset)
        
        constraint.isActive = true
        constraint.priority = priority

        return constraint
    }
    
    public func size(relation: NSLayoutConstraintType = .equal,
                     _ size: Float) {
        widht(relation: relation, size)
        height(relation: relation, size)
    }
    
    @discardableResult
    public func verticalCenter(view: UIView,
                               relation: NSLayoutConstraintType = .equal,
                               attribute: NSLayoutConstraint.Attribute = .centerY,
                               offSet: Float = 0) -> NSLayoutConstraint {

        let constraint = NSLayoutConstraint.centerY(firstView: self.view,
                                                    secondView: view,
                                                    attribute: attribute,
                                                    relation: relation,
                                                    constant: offSet)
        
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    public func horizontalCenter(view: UIView,
                                 relation: NSLayoutConstraintType = .equal,
                                 offSet: Float = 0,
                                 priority: UILayoutPriority = .required) -> NSLayoutConstraint {

        let constraint = NSLayoutConstraint.centerX(firstView: self.view,
                                                    secondView: view,
                                                    relation: relation,
                                                    constant: offSet)
        
        constraint.priority = priority
        constraint.isActive = true
        return constraint
    }
    
    public func center(in view: UIView,
                       relation: NSLayoutConstraintType = .equal,
                       offSet: Float = 0) {

        horizontalCenter(view: view, relation: relation, offSet: offSet)
        verticalCenter(view: view, relation: relation, offSet: offSet)
    }

    @discardableResult
    private func anchor(_ dimensionKeyPath: KeyPath<UIView, NSLayoutDimension>,
                        to dimension: NSLayoutDimension,
                        priority: UILayoutPriority = .required,
                        multiplier: Float = 1,
                        _ size: Float = 0) -> NSLayoutConstraint {

        let anchor = view[keyPath: dimensionKeyPath]
        let constraint = anchor.constraint(equalTo: dimension, multiplier: CGFloat(multiplier), constant: CGFloat(size))
        
        constraint.priority = priority
        constraint.isActive = true
        return constraint
    }
}

extension UIView {
    var dsl: AutoLayout {
        return AutoLayout(view: self)
    }
}

