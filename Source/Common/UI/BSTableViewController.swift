//
//  File name : BSTableViewController.swift
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

//public protocol BSTableViewCofiguration: UITableViewDelegate, UITableViewDataSource {
//    var cellItems: [Any] { get }
//}

open class BSTableViewController: BSViewController, UITableViewDataSource {
    
    public var tableView: UITableView!
    public var refreshControl: UIRefreshControl!
    
    /// 데이터 없음 표시
    ///
    /// 데이터가 없을 경우 (테이블 뷰에 보일 데이터 없는 경우)
    /// "아직 등록된 내용이 없습니다" 표시
    /// item count > 0 : hidden(default)
    public var emptyLabel: UILabel!
    
    /// refresh 여부 확인
    ///
    /// refresh인 경우 데이터 초기화
    public var isRefreshing = false
    
    /// 추가로 호출된 데이터가 마지막 데이터 인지 여부
    ///
    /// isEnd = true인 경우 데이터 추가 호출 안됨
    public var isLastRow = false
    
    /// 데이터 요청 시 아이템 시작 번호
    ///
    /// 다음 데이터 호출 시 마지막 다음 번호부터 호출
    /// ex) startNo = 0, requestCnt = 15 이면 다음 호출은 startNo += requestCnt
    public var startRowId = 0
    
    /// 요청 시 전달될 데이터의 개수
    public var requestRowCnt = 15
    
    /// 테이블뷰 셀 모델 행렬
    ///
    /// 테이블뷰 각 셀에 대한 데이터 모델행렬
    public var cellItems = [Any]()
    
    open override func initializeUI() {
        super.initializeUI()
        
        scrollView = tableView
        setTableView()
        setRefresh()
        setEmptyLabel()
    }
    
    open func setTableView() {
        
        tableView = UITableView()
        tableView.backgroundColor = .white
        self.view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 30))
    }
    
    private func setRefresh() {
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    /// TableView 새로고침
    ///
    /// 데이터 시작번호 초기화
    /// 마지막 데이터가 true인 경우가 있으므로 false 초기화
    /// 새로고침 여부 true -> 데이터 로드 완료 후 false
    ///
    @objc open func refreshData(_ refresh: UIRefreshControl) {
        refresh.endRefreshing()
        startRowId = 0
        isLastRow = false
        isRefreshing = true
    }
    
    /// 내용없음 메세지 설정
    ///
    /// TableView Data 없을 경우 표시하는 Label
    ///
    /// - parameters :
    ///     - msg(String) : 표시될 메세지 (default: "아직 등록된 내용이 없습니다."
    ///
    open func setEmptyLabel(_ msg: String? = nil) {
        emptyLabel = UILabel()
        emptyLabel.isHidden = true
        emptyLabel.text = msg ?? "아직 등록된 내용이 없습니다."
        emptyLabel.font = UIFont.systemFont(ofSize: 14)
        emptyLabel.textColor = .lightGray
        emptyLabel.textAlignment = .center
        
        tableView.addSubview(emptyLabel)
        emptyLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            emptyLabel.centerXAnchor.constraint(equalTo: tableView.centerXAnchor),
            emptyLabel.centerYAnchor.constraint(equalTo: tableView.centerYAnchor, constant: -100)
        ])
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellItems.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellItem = cellItems[indexPath.row]
        return cellFortableView(indexPath: indexPath, cellItem: cellItem)
    }

    open func cellFortableView(indexPath: IndexPath, cellItem: Any) -> UITableViewCell {
        return UITableViewCell()
    }
}
