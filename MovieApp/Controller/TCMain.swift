//
//  TCMain.swift
//  MovieApp
//
//  Created by 강한결 on 6/24/24.
//

import UIKit

class TCMain: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let home = UINavigationController(rootViewController: VCMain())
        home.tabBarItem = UITabBarItem(title: Texts.Buttons.TABBAR_HOME.rawValue, image: UIImage(systemName: Icons.TAB_HOUSE.rawValue), tag: 0)
        
        let user = UINavigationController(rootViewController: VCUser())
        user.tabBarItem = UITabBarItem(title: Texts.Buttons.TABBAR_USER.rawValue, image: UIImage(systemName: Icons.TAB_USER.rawValue), tag: 1)
        
        setViewControllers([home, user], animated: true)
        
        tabBar.tintColor = ._grayDark
        tabBar.unselectedItemTintColor = ._gray
    }
}
