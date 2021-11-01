//
//  DetailViewController.swift
//  BeerBox
//
//  Created by Alberto Longo on 15/10/21.
//

import UIKit
import Kingfisher


class DetailViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var contentViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var contentViewHeight: NSLayoutConstraint!
    @IBOutlet weak var beerImageView: UIImageView!
    @IBOutlet weak var beerNameLabel: UILabel!
    @IBOutlet weak var beerTypeLabel: UILabel!
    @IBOutlet weak var beerDescriptionLabel: UILabel!
    
    private var originBeforeAnimation: CGRect = .zero

    var beer: Beer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        contentView.alpha = 1
        
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(panGesture(_:)))
        contentView.addGestureRecognizer(gesture)
        gesture.delegate = self
        
        view.layoutIfNeeded()
        
        if let beer = beer {
            if let imageUrl = beer.imageUrl {
                beerImageView.kf.setImage(with: URL(string: imageUrl))
            }
            beerNameLabel.text = beer.name
            beerTypeLabel.text = beer.tagline
            beerDescriptionLabel.text = beer.description
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        contentViewBottomConstraint.constant = 0
        
        UIView.animate(withDuration: 0.6) {
            self.view.layoutIfNeeded()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        contentView.roundCorners([.topLeft, .topRight], radius: 15)
        originBeforeAnimation = contentView.frame
    }
    
    @IBAction private func topViewTap(_ sender: Any) {
        dismissViewController()
    }
    
    func dismissViewController() {
        UIView.animate(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded()
        }, completion: { _ in
            self.dismiss(animated: false, completion: nil)
        })
    }
    
    private func shouldDismissWithGesture(_ recognizer: UIPanGestureRecognizer) -> Bool {
        return recognizer.state == .ended
    }
        
    @objc private func panGesture(_ recognizer: UIPanGestureRecognizer) {
        let point = recognizer.location(in: view)
        
        if shouldDismissWithGesture(recognizer) {
            dismissViewController()
        }
        else {
            if point.y <= originBeforeAnimation.origin.y {
                recognizer.isEnabled = false
                recognizer.isEnabled = true
                return
            }
            contentView.frame = CGRect(x: 0, y: point.y, width: view.frame.width, height: view.frame.height)
        }
    }
    
}

extension DetailViewController: UIGestureRecognizerDelegate {
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }
    
}
