//
//  VBase.swift
//  MovieApp
//
//  Created by 강한결 on 6/24/24.
//

import UIKit
import SnapKit

class BaseView: UIView {
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureSubView()
        configureLayout()
        configureUI()
    }

    func configureSubView() {}
    func configureLayout() {}
    func configureUI() {}
}
