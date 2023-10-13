//
//  SpinnerDisplayable.swift
//  RickyAndMorty
//
//  Created by 박현준 on 10/13/23.
//

import UIKit

protocol SpinnerDisplayable: AnyObject {
    func showSpinner()
    func hideSpinner()
}

extension SpinnerDisplayable where Self: UIViewController {
    func showSpinner() {
        guard doseNotExistAnotherSpinner else { return }
        
        configureSpinner()
    }
    
    private func configureSpinner() {
        let containerView = UIView()
        containerView.tag = ViewValues.tagIdentifierSpinner
        containerView.translatesAutoresizingMaskIntoConstraints = false
        parentView.addSubview(containerView)
        containerView.topAnchor.constraint(equalTo: parentView.topAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: parentView.bottomAnchor).isActive = true
        containerView.leftAnchor.constraint(equalTo: parentView.leftAnchor).isActive = true
        containerView.rightAnchor.constraint(equalTo: parentView.rightAnchor).isActive = true
        containerView.backgroundColor = .black.withAlphaComponent(ViewValues.opercityContainerSpinner)
        
        addSpinnerIndicatorToCotainer(containerView: containerView)
    }
    
    private func addSpinnerIndicatorToCotainer(containerView: UIView ) {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(spinner)
        spinner.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        spinner.startAnimating()
    }
    
    func hideSpinner() {
        if let foundView = parentView.viewWithTag(ViewValues.tagIdentifierSpinner) {
            foundView.removeFromSuperview()
        }
    }
    
    private var doseNotExistAnotherSpinner: Bool {
        parentView.viewWithTag(ViewValues.tagIdentifierSpinner) == nil
    }
    
    private var parentView: UIView {
        navigationController?.view ?? view
    }
}
