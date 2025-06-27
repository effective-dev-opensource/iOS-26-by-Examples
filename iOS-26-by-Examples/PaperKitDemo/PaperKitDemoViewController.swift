import UIKit
import SwiftUI
import PencilKit
import PaperKit

struct PaperKitViewControllerRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> PaperKitDemoViewController {
        return PaperKitDemoViewController()
    }

    func updateUIViewController(_ uiViewController: PaperKitDemoViewController, context: Context) {
    }
}

class PaperKitDemoViewController: UIViewController {

    private var markupModel: PaperMarkup!
    private var paperMarkupViewController: PaperMarkupViewController!
    private var toolPicker: PKToolPicker!

    override func viewDidLoad() {
        super.viewDidLoad()

        markupModel = PaperMarkup(bounds: view.bounds)

        paperMarkupViewController = PaperMarkupViewController(markup: markupModel, supportedFeatureSet: .latest)
        
        addChild(paperMarkupViewController)
        view.addSubview(paperMarkupViewController.view)
        paperMarkupViewController.view.frame = view.bounds
        paperMarkupViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        paperMarkupViewController.didMove(toParent: self)

        toolPicker = PKToolPicker()
        toolPicker.addObserver(paperMarkupViewController)
        toolPicker.setVisible(true, forFirstResponder: paperMarkupViewController)

        paperMarkupViewController.pencilKitResponderState.activeToolPicker = toolPicker
        paperMarkupViewController.pencilKitResponderState.toolPickerVisibility = .visible

        toolPicker.accessoryItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(plusButtonPressed(_:)))
    }

    @objc private func plusButtonPressed(_ sender: UIBarButtonItem) {
        let markupEditVC = MarkupEditViewController(supportedFeatureSet: .latest)
        markupEditVC.delegate = paperMarkupViewController as! any MarkupEditViewController.Delegate

        markupEditVC.modalPresentationStyle = .popover
        markupEditVC.popoverPresentationController?.barButtonItem = sender
        present(markupEditVC, animated: true)
    }

    override var canBecomeFirstResponder: Bool { true }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        becomeFirstResponder()
    }
}
