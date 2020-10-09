//
//  CustomIconExamples.swift
//  Example
//
//  Created by Harley-xk on 2020/10/9.
//  Copyright © 2020 Harley. All rights reserved.
//

import UIKit
import Chrysan

struct CustomIconExamples: AnyChyrsanExample {
    let name = "Custom Image Icons"
    
    func show(in viewController: UIViewController) {
        let vc = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "CustomIconExamplesViewController")
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
}

class CustomIconExamplesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
        
    @IBAction func iconAction(_ sender: UIButton) {
//        let index = sender.tag
//        let name = imageNames[index]
//        let icon = UIImage(named: "icon-" + name)!
//        let status = Status(id: "custom-" + name, message: "This is icon of " + name)
//        let responder = chrysan.hudResponder
//        responder?.register(.imageIndicator(image: icon), for: status.id)
//
//        chrysan.changeStatus(to: status)
//        chrysan.hide(afterDelay: 1)
    }
    
    func getIcon(at indexPath: IndexPath) -> UIImage? {
        let name = IconSections[indexPath.section].iconNames[indexPath.row]
        if indexPath.section == 0 {
            return UIImage(named: name)
        } else {
            if #available(iOS 13.0, *) {
                return UIImage(systemName: name)
            } else {
                return nil
            }
        }
    }
    
    func showChrysanForCustomIcon(at indexPath: IndexPath) {
        let name = IconSections[indexPath.section].iconNames[indexPath.row]
        let status = Status(id: "custom-" + name, message: "This is icon of " + name)
        guard let icon = UIImage(named: name) else {
            chrysan.changeStatus(to: .failure(message: "icon not exixts"))
            chrysan.hide(afterDelay: 1)
            return
        }
        let responder = chrysan.hudResponder
        responder?.register(.imageIndicator(image: icon), for: status.id)
        chrysan.changeStatus(to: status)
        chrysan.hide(afterDelay: 1)
    }
    
    func showChrysanForSFSymbol(at indexPath: IndexPath) {
        let name = IconSections[indexPath.section].iconNames[indexPath.row]
        let status = Status(id: "SF-Symbol-" + name, message: name)
        let responder = chrysan.hudResponder
        if #available(iOS 13.0, *) {
            responder?.register(.imageIndicator(systemName: name), for: status.id)
            chrysan.changeStatus(to: status)
            chrysan.hide(afterDelay: 1)
        } else {
            // Fallback on earlier versions
        }
    }
}

extension CustomIconExamplesViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return IconSections.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return IconSections[section].name
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        IconSections[section].iconNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "icon-cell", for: indexPath)
        let name = IconSections[indexPath.section].iconNames[indexPath.row]
        cell.imageView?.image = getIcon(at: indexPath)
        cell.textLabel?.text = name
        return cell
    }
}

extension CustomIconExamplesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0 {
            showChrysanForCustomIcon(at: indexPath)
        } else {
            showChrysanForSFSymbol(at: indexPath)
        }
    }
}

