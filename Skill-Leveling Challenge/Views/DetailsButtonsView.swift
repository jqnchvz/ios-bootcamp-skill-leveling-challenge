//
//  DetailsButtonsView.swift
//  Skill-Leveling Challenge
//
//  Created by Joaquin Gonzalo Chavez Barbaste on 19-09-22.
//

import UIKit

class DetailsButtonsView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var askButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Preguntar", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(named: "MeliBlue")
        button.layer.cornerRadius = 6
        return button
    }()
    
    private lazy var contactButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let buttonText = NSMutableAttributedString()
        let symbolImage = UIImage(systemName: "paperclip")?.withTintColor(.white)
        let symbolTextAttachment = NSTextAttachment()
        symbolTextAttachment.image = symbolImage
        let attributedText = NSMutableAttributedString()
        attributedText.append(NSAttributedString(attachment: symbolTextAttachment))
        attributedText.append(NSAttributedString(string: " " + "Whatsapp"))
                              
        button.setAttributedTitle(attributedText, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(named: "MeliBlue")
        button.layer.cornerRadius = 6
        return button
    }()
    
    private lazy var favoriteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let buttonText = NSMutableAttributedString()
        let symbolImage = UIImage(systemName: "heart")?.withTintColor(UIColor(named: "MeliBlue") ?? .blue)
        let symbolTextAttachment = NSTextAttachment()
        symbolTextAttachment.image = symbolImage
        let attributedText = NSMutableAttributedString()
        attributedText.append(NSAttributedString(attachment: symbolTextAttachment))
        attributedText.append(NSAttributedString(string: " " + "Agregar a Favoritos"))
        attributedText.addAttribute(.font, value: UIFont.systemFont(ofSize: 14), range: NSRange(location: 0, length: attributedText.length))
        button.setAttributedTitle(attributedText, for: .normal)
        button.setTitleColor(UIColor(named: "MeliBlue"), for: .normal)
        
        return button
    }()

    private lazy var shareButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let buttonText = NSMutableAttributedString()
        let symbolImage = UIImage(systemName: "square.and.arrow.up")?.withTintColor(UIColor(named: "MeliBlue") ?? .blue)
        let symbolTextAttachment = NSTextAttachment()
        symbolTextAttachment.image = symbolImage
        let attributedText = NSMutableAttributedString()
        attributedText.append(NSAttributedString(attachment: symbolTextAttachment))
        attributedText.append(NSAttributedString(string: " " + "Compartir"))
        attributedText.addAttribute(.font, value: UIFont.systemFont(ofSize: 14), range: NSRange(location: 0, length: attributedText.length))
        button.setAttributedTitle(attributedText, for: .normal)
        button.setTitleColor(UIColor(named: "MeliBlue"), for: .normal)
        
        return button
    }()

    
    private func setupViews() {
        self.addSubview(askButton)
        self.addSubview(contactButton)
        self.addSubview(favoriteButton)
        self.addSubview(shareButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            askButton.topAnchor.constraint(equalTo: self.topAnchor),
            askButton.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            askButton.heightAnchor.constraint(equalToConstant: 48),
            
            contactButton.topAnchor.constraint(equalTo: self.topAnchor),
            contactButton.leadingAnchor.constraint(equalTo: askButton.trailingAnchor, constant: 9),
            contactButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            contactButton.heightAnchor.constraint(equalToConstant: 48),
            
            askButton.widthAnchor.constraint(equalTo: contactButton.widthAnchor),
            
            favoriteButton.topAnchor.constraint(equalTo: askButton.bottomAnchor, constant: 34),
            favoriteButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            favoriteButton.heightAnchor.constraint(equalToConstant: 40),
            favoriteButton.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            shareButton.topAnchor.constraint(equalTo: contactButton.bottomAnchor, constant: 34),
            shareButton.leadingAnchor.constraint(equalTo: favoriteButton.trailingAnchor, constant: 23),
            shareButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -50),
            shareButton.heightAnchor.constraint(equalToConstant: 40),
            shareButton.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
    }
}
