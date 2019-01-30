//
//  ScanVC.swift
//  ZWallet
//
//  Created by loj on 29.01.19.
//  Copyright © 2019 XMR Systems LLC. All rights reserved.
//

import AVFoundation
import UIKit


class ScanVC: UIViewController {

    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var viewFinderImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!

    public weak var delegate: ScanVCDelegate?
    public weak var localizer: Localizable?

    private var captureSession: AVCaptureSession!
    private var previewLayer: AVCaptureVideoPreviewLayer!

    @IBAction func cancelButtonTouched() {
        self.delegate?.scanVCDelegateCancelled(sender: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setup()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.updateView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.startCapturing()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.stopCapturing()
    }

    private func setup() {
        self.descriptionLabel.layer.cornerRadius = 4
        self.descriptionLabel.layer.masksToBounds = true
        self.view.backgroundColor = .black
    }

    private func updateView() {
        guard let localizer = self.localizer else {
            return
        }

        self.descriptionLabel.text = localizer.localized("scan.description")
    }
}


extension ScanVC {

    private func startCapturing() {
        self.captureSession = AVCaptureSession()

        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput

        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }

        if (self.captureSession.canAddInput(videoInput)) {
            self.captureSession.addInput(videoInput)
        } else {
            self.failed()
            return
        }

        let metadataOutput = AVCaptureMetadataOutput()

        if (self.captureSession.canAddOutput(metadataOutput)) {
            self.captureSession.addOutput(metadataOutput)

            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        } else {
            self.failed()
            return
        }

        self.previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        self.previewLayer.frame = view.layer.bounds
        self.previewLayer.videoGravity = .resizeAspectFill
        self.view.layer.addSublayer(previewLayer)

        // re-add to be on topmost
        self.view.addSubview(self.cancelButton)
        self.view.addSubview(self.viewFinderImageView)
        self.view.addSubview(self.descriptionLabel)

        self.captureSession.startRunning()
    }

    private func failed() {
        defer { self.stopCapturing() }

        guard let localizer = self.localizer else {
            return
        }

        let alert = UIAlertController(title: localizer.localized("scan.error.title"),
                                      message: localizer.localized("scam.error.message"),
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: localizer.localized("global.Ok"), style: .default, handler: { action in
            self.delegate?.scanVCDelegateCancelled(sender: self)
        }))
        self.present(alert, animated: true)
    }

    private func stopCapturing() {
        self.captureSession = nil
    }
}


extension ScanVC: AVCaptureMetadataOutputObjectsDelegate {

    public func metadataOutput(_ output: AVCaptureMetadataOutput,
                               didOutput metadataObjects: [AVMetadataObject],
                               from connection: AVCaptureConnection)
    {
        self.captureSession.stopRunning()

        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }

            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            self.found(code: stringValue)
        }
    }

    func found(code: String) {
        print(code)
        self.delegate?.scanVCDelegateUriDetected(uri: code, sender: self)
    }
}
