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
    
    private let closeButton = UIButton()
    private let saveButton = UIButton()
    
    private var image: UIImage?
    
    private var session: AVCaptureSession?
    private let photoOutput = AVCapturePhotoOutput()
    private let previewLayer = AVCaptureVideoPreviewLayer()
    private let shutterButton = UIButton()
    private var output: CameraViewOutput?
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    convenience init(image: UIImage? = nil, output: CameraViewOutput?) {
        self.init(frame: .zero)
        self.output = output
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
        closeButton.pin
            .top(Constants.Button.padding + pin.safeArea.top)
            .left(Constants.Button.padding)
            .width(Constants.Button.width)
            .height(Constants.Button.height)
        
        saveButton.pin
            .top(Constants.Button.padding + pin.safeArea.top)
            .right(Constants.Button.padding)
            .width(Constants.Button.width)
            .height(Constants.Button.height)
        
        previewLayer.pin
            .below(of: [closeButton.layer, saveButton.layer])
            .marginTop(Constants.Button.padding)
            .bottom()
            .horizontally()
        
        shutterButton.pin
            .hCenter()
            .width(Constants.ShutterButton.width)
            .height(Constants.ShutterButton.height)
            .bottom(pin.safeArea)
    }
    
    // MARK: - Setup
    
    func setup() {
        setupCloseButton()
        setupSaveButton()
        configureButtons()
        setupView()
        setupPreviewLayer()
        checkCameraPermissions()
        
        layer.addSublayer(previewLayer)
        addSubviews(closeButton, saveButton, shutterButton)
    }
    
    func configureButtons() {
        let cameraModel = CameraModel()
        let viewModel = SheetViewModel(sheetType: .camera(model: cameraModel))
        closeButton.setImage(viewModel.closeImage, for: .normal)
        saveButton.setImage(viewModel.saveImage, for: .normal)
    }
    
    func setupCloseButton() {
        closeButton.tintColor = Constants.Button.backgroundColor
        closeButton.addTarget(self, action: #selector(didTapCloseButton), for: .touchUpInside)
    }
    
    func setupSaveButton() {
        saveButton.tintColor = Constants.Button.backgroundColor
        saveButton.addTarget(self, action: #selector(didTapSaveButton), for: .touchUpInside)
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
    
    @objc
    func didTapCloseButton() {
        output?.didTapCameraCloseButton()
    }
    
    @objc
    func didTapSaveButton() {
        output?.didTapSaveButton(with: image)
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
        
        self.image = image
        
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        imageView.frame = bounds
        
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
        
        struct Button {
            static let backgroundColor: UIColor = .UI.accent
            static let padding: CGFloat = 8
            static let width: CGFloat = 40
            static let height: CGFloat = 40
        }
        
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
