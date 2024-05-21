//
//  ScheduleViewController.swift
//  Everyday
//
//  Created by Михаил on 20.05.2024.
//

import UIKit
import PinLayout
import FirebaseAuth
import FirebaseFirestoreInternal

protocol ScheduleViewControllerDelegate: AnyObject {
    func scheduleDismiss()
}

final class TrainingDaysViewController: UIViewController {

    // MARK: - Private properties
    weak var delegate: ScheduleViewControllerDelegate?
    private var selectedDays = Set<String>()
    private var initialSelectedDays = Set<String>()
    
    private let titleLabel = UILabel()
    private let downloadButton = UIButton()
    private var dayButtons = [UIButton]()
    private var didChangeSchedule: Bool = false
    private let deleteButton = UIButton()
    
    private let model: Train
    private var isDownloaded: Bool
    private let user: String
    
    private let dayMapping: [String: String] = [
        "TrainViewController_mo".localized: "monday",
        "TrainViewController_tu".localized: "tuesday",
        "TrainViewController_we".localized: "wednesday",
        "TrainViewController_th".localized: "thursday",
        "TrainViewController_fr".localized: "friday",
        "TrainViewController_sa".localized: "saturday",
        "TrainViewController_su".localized: "sunday"
    ]
    
    private let dayOrder: [String] = ["TrainViewController_mo".localized,
                                      "TrainViewController_tu".localized,
                                      "TrainViewController_we".localized,
                                      "TrainViewController_th".localized,
                                      "TrainViewController_fr".localized,
                                      "TrainViewController_sa".localized,
                                      "TrainViewController_su".localized
    ]
    
    // MARK: - Lifecycle
    
    init(model: Train, isDownloaded: Bool, user: String) {
        self.model = model
        self.isDownloaded = isDownloaded
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.backgroundColor
        
        setup()
        
        view.addSubview(titleLabel)
        for button in dayButtons {
            view.addSubview(button)
        }
        view.addSubview(downloadButton)
        view.addSubview(deleteButton)
        
        updateDownloadButtonState()
        loadCurrentSchedule()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutSubviews()
    }
    
    // MARK: - Setup

    private func setup() {
        setupTitleLabel()
        setupDaysButtons()
        setupDownloadButton()
        setupDeleteButton()
    }
    
    private func setupDeleteButton() {
        deleteButton.backgroundColor = .red
        deleteButton.setTitleColor(.white, for: .normal)
        deleteButton.layer.cornerRadius = 10
        deleteButton.setTitle("DeleteAccount_Delete_title".localized, for: .normal)
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        deleteButton.isHidden = true
    }

    private func setupTitleLabel() {
        let viewModel = ScheduleViewModel()
        
        titleLabel.attributedText = viewModel.title
        titleLabel.textAlignment = .center
    }

    private func setupDaysButtons() {
        for day in 0...6 {
            let dayButton = UIButton(type: .system)
            let viewModel = ScheduleViewModel()
            
            dayButton.setAttributedTitle(viewModel.schedule[day], for: .normal)
            dayButton.backgroundColor = Constants.accentColor.withAlphaComponent(0.1)
            dayButton.layer.cornerRadius = 10
            dayButton.addTarget(self, action: #selector(dayButtonTapped(_:)), for: .touchUpInside)
            dayButtons.append(dayButton)
        }
    }

    private func setupDownloadButton() {
        downloadButton.backgroundColor = Constants.accentColor
        downloadButton.setTitleColor(.white, for: .normal)
        downloadButton.layer.cornerRadius = 10
        downloadButton.addTarget(self, action: #selector(downloadButtonTapped), for: .touchUpInside)
        updateDownloadButtonTitle()
    }

    // MARK: - Layout

    private func layoutSubviews() {
        titleLabel.pin
            .top(view.pin.safeArea.top + Constants.Label.marginTop)
            .hCenter()
            .width(Constants.Label.width)
            .sizeToFit()
        
        for (index, button) in dayButtons.enumerated() {
            let row = index / 3
            let col = index % 3
            let xOffset = (view.frame.width - (3 * Constants.ScheduleButton.buttonWidth) -
                           (2 * Constants.ScheduleButton.buttonSpacing)) / 2 + CGFloat(col) *
            (Constants.ScheduleButton.buttonWidth + Constants.ScheduleButton.buttonSpacing)
            let yOffset = titleLabel.frame.maxY + 20 + CGFloat(row) * (Constants.ScheduleButton.buttonHeight + Constants.ScheduleButton.buttonSpacing)
            
            button.pin
                .top(yOffset)
                .left(xOffset)
                .width(Constants.ScheduleButton.buttonWidth)
                .height(Constants.ScheduleButton.buttonHeight)
        }

        downloadButton.pin
            .bottom(view.pin.safeArea.bottom + 60)
            .hCenter()
            .width(Constants.Button.width)
            .height(Constants.Button.height)
        
        deleteButton.pin
            .below(of: downloadButton).marginTop(10)
            .hCenter()
            .width(Constants.Button.width)
            .height(Constants.Button.height)
    }
    
    private func updateDownloadButtonState() {
        downloadButton.isEnabled = !selectedDays.isEmpty
        downloadButton.backgroundColor = selectedDays.isEmpty ? .gray : Constants.accentColor
        deleteButton.isHidden = !isDownloaded
    }
    
    private func updateDownloadButtonTitle() {
        let title = isDownloaded ? "ChangeEmail_ConfirmButton_title".localized : "TrainingDaysViewController_load".localized
        downloadButton.setTitle(title, for: .normal)
    }
    
    private func sortSelectedDaysByProximityToToday(_ selectedDays: Set<String>) -> [String] {
        let todayIndex = Calendar.current.component(.weekday, from: Date()) - 1
        let orderedDays = dayOrder.enumerated().map { (index, day) -> (day: String, order: Int) in
            let adjustedIndex = (index - todayIndex + 7) % 7
            return (day, adjustedIndex)
        }
        
        let sortedDays = selectedDays.sorted { (day1, day2) -> Bool in
            let order1 = orderedDays.first { $0.day == day1 }?.order ?? 0
            let order2 = orderedDays.first { $0.day == day2 }?.order ?? 0
            return order1 < order2
        }
        
        return sortedDays
    }
    
    private func loadCurrentSchedule() {
        guard let user = Auth.auth().currentUser, isDownloaded else {
            return
        }

        let userRef = Firestore.firestore().collection("user").document(user.uid)
        let workoutRef = Firestore.firestore().collection("workout").document(model.id)

        workoutRef.getDocument { workoutDocument, _ in
            guard let workoutDocument = workoutDocument, workoutDocument.exists, let workoutData = workoutDocument.data(),
                  let programReferences = workoutData["programs"] as? [DocumentReference] else {
                return
            }

            let programIDs = Set(programReferences.map { $0.path })

            userRef.getDocument { userDocument, _ in
                if let userDocument = userDocument, userDocument.exists, let data = userDocument.data() {
                    if let schedule = data["schedule"] as? [String: [[String: Any]]] {
                        for (dayKey, daySchedules) in schedule {
                            for daySchedule in daySchedules {
                                if let programIDRef = daySchedule["programID"] as? DocumentReference,
                                   programIDs.contains(programIDRef.path) {
                                    guard let day = self.dayMapping.first(where: { $0.value == dayKey })?.key else {
                                        continue
                                    }
                                    self.selectedDays.insert(day)
                                    self.initialSelectedDays.insert(day)
                                }
                            }
                        }
                        self.updateDayButtons()
                        self.updateDownloadButtonState()
                    }
                }
            }
        }
    }

    private func updateDayButtons() {
        for button in dayButtons {
            guard let day = button.titleLabel?.text else {
                continue
            }
            if selectedDays.contains(day) {
                button.backgroundColor = Constants.accentColor
            } else {
                button.backgroundColor = Constants.accentColor.withAlphaComponent(0.1)
            }
        }
    }

    // MARK: - Actions
    @objc private func deleteButtonTapped() {
        Fetcher.shared.deleteSchedule(for: model.id, forUser: user) { [weak self] success in
            guard let self = self else {
                return
            }
            if success {
                Fetcher.shared.updateDownloadStatus(with: self.model.id, forUser: self.user, isDownloaded: false) { updateSuccess in
                    if updateSuccess {
                        self.isDownloaded = false
                        self.selectedDays.removeAll()
                        self.initialSelectedDays.removeAll()
                        self.updateDownloadButtonTitle()
                        self.updateDayButtons()
                        self.delegate?.scheduleDismiss()
                        self.dismiss(animated: true, completion: nil)
                    } else {
                        fatalError("Error updating download status")
                    }
                }
            } else {
                fatalError("Error deleting schedule")
            }
        }
    }

    @objc private func dayButtonTapped(_ sender: UIButton) {
        guard let day = sender.titleLabel?.text else {
            return
        }
        
        HapticService.shared.selectionVibrate()
        
        if selectedDays.contains(day) {
            selectedDays.remove(day)
            sender.backgroundColor = Constants.accentColor.withAlphaComponent(0.1)
        } else {
            selectedDays.insert(day)
            sender.backgroundColor = Constants.accentColor
        }
        
        updateDownloadButtonState()
    }

    @objc private func downloadButtonTapped() {
        if selectedDays == initialSelectedDays {
            self.delegate?.scheduleDismiss()
            self.dismiss(animated: true, completion: nil)
            
            return
        }
        
        let sortedDays = sortSelectedDaysByProximityToToday(selectedDays)
        let mappedDays = sortedDays.compactMap { dayMapping[$0] }
        
        if isDownloaded {
            Fetcher.shared.updateSchedule(with: model.id, forUser: user, selectedDays: mappedDays) { [weak self] success in
                guard let self = self else {
                    return
                }
                if success {
                    self.delegate?.scheduleDismiss()
                    self.dismiss(animated: true, completion: nil)
                } else {
                   return
                }
            }
        } else {
            Fetcher.shared.updateDownloadStatus(with: model.id, forUser: user, isDownloaded: true)
            Fetcher.shared.updateSchedule(with: model.id, forUser: user, selectedDays: mappedDays) { [weak self] success in
                guard let self = self else {
                    return
                }
                if success {
                    self.isDownloaded = true
                    self.updateDownloadButtonTitle()
                    self.delegate?.scheduleDismiss()
                    self.dismiss(animated: true, completion: nil)
                } else {
                   return
                }
            }
        }
    }
}

private extension TrainingDaysViewController {
    struct Constants {
        static let backgroundColor: UIColor = UIColor.background
        static let accentColor: UIColor = UIColor.UI.accent
        
        struct Label {
            static let marginTop: CGFloat = 20
            static let width = 80%
        }
        
        struct ScheduleButton {
            static let buttonWidth: CGFloat = 100
            static let buttonHeight: CGFloat = 50
            static let buttonSpacing: CGFloat = 10
        }
        
        struct Button {
            static let height: CGFloat = 50
            static let width = 80%
        }
    }
}
