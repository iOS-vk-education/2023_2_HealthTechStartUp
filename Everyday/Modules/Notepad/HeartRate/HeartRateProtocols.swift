//
//  HeartRateProtocols.swift
//  AI_Everyday
//
//  Created by Михаил on 11.05.2024.
//
//

import Foundation
import BeamAISDK
import AVFoundation

protocol HeartRateModuleInput {
    var moduleOutput: HeartRateModuleOutput? { get }
}

protocol HeartRateModuleOutput: AnyObject {
}

protocol HeartRateViewInput: AnyObject {
    func configure(with viewModel: HeartRateViewModel)
    func moveUIToStoppedMode()
    func moveUIToMeasuringMode()
    func stopMonitoringAfterError()
    func clearLabelsValue()
    func incrementCounter()
    func updateResults(stress: Double, heartRate: Double, heartRateVariability: Double)
}

protocol HeartRateViewOutput: AnyObject {
    func didLoadView()
    func getSession() -> AVCaptureSession?
    func startSession()
    func stopSession()
    func startMonitoring()
    func setMeasuringMode()
    func getEstimates()
}

protocol HeartRateInteractorInput: AnyObject {
    func checkBeam()
}

protocol HeartRateInteractorOutput: AnyObject {
    func didCheckBeam(with object: Any)
}

protocol HeartRateRouterInput: AnyObject {
}
