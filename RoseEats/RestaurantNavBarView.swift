//
//  RestaurantNavBarView.swift
//  RoseEats
//
//  Created by CSSE Department on 5/17/20.
//  Copyright © 2020 CSSE Department. All rights reserved.
//

import UIKit

class NavBarButton: RoundButton {
     required init(titleString : String) {
            super.init(frame: .zero)
            setTitle(titleString, for: .normal)
        }
    
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
}

class RestaurantNavBarView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setButtonArray()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setButtonArray()
    }
    
    func makeButton(title: String) -> RoundButton {
        let button = RoundButton()
        button.setTitle(title, for: .normal)
        
        return button
    }
    
    func setButtonArray() {
        var buttonArr = [RoundButton]()
        for title in arrPageTitle {
            print("\(title)")
            buttonArr.append(makeButton(title: title))
        }
        
        let stackView = UIStackView(arrangedSubviews: buttonArr)
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.spacing = 8
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(stackView)
    }
}
