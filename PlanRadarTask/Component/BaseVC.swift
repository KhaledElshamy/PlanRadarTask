//
//  BaseVC.swift
//  PlanRadarTask
//
//  Created by Khaled Elshamy on 10/03/2023.
//

import UIKit
import SVProgressHUD

protocol loadingDelegate {
    func showLoading()
    func hideLoading()
}

class BaseVC <T : UIView > : UIViewController  {
  
    var refreshController : UIRefreshControl?
    
    override func loadView() {
        let t  = T()
        t.backgroundColor = .white
        self.view = t
    }
    
    var mainView : T {
        if let view = self.view as? T {
            return view
        }else {
         let view = T()
         self.view = view
         return view
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

extension BaseVC: loadingDelegate {
    func showLoading() {
        SVProgressHUD.show()
    }
    
    func hideLoading() {
        SVProgressHUD.dismiss()
    }
}
