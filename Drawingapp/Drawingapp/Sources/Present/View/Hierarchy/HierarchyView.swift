//
//  HierarchyView.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/03/12.
//

import Foundation
import UIKit

protocol HierarchyDelegate {
    func selectedCell(index: IndexPath)
    func move(to: Plane.MoveTo)
    func getCount() -> Int
    func getModel(to: IndexPath) -> DrawingModel?
    func getSelectIndex() -> Int?
}

class HierarchyView: UIView {
    let title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "레이어"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    
    let rightBar: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        return view
    }()

    let layerTableView: UITableView = {
        let tableView = UITableView()
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor(red: 245 / 255.0, green: 1, blue: 250 / 255.0, alpha: 1)
        tableView.backgroundView = backgroundView
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(HieararchyTableViewCell.self, forCellReuseIdentifier: "HieararchyTableViewCell")
        tableView.layer.borderWidth = 1
        tableView.layer.borderColor = UIColor.black.cgColor
        return tableView
    }()
    
    var delegate: HierarchyDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        bind()
        layout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        bind()
        layout()
    }
    
    private func bind() {
        layerTableView.delegate = self
        layerTableView.dataSource = self
    }
    
    private func layout() {
        self.addSubview(rightBar)
        self.addSubview(title)
        self.addSubview(layerTableView)
        
        rightBar.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        rightBar.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        rightBar.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        rightBar.widthAnchor.constraint(equalToConstant: 1).isActive = true
        
        title.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        title.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        title.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        title.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        layerTableView.topAnchor.constraint(equalTo: title.bottomAnchor).isActive = true
        layerTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        layerTableView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: -1).isActive = true
        layerTableView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }
    
    func updateView() {
        self.layerTableView.reloadData()
        if let selectModel = self.delegate?.getSelectIndex() {
            self.layerTableView.selectRow(at: IndexPath(row: selectModel, section: 0), animated: false, scrollPosition: .none)
        }
    }
    
    func selectIndex(_ index: Int) {
        layerTableView.selectRow(at: IndexPath(row: index, section: 0), animated: false, scrollPosition: .none)
    }
    
    func deSelecteIndex(_ index: Int) {
        layerTableView.deselectRow(at: IndexPath(row: index, section: 0), animated: false)
    }
}

extension HierarchyView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
}

extension HierarchyView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = self.delegate?.getCount() else {
            return 0
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HieararchyTableViewCell") as? HieararchyTableViewCell,
              let model = self.delegate?.getModel(to: indexPath) else {
            return UITableViewCell()
        }
        cell.setView(model: model)
        cell.delegate = self
        return cell
    }
}

extension HierarchyView: HieararchyCellDelegate {
    func selectCell(_ cell: HieararchyTableViewCell) {
        guard let indexPath = self.layerTableView.indexPath(for: cell) else {
            return
        }
        self.delegate?.selectedCell(index: indexPath)
    }
    
    func move(to: Plane.MoveTo, cell: HieararchyTableViewCell) {
        guard let indexPath = self.layerTableView.indexPath(for: cell) else {
            return
        }
        self.delegate?.selectedCell(index: indexPath)
        self.delegate?.move(to: to)
    }
}
