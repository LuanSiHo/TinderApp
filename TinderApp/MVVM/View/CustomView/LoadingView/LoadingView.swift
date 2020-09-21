//
//  LoadingView.swift
//  TinderApp
//
//  Created by Ho Si Luan on 9/21/20.
//  Copyright © 2020 Ho Si Luan. All rights reserved.
//

import Foundation

class LoadingView: BaseUIView {
    var containerView: UIView?

    override init(frame: CGRect) {
        let containerView = UIView()
        containerView.backgroundColor = ColorName.whiteColor.withAlphaComponent(0.5)
        containerView.frame = frame
        containerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.containerView = containerView
        super.init(frame: frame)
        addSubview(containerView)
        addLoadingIndicator()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addLoadingIndicator() {
        guard let container = containerView else { return }
        let activityIndicator = UIActivityIndicatorView(style: .gray)
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        container.addSubview(activityIndicator)
        activityIndicator.center = container.center
        activityIndicator.startAnimating()
    }
}
