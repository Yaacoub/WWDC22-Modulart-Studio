import AVFoundation

class AudioManager {
    
    
    
    //MARK: - Properties
    
    static var currentMusic: Music?
    
    
    
    //MARK: - Init
    
    private init() {}
    
    
    
    //MARK: - Structs
    
    struct Music: Equatable {
        
        private var player: AVAudioPlayer?
        
        static let main = Music(fileName: "Seth_Makes_Sounds - chill.wav", ofType: "m4a")
        
        fileprivate init(fileName: String, ofType type: String) {
            guard let filePath = Bundle.main.path(forResource: fileName, ofType: type) else { return }
            self.player = try? AVAudioPlayer(contentsOf: URL(fileURLWithPath: filePath))
        }
        
        fileprivate func pause() {
            guard let isPlaying = player?.isPlaying, isPlaying else { return }
            player?.pause()
        }
        
        fileprivate func resume() {
            guard let isPlaying = player?.isPlaying, !isPlaying else { return }
            player?.play()
        }
        
        fileprivate func setVolume(_ volume: Float, fadeDuration: TimeInterval = 0) {
            player?.setVolume(volume, fadeDuration: fadeDuration)
        }
        
        fileprivate func start() {
            currentMusic?.stop()
            currentMusic = self
            player?.numberOfLoops = -1
            player?.volume = 0
            player?.play()
            player?.setVolume(0.5, fadeDuration: 4)
        }
        
        fileprivate func stop() {
            if currentMusic == self { currentMusic = nil }
            player?.setVolume(0, fadeDuration: 4)
            player?.stop()
        }
        
    }
    
    
    
    //MARK: - Methods
    
    static func pauseMusic(_ music: Music) {
        music.pause()
    }
    
    static func resumeMusic(_ music: Music) {
        music.resume()
    }
    
    static func startMusic(_ music: Music) {
        music.start()
    }
    
    static func stopMusic(_ music: Music) {
        music.stop()
    }
    
}
