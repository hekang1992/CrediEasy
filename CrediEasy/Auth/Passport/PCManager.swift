//
//  PCManager.swift
//  CrediEasy
//
//  Created by 何康 on 2025/9/15.
//

import UIKit
import Photos
import AVFoundation

// MARK: - 权限类型枚举
enum PermissionType {
    case camera
    case photoLibrary
    
    var displayName: String {
        switch self {
        case .camera:
            return "相机"
        case .photoLibrary:
            return "相册"
        }
    }
}

// MARK: - 相册封装类
class PhotoLibraryManager: NSObject {
    
    typealias PhotoSelectionHandler = (UIImage?, [AnyHashable: Any]?) -> Void
    typealias PermissionHandler = (Bool) -> Void
    
    private var selectionHandler: PhotoSelectionHandler?
    private var permissionHandler: PermissionHandler?
    private weak var presentingViewController: UIViewController?
    
    /// 检查相册权限
    /// - Parameter completion: 权限检查完成回调
    func checkPhotoLibraryPermission(completion: @escaping PermissionHandler) {
        let status = PHPhotoLibrary.authorizationStatus()
        
        switch status {
        case .authorized, .limited:
            completion(true)
        case .denied, .restricted:
            completion(false)
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { newStatus in
                DispatchQueue.main.async {
                    completion(newStatus == .authorized || newStatus == .limited)
                }
            }
        @unknown default:
            completion(false)
        }
    }
    
    /// 从相册选择照片
    /// - Parameters:
    ///   - viewController: 呈现选择器的视图控制器
    ///   - allowsEditing: 是否允许编辑
    ///   - completion: 完成回调，返回选择的图片和信息
    func pickPhoto(from viewController: UIViewController,
                   allowsEditing: Bool = false,
                   completion: @escaping PhotoSelectionHandler) {
        
        self.presentingViewController = viewController
        self.selectionHandler = completion
        
        checkPhotoLibraryPermission { [weak self] granted in
            guard let self = self else { return }
            
            if granted {
                DispatchQueue.main.async {
                    self.presentImagePicker(allowsEditing: allowsEditing)
                }
            } else {
                self.showPermissionAlert(for: .photoLibrary)
            }
        }
    }
    
    private func presentImagePicker(allowsEditing: Bool) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = allowsEditing
        imagePicker.delegate = self
        imagePicker.modalPresentationStyle = .fullScreen
        presentingViewController?.present(imagePicker, animated: true)
    }
    
    fileprivate func showPermissionAlert(for permission: PermissionType) {
        let alert = UIAlertController(
            title: "权限被拒绝",
            message: "请前往设置允许访问\(permission.displayName)",
            preferredStyle: .alert
        )
        
        let cancelAction = UIAlertAction(title: "取消", style: .cancel) { _ in
            self.selectionHandler?(nil, nil)
        }
        
        let settingsAction = UIAlertAction(title: "去设置", style: .default) { _ in
            self.openAppSettings()
            self.selectionHandler?(nil, nil)
        }
        
        alert.addAction(cancelAction)
        alert.addAction(settingsAction)
        
        presentingViewController?.present(alert, animated: true)
    }
    
    private func openAppSettings() {
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString),
              UIApplication.shared.canOpenURL(settingsUrl) else {
            return
        }
        
        UIApplication.shared.open(settingsUrl)
    }
}

// MARK: - UIImagePickerControllerDelegate & UINavigationControllerDelegate
extension PhotoLibraryManager: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        let editedImage = info[.editedImage] as? UIImage
        let originalImage = info[.originalImage] as? UIImage
        let selectedImage = editedImage ?? originalImage
        
        selectionHandler?(selectedImage, info)
        selectionHandler = nil
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
        selectionHandler?(nil, nil)
        selectionHandler = nil
    }
}

// MARK: - 相机封装类
class CameraManager: NSObject {
    
    typealias PhotoCaptureHandler = (UIImage?, [AnyHashable: Any]?) -> Void
    typealias PermissionHandler = (Bool) -> Void
    
    private var captureHandler: PhotoCaptureHandler?
    private var permissionHandler: PermissionHandler?
    private weak var presentingViewController: UIViewController?
    
    /// 检查相机权限
    /// - Parameter completion: 权限检查完成回调
    func checkCameraPermission(completion: @escaping PermissionHandler) {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        
        switch status {
        case .authorized:
            completion(true)
        case .denied, .restricted:
            completion(false)
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                DispatchQueue.main.async {
                    completion(granted)
                }
            }
        @unknown default:
            completion(false)
        }
    }
    
    /// 拍照
    /// - Parameters:
    ///   - viewController: 呈现相机控制器的视图控制器
    ///   - allowsEditing: 是否允许编辑
    ///   - completion: 完成回调，返回拍摄的图片和信息
    func takePhoto(from viewController: UIViewController,
                   allowsEditing: Bool = false,
                   completion: @escaping PhotoCaptureHandler) {
        
        self.presentingViewController = viewController
        self.captureHandler = completion
        
        checkCameraPermission { [weak self] granted in
            guard let self = self else { return }
            
            if granted {
                DispatchQueue.main.async {
                    self.presentCamera(allowsEditing: allowsEditing)
                }
            } else {
                self.showPermissionAlert(for: .camera)
            }
        }
    }
    
    private func presentCamera(allowsEditing: Bool) {
        // 检查设备是否支持相机
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            showCameraNotAvailableAlert()
            return
        }
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = allowsEditing
        imagePicker.delegate = self
        imagePicker.modalPresentationStyle = .fullScreen
        imagePicker.cameraCaptureMode = .photo
        
        presentingViewController?.present(imagePicker, animated: true)
    }
    
    private func showCameraNotAvailableAlert() {
        let alert = UIAlertController(
            title: "相机不可用",
            message: "当前设备不支持相机功能",
            preferredStyle: .alert
        )
        
        let okAction = UIAlertAction(title: "确定", style: .default) { _ in
            self.captureHandler?(nil, nil)
        }
        
        alert.addAction(okAction)
        presentingViewController?.present(alert, animated: true)
    }
    
    fileprivate func showPermissionAlert(for permission: PermissionType) {
        let alert = UIAlertController(
            title: "权限被拒绝",
            message: "请前往设置允许访问\(permission.displayName)",
            preferredStyle: .alert
        )
        
        let cancelAction = UIAlertAction(title: "取消", style: .cancel) { _ in
            self.captureHandler?(nil, nil)
        }
        
        let settingsAction = UIAlertAction(title: "去设置", style: .default) { _ in
            self.openAppSettings()
            self.captureHandler?(nil, nil)
        }
        
        alert.addAction(cancelAction)
        alert.addAction(settingsAction)
        
        presentingViewController?.present(alert, animated: true)
    }
    
    private func openAppSettings() {
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString),
              UIApplication.shared.canOpenURL(settingsUrl) else {
            return
        }
        
        UIApplication.shared.open(settingsUrl)
    }
}

// MARK: - UIImagePickerControllerDelegate & UINavigationControllerDelegate
extension CameraManager: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        let editedImage = info[.editedImage] as? UIImage
        let originalImage = info[.originalImage] as? UIImage
        let capturedImage = editedImage ?? originalImage
        
        captureHandler?(capturedImage, info)
        captureHandler = nil
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
        captureHandler?(nil, nil)
        captureHandler = nil
    }
}
