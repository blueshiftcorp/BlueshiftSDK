//
//  File name : SampleTableViewController.swift
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
import BlueshiftSDK

class SampleTableViewController: BSTableViewController {

    enum Cells: BSTableViewCell {
        case cell1
        case cell2
        
        var identifier: String {
            switch self {
            case .cell1: return "CellIdentifier1"
            case .cell2: return "CellIdentifier2"
            }
        }
        
        var title: String {
            switch self {
            case .cell1: return "title1"
            case .cell2: return "title2"
            }
        }

    }
    
    override func setTableView() {
        super.setTableView()
        
        Cells.allCases.forEach { cell in
            tableView.register(UINib(nibName: cell.identifier, bundle: nil), forCellReuseIdentifier: cell.identifier)
        }
    }
    
    private func setData() {
        cellItems.append("test")
        cellItems.append(1234)
    }

    override func cellFortableView(indexPath: IndexPath, cellItem: Any) -> UITableViewCell {
        
        var cell = UITableViewCell()
        
        switch cellItem {
        case is String:
            let c = tableView.dequeueReusableCell(withIdentifier: Cells.cell1.identifier) as! CellIdentifier1
            c.lbl1.text = cellItem as? String
            cell = c
        case is Int:
            break
        default: break
        }
        
        return cell
    }
}

class CellIdentifier1: UITableViewCell {
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var iv1: UIImageView!
}

class CellIdentifier2: UITableViewCell {
    @IBOutlet weak var lbl2: UILabel!
    @IBOutlet weak var iv2: UIImageView!
}
