//
//  PlayerView.swift
//  Navigat1on
//
//  Created by Илья Сидорик on 14.02.2023.
//

import UIKit
import AVFoundation

final class PlayerView: UIView {
    
    // MARK: - Properties
    
    private var thisMusic: Music?
    
    private lazy var player = AVAudioPlayer()
    
//    private lazy var labelImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.backgroundColor = .orange
//        imageView.clipsToBounds = true
//        imageView.contentMode = .scaleAspectFill
//        return imageView
//    }()
    
    private lazy var nameSongLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Тут будет название песни и исполнителя"
        return label
    }()
    
    private lazy var nameArtistLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var progressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.translatesAutoresizingMaskIntoConstraints = false
        return progressView
    }()
    
    private lazy var timerLabel: UILabel = {
        let label = UILabel()
        label.text = "30"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var backSongButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "backward"), for: .normal)
        button.addTarget(self, action: #selector(qwe), for: .touchUpInside)
        return button
    }()
    @objc
    private func qwe() {
        self.backSong()
    }
    
    private lazy var playPauseSongButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "play"), for: .normal)
        button.setImage(UIImage(systemName: "pause"), for: .selected)
        button.addTarget(self, action: #selector(toglePlayPause), for: .touchUpInside)
        return button
    }()
    
    @objc
    private func toglePlayPause() {
        if self.playPauseSongButton.isSelected {
            self.playPauseSongButton.isSelected = false
            self.player.pause()
        } else {
            self.playPauseSongButton.isSelected = true
            self.player.play()
        }
    }
    
    private lazy var nextSongButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "forward"), for: .normal)
        button.addTarget(self, action: #selector(qwerty), for: .touchUpInside)
        return button
    }()
    @objc
    private func qwerty() {
        self.nextSong()
    }
    
    private lazy var stopSongButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "stop"), for: .normal)
        button.addTarget(self, action: #selector(stopSong), for: .touchUpInside)
        return button
    }()
    
    @objc
    private func stopSong() {
        self.player.currentTime = 0
        self.player.stop()
        self.playPauseSongButton.isSelected = false
    }
    
    
    private lazy var superStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 8
//        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
//        stackView.spacing = 50
        stackView.axis = .horizontal
        return stackView
    }()
    
    
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Methods
    
    private func setupView() {
        self.addSubview(superStackView)
        self.setupStackView()
        self.initPlayer()
    }
    
    private func initPlayer() {
        guard !ArrayMusic.shared.arrayMusic.isEmpty else {
            print("Сделать какой то дефолтный экран плеера")
            return
        }
        
        let music = ArrayMusic.shared.arrayMusic[0]
        self.updateMusic(music: music)
            
        
    }
    
    private func setupStackView() {
//        self.superStackView.addArrangedSubview(labelImageView)
        self.superStackView.addArrangedSubview(nameSongLabel)
        self.superStackView.addArrangedSubview(nameArtistLabel)
        self.superStackView.addArrangedSubview(progressView)
        self.superStackView.addArrangedSubview(timerLabel)
        self.superStackView.addArrangedSubview(buttonStackView)
        
        self.buttonStackView.addArrangedSubview(backSongButton)
        self.buttonStackView.addArrangedSubview(playPauseSongButton)
        self.buttonStackView.addArrangedSubview(nextSongButton)
        
        self.superStackView.addArrangedSubview(stopSongButton)
    }
    
    private func nextSong() {
        guard let index = ArrayMusic.shared.arrayMusic.firstIndex(where: {$0.id == thisMusic?.id}) else {
            print("Сделать какой то дефолтный экран плеера")
            return
        }
        
        guard index < ArrayMusic.shared.arrayMusic.count - 1 else {
            print("Это последняя песня")
            return
        }
        let newMusic = ArrayMusic.shared.arrayMusic[index + 1]
        self.updateMusic(music: newMusic)
        self.player.play()
    }
    
    private func backSong() {
        guard let index = ArrayMusic.shared.arrayMusic.firstIndex(where: {$0.id == thisMusic?.id}) else {
            print("Сделать какой то дефолтный экран плеера")
            return
        }
        
        guard index > 0 else {
            print("Это первая песня")
            return
        }
        let newMusic = ArrayMusic.shared.arrayMusic[index - 1]
        self.updateMusic(music: newMusic)
    }
    
    
    private func updateMusic(music: Music?) {
        self.thisMusic = music
        
        guard let music = thisMusic else {
            print("Ошибка апдейта музыки")
            return
        }
        
        player.stop()
//        player.
//        self.labelImageView.image = music.labelPhoto
        self.nameSongLabel.text = music.nameSong
        self.nameArtistLabel.text = music.nameArtist
        do {
            player = try AVAudioPlayer(contentsOf: music.url)
            player.prepareToPlay()
            player.pause()
            self.timerLabel.text = "\(player.duration)"
        }
        catch {
            print(error)
        }
        


    }
    
    // MARK: - SetupConstraints
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            superStackView.topAnchor.constraint(equalTo: self.topAnchor),
            superStackView.leftAnchor.constraint(equalTo: self.leftAnchor),
            superStackView.rightAnchor.constraint(equalTo: self.rightAnchor),
            superStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),

        ])
    }
    
}
