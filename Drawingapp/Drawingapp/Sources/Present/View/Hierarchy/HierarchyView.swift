//
//  HierarchyView.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/03/12.
//

import Foundation
import UIKit

protocol HierarchyDelegate {
    func selectedCell(model: DrawingModel)
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
    private var drawingModels = [DrawingModel]()
    
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
    
    func append(drawingModel: DrawingModel) {
        drawingModels.append(drawingModel)
        layerTableView.reloadData()
    }
    
    private func cellTouchEvent(model: DrawingModel) {
        delegate?.selectedCell(model: model)
    }
}

extension HierarchyView: UITableViewDelegate {
    //높이를 얼만큼 할꺼야?
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.selectedCell(model: self.drawingModels[indexPath.row])
    }
}

extension HierarchyView: UITableViewDataSource {
    
    //몇개를 만들꺼야?
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        drawingModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HieararchyTableViewCell") as? HieararchyTableViewCell else {
            return UITableViewCell()
        }
        cell.setView(model: self.drawingModels[indexPath.row])
        
        return cell
    }
}

