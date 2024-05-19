//
//  HeartRatePresenter.swift
//  AI_Everyday
//
//  Created by Михаил on 11.05.2024.
//
//

import Foundation
import BeamAISDK
import AVFoundation

final class HeartRatePresenter {
    weak var view: HeartRateViewInput?
    weak var moduleOutput: HeartRateModuleOutput?
    
    private let router: HeartRateRouterInput
    private let interactor: HeartRateInteractorInput
    
    private var beamAI: BeamAI?
    
    init(router: HeartRateRouterInput, interactor: HeartRateInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension HeartRatePresenter: HeartRateModuleInput {
}

extension HeartRatePresenter: HeartRateViewOutput {
    func getEstimates() {
        guard let output = beamAI?.getEstimates(), let code = output["CODE"] as? String else {
            // view?.showAlert() -- alert manager c последнего merge в main
            print("Failed to get monitoring output")
            return
        }

        switch code {
        case "S1-SDKIsNotMonitoring", "E1-SDKValidationRejected", "E2-CameraSessionNotRunning":
            // view?.showAlert() -- alert manager c последнего merge в main
            view?.stopMonitoringAfterError()
            
            DispatchQueue.main.async {
                self.view?.moveUIToStoppedMode()
            }
            
        case "S2-NoFaceDetected":
            // view?.showAlert -- alert manager c последнего merge в main
            view?.clearLabelsValue()
            view?.stopMonitoringAfterError()
            
        case "S3-NotEnoughFramesProcessed":
            view?.incrementCounter()
            
        case "S4-NotFullWindow", "S5-FullResults":
            if let heartRate = output["HEARTRATE"] as? Double, let hrv = output["HRV"] as? Double, let stress = output["STRESS"] as? Double {
                view?.updateResults(stress: stress, heartRate: heartRate, heartRateVariability: hrv)
            } else {
                // view?.showAlert -- alert manager c последнего merge в main
                print("Error parsing monitoring results")
            }
            
        default:
            // view?.showAlert -- alert manager c последнего merge в main
            print("Unhandled code: \(code)")
        }
    }
    
    func setMeasuringMode() {
        DispatchQueue.main.async {
            self.view?.moveUIToMeasuringMode()
        }
    }
    
    func startMonitoring() {
        do {
            try beamAI?.startMonitoring()
        } catch {
            // view?.showAlert() -- alert manager c последнего merge в main
            print("alert manager")
            return
        }
    }
    
    func stopSession() {
        beamAI?.stopMonitoring()
        
        DispatchQueue.main.async {
            self.view?.moveUIToStoppedMode()
        }
    }
    
    func startSession() {
        DispatchQueue.global(qos: .userInitiated).async {
            self.beamAI?.startSession()
            
            DispatchQueue.main.async {
                self.view?.moveUIToStoppedMode()
            }
        }
    }
    
    func getSession() -> AVCaptureSession? {
        beamAI?.getCameraSession()
    }
    
    func didLoadView() {
        interactor.checkBeam()
        
        let model = HeartRateViewModel()
        view?.configure(with: model)
    }
}

extension HeartRatePresenter: HeartRateInteractorOutput {
    func didCheckBeam(with object: Any) {
        if let error = object as? Error {
            // view?.showAlert -- alert manager c последнего merge в main
            print("\(error)")
        } else if let beam = object as? BeamAI {
            beamAI = beam
        }
    }
}
