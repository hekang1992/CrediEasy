//
//  ContactsManager.swift
//  CrediEasy
//
//  Created by Jasper Asher on 2025/9/17.
//

import UIKit
import Contacts
import ContactsUI

class ContactsManager: NSObject, CNContactPickerDelegate {
    
    private let contactStore = CNContactStore()
    
    // MARK: - 回调闭包
    private var singleContactCompletion: ((ContactModel?) -> Void)?
    
    // MARK: - 请求权限
    private func requestAccess(completion: @escaping (Bool) -> Void) {
        let status = CNContactStore.authorizationStatus(for: .contacts)
        switch status {
        case .notDetermined:
            contactStore.requestAccess(for: .contacts) { granted, _ in
                DispatchQueue.main.async {
                    completion(granted)
                }
            }
        case .authorized:
            completion(true)
        case .limited:
            completion(true)
        case .denied, .restricted:
            completion(false)
        @unknown default:
            completion(false)
        }
    }
    
    // MARK: - 弹出提示框
    private func showPermissionAlert(from viewController: UIViewController) {
        let alert = UIAlertController(title: "Contacts permission",
                                      message: "Contacts permission is denied. To turn it back on, go to Settings > Privacy > Contacts, locate our app, and enable access.",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Setting", style: .default, handler: { _ in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }))
        viewController.present(alert, animated: true, completion: nil)
    }
    
    func fetchAllContacts(from viewController: UIViewController,
                          completion: @escaping ([ContactModel]) -> Void) {
        requestAccess { granted in
            guard granted else {
                self.showPermissionAlert(from: viewController)
                completion([])
                return
            }
            
            var results: [ContactModel] = []
            let keys = [CNContactGivenNameKey,
                        CNContactFamilyNameKey,
                        CNContactPhoneNumbersKey] as [CNKeyDescriptor]
            
            let request = CNContactFetchRequest(keysToFetch: keys)
            
            do {
                try self.contactStore.enumerateContacts(with: request) { contact, _ in
                    let fullName = "\(contact.givenName) \(contact.familyName)"
                    let phones = contact.phoneNumbers.map { $0.value.stringValue }
                    if !phones.isEmpty {
                        let phoneStr = phones.joined(separator: ",")
                        results.append(ContactModel(banshees: fullName, anthemwise: phoneStr))
                    }
                }
                completion(results)
            } catch {
                print("获取联系人失败: \(error)")
                completion([])
            }
        }
    }
    
    // MARK: - 弹出系统联系人选择器获取单个联系人
    func pickSingleContact(from viewController: UIViewController,
                           completion: @escaping (ContactModel?) -> Void) {
        singleContactCompletion = completion
        requestAccess { granted in
            guard granted else {
                self.showPermissionAlert(from: viewController)
                completion(nil)
                return
            }
            let picker = CNContactPickerViewController()
            picker.delegate = self
            picker.displayedPropertyKeys = [CNContactPhoneNumbersKey]
            viewController.present(picker, animated: true, completion: nil)
        }
    }
    
    // MARK: - CNContactPickerDelegate
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        let fullName = "\(contact.givenName) \(contact.familyName)"
        let phones = contact.phoneNumbers.map { $0.value.stringValue }
        let phoneStr = phones.first ?? ""
        let contactModel = ContactModel(banshees: fullName, anthemwise: phoneStr)
        singleContactCompletion?(contactModel)
    }
    
    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        singleContactCompletion?(nil)
    }
}

struct ContactModel: Codable {
    let banshees: String
    let anthemwise: String
}
