//
//  File name : DefaultTableViewController.swift
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
//  Created by Blueshift on 2021/09/07
//

import UIKit

class DefaultTableViewController: DefaultViewController {
    
    var tableView: UITableView!
    var refreshControl: UIRefreshControl!
    var lblNothing: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func initializeUI() {
        setTableView()
        self.scrollView = tableView
        
        super.initializeUI()
        setRefresh()
        setNothingLabel()
    }
    
    internal func setTableView() {
        
        tableView = UITableView()
        tableView.backgroundColor = .white
        self.view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
//        tableView.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 1))
    }
    
    internal func setRefresh() {
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    @objc internal func refreshData(_ refresh: UIRefreshControl) {
        refresh.endRefreshing()
    }
    
    internal func setNothingLabel() {
        lblNothing = UILabel()
        lblNothing.isHidden = true
        lblNothing.text = "아직 등록된 내용이 없습니다."
        lblNothing.font = UIFont.systemFont(ofSize: 14)
        lblNothing.textColor = .lightGray
        lblNothing.textAlignment = .center
        
        tableView.addSubview(lblNothing)
        
        lblNothing.translatesAutoresizingMaskIntoConstraints = false
        lblNothing.centerXAnchor.constraint(equalTo: tableView.centerXAnchor).isActive = true
        lblNothing.centerYAnchor.constraint(equalTo: tableView.centerYAnchor).isActive = true
    }
}
