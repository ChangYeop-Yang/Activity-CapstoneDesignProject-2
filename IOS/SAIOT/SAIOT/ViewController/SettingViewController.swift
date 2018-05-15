//
//  SettingViewController.swift
//  SAIOT
//
//  Created by 양창엽 on 2018. 4. 4..
//  Copyright © 2018년 Yang-Chang-Yeop. All rights reserved.
//

import UIKit
import MessageUI
import AudioToolbox

// MARK: - Enum
fileprivate enum TabelRowAt: Int {
    case Email = 100
    case Introduce = 200
    case OpenSource = 300
    case PrivacyPolicy = 400
    case AppAlarm = 500
    case HueReset = 600
    case AppHelp = 700
}

fileprivate enum SwitchAt: Int {
    case AppAlarm = 10
    case HuePower = 20
}

class SettingViewController: UIViewController {
    
    // MARK: - Outlet Variables
    private var settingTable: UITableView?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let settingTableVC = segue.destination as? UITableViewController {
            settingTableVC.tableView.delegate = self
            settingTable = settingTableVC.tableView
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidLoad()
        
        // Change Hue Cell
        if let hueCell: UITableViewCell = settingTable?.cellForRow(at: IndexPath(row: 2, section: 2)) {
            hueCell.detailTextLabel?.text = PhilipsHueBridge.hueInstance.getHueBridgeConfig()
        }
    }
    
    // MARK: Method
    fileprivate func showInformationAlert(title: String, comment: String) {
        let alert: UIAlertController = UIAlertController(title: title, message: comment, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: - TableView Delegate Extension
extension SettingViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let tag: Int = tableView.cellForRow(at: indexPath)?.tag, let cell: TabelRowAt = TabelRowAt(rawValue: tag) {
            
            switch cell {
                case .Introduce:
                    if let url: URL = URL(string: "http://yeop9657.blog.me") {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                case .Email:
                    if MFMailComposeViewController.canSendMail() {
                        let mail: MFMailComposeViewController = MFMailComposeViewController()
                        mail.mailComposeDelegate = self
                        mail.setSubject("Inquiry SAIOT inconvenient comment")
                        mail.setToRecipients(["yeop9657@outlook.com"])
                        mail.setMessageBody("Please, Input inconvenient comment.", isHTML: false)
                        present(mail, animated: true, completion: nil)
                    }
                case .OpenSource:
                    if let url: URL = URL(string: "http://yeop9657.blog.me/221270349222") {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                case .PrivacyPolicy:
                    if let url: URL = URL(string: "http://yeop9657.blog.me/221270338767") {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                case .HueReset:
                    let userDefaults = UserDefaults.standard
                    let keyValue = userDefaults.string(forKey: "HUE_BRIDGE_KEY")
                    userDefaults.removeObject(forKey: "HUE_BRIDGE_KEY")
                
                    showInformationAlert(title: "Delete HUE Bridge", comment: "정상적으로 휴 브릿지 내용을 삭제하였습니다.")
                case .AppAlarm:
                    break
                case .AppHelp:
                    break
            }
        }
    }
}

// MARK: - MFMailComposeViewController Delegate
extension SettingViewController: MFMailComposeViewControllerDelegate {
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result {
            case .sent:
                print("Success E-mail send to developer.")
            case .cancelled:
                print("Cancel E-mail send to developer.")
            case .saved:
                print("Save E-mail content into disk.");
            case .failed:
                print("Fail E-mail send to developer.")
        }
        
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
    }
}
