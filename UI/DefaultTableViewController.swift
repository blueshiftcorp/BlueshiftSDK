//
// File name : DefaultTableViewController.swift
// Project name: Blueshift Common Framework
// XCode Project name : BSCommon

// Copyright (c) 2021 iChrogene, Inc. All right reserved.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
// FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
// COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
// IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
// CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

// Created by James, Blueshift Corporation on 2020/06/22
// Website : www.blueshift.co.kr
// Email : admin@blueshift.co.kr
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
