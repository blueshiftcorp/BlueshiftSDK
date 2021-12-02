//
//  File name : BSTabBarController.swift
//
//  Copyright (c) 2009-2021 Blueshift Corporation. All right reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//
//  Created by Blueshift on 2021/11/23
//

import UIKit

/// BSTabBarItem
///
/// 탭바를 구성할 탭바 아이템 구성을 위한 구조체입니다.
/// - Varibales:
///     - viewController : 탭 선택 시 표시할 ViewController
///     - tabBarIcon: 탭에서 사용할 아이콘 이미지
///     - tabBarTitle: 탭 표시할 타이틀
///     - isNavigationController: 탭 선택 시 표시할 ViewController가 NavigationController일 경우 ture(default), ViewController일 경우 false 정의해야함.
///
public struct BSTabBarItem {
    public var viewController: UIViewController
    public var tabBarIcon: UIImage
    public var tabBarTitle: String
    public var isNavigationController: Bool
    
    public init(viewController: UIViewController,
                tabBarIcon: UIImage,
                tabBarTitle: String,
                isNavigationController: Bool? = true) {
        self.viewController = viewController
        self.tabBarIcon = tabBarIcon
        self.tabBarTitle = tabBarTitle
        self.isNavigationController = isNavigationController!
    }
}

/// BSTabBarItemConfguration
///
/// BSTabBarController를 상속하여 사용할 경우, protocol을 통해 TabBar Item을 구성해야합니다.
/// 상속받은 클래스에서 BSTabBarItemConfiguration의 tabBarItems를 implementation하면 해당 아이템들로 탭바가 구성됩니다.
/// 탭바 아이템 구성시 탭바 타이틀, 아이콘, 네비게이션 여부 등을 설정해서 BSTabBarItem Array로 전달합니다.
/// 
public protocol BSTabBarItemConfiguration {
    func tabBarItems() -> [BSTabBarItem]
}

open class BSTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    //MARK: - Lifecycle
    open override func viewDidLoad() {
        super.viewDidLoad()
        initializeUI()
    }
    
    
    //MARK: - Methods
    
    /// 탭바 콘트롤러 UI 초기화
    ///
    /// 탭바 모양, 탭바 메뉴 구성을 초기화합니다.
    open func initializeUI() {
        self.view.backgroundColor = .white
        
        setTabBarAppearance()
        setViewControllers()
    }
    
    private func setViewControllers() {
        
        guard let items = self.tabBarItems() else { return }
        var tabVCs = [UIViewController]()
        for item in items {
            tabVCs.append(createTabViewController(item))
        }
        
        self.viewControllers = tabVCs
    }
    
    open func setTabBarAppearance() {
        UITabBar.setTransparentTabbar()
        let appearance = tabBar.standardAppearance
        appearance.shadowColor = nil
        appearance.shadowImage = nil
        appearance.backgroundEffect = nil
        tabBar.standardAppearance = appearance
    }

    /// 탭바 메뉴 Navigation Controller 생성 함수
    ///
    /// 탭바 메뉴의 루트뷰를 네비게이션으로 구성할 경우 createNavController로 navigationViewController를 생성합니다.
    ///
    /// - Parameter item: BSTabBarItem
    private func createTabViewController(_ item: BSTabBarItem) -> UIViewController{
        
        let vc = item.viewController
        vc.tabBarItem.title = item.tabBarTitle
        vc.tabBarItem.image = item.tabBarIcon
        
        if item.isNavigationController {
            let nvc = UINavigationController(rootViewController: vc)
            nvc.navigationItem.title = item.tabBarTitle
            nvc.tabBarItem.title = item.tabBarTitle
            nvc.tabBarItem.image = item.tabBarIcon
            return nvc
        } else {
            return vc
        }
    }
    
    open func tabBarItems() -> [BSTabBarItem]? { return nil }
}
