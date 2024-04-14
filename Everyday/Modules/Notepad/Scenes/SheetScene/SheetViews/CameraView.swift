//
//  CameraView.swift
//  Everyday
//
//  Created by Alexander on 12.04.2024.
//

import UIKit
import PinLayout
import AVFoundation

class CameraView: UIView {
    
    // MARK: - Private Properties
    
    var output: CameraViewOutput?
    
    private var session: AVCaptureSession?
    private let photoOutput = AVCapturePhotoOutput()
    private let previewLayer = AVCaptureVideoPreviewLayer()
    private let shutterButton = UIButton()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    convenience init(image: UIImage? = nil, output: CameraViewOutput) {
        self.init(frame: .zero)
        self.output = output
        output.didLoadCameraView(with: image)
    }
    
    // MARK: - Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
}

private extension CameraView {
    
    // MARK: - Layout
    
    func layout() {
        previewLayer.pin
            .all()
        
        shutterButton.pin
            .hCenter()
            .width(Constants.ShutterButton.width)
            .height(Constants.ShutterButton.height)
            .bottom(pin.safeArea)
    }
    
    // MARK: - Setup
    
    func setup() {
        setupView()
        setupPreviewLayer()
        checkCameraPermissions()
        
        layer.addSublayer(previewLayer)
        addSubview(shutterButton)
    }
    
    func setupView() {
        backgroundColor = .clear
    }
    
    func setupPreviewLayer() {
        previewLayer.backgroundColor = Constants.PreviewLayer.backgroundColor.cgColor
        previewLayer.cornerRadius = 16
    }
    
    func setupShutterButton() {
        shutterButton.layer.cornerRadius = Constants.ShutterButton.cornerRadius
        shutterButton.layer.borderWidth = Constants.ShutterButton.borderWidth
        shutterButton.layer.borderColor = Constants.ShutterButton.borderColor.cgColor
        shutterButton.addTarget(self, action: #selector(didTapShutterButton), for: .touchUpInside)
    }
    
    func setupCamera() {
        let session = AVCaptureSession()
        if let device = AVCaptureDevice.default(for: .video) {
            do {
                let input = try AVCaptureDeviceInput(device: device)
                if session.canAddInput(input) {
                    session.addInput(input)
                }
                
                if session.canAddOutput(photoOutput) {
                    session.addOutput(photoOutput)
                }
                
                previewLayer.videoGravity = .resizeAspectFill
                previewLayer.session = session
                
                DispatchQueue.global(qos: .background).async { [weak self] in
                    guard let self else {
                        return
                    }
                    
                    session.startRunning()
                    self.session = session
                }
            } catch {
                // handle errors
                print(error)
            }
        }
    }
    
    // MARK: - Helpers
    
    func checkCameraPermissions() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { [weak self] isGranted in
                guard
                    let self,
                    isGranted
                else {
                    return
                }
                
                DispatchQueue.main.async {
                    self.setupCamera()
                }
            }
        case .restricted:
            // tell user its impossible to user camera
            break
        case .denied:
            // tell user to grant access to his camera via settings
            break
        case .authorized:
            setupCamera()
        default:
            break
        }
        
        setupShutterButton()
    }
    
    // MARK: - Actions
    
    @objc
    func didTapShutterButton() {
        guard AVCaptureDevice.authorizationStatus(for: .video) == .authorized else {
            // tell user to grant access to his camera via settings
            return
        }
        
        photoOutput.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
    }
}

// MARK: - AVCapturePhotoCaptureDelegate

extension CameraView: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: (any Error)?) {
        guard let data = photo.fileDataRepresentation() else {
            return
        }
        
        let image = UIImage(data: data)
        session?.stopRunning()
        
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        imageView.frame = self.bounds
        
        addSubview(imageView)
    }
}

// MARK: - ViewInput

protocol CameraViewInput: AnyObject {
}

extension CameraView: CameraViewInput {
}

// MARK: - Constants

private extension CameraView {
    struct Constants {
        static let backgroundColor: UIColor = .background
        
        struct ShutterButton {
            static let width: CGFloat = 100
            static let height: CGFloat = 100
            static let cornerRadius: CGFloat = 50
            static let borderWidth: CGFloat = 10
            static let borderColor: UIColor = .background
        }
        
        struct PreviewLayer {
            static let backgroundColor: UIColor = .UI.accent
        }
    }
}
