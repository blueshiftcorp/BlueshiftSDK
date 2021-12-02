//
//  File name : ThirdTableViewController.swift
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
//  Created by Blueshift on 2021/11/24
//

import UIKit
import BlueshiftSDK

class ThirdTableViewController: BSTableViewController {
    
    enum CellConfig: BSTableViewCellConfiguration {
        case first
        case second
        case none
        
        var identifier: String {
            switch self {
            case .first:    return "ThirdFirstCell"
            case .second:   return "ThirdSecondCell"
            case .none:     return "ThirdCommonCell"
            }
        }
        
        var content: String {
            switch self {
            case .first:    return "첫번째 Cell에 대한 컨텐츠 입니다."
            case .second:   return "두번째 Cell에 대한 컨텐츠 입니다."
            case .none:     return "세번째 Cell에 대한 컨텐츠 입니다."
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.showToast(message: "토스트 테스트 중입니다.\n토스트 메세지 입력\n세번째 줄도 입력해주세요.",
                       animationType: .fromBottom)
        
    }
    
    override func initializeUI() {
        super.initializeUI()
        
        navigationItem.title = "BSTableView"
//        title = "BSTableView"
    }
    
    override func setTableView() {
        super.setTableView()
        
        tableView.dataSource = self
    }
    
    private func setData() {
        CellConfig.allCases.forEach { cell in
            cellItems.append(cell.content)
        }
        
        tableView.reloadData()
    }
}

extension ThirdTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        guard let item = cellItems[indexPath.row] as? String else { return cell }
        
        cell.textLabel?.text = item
        
        return cell
    }
}
