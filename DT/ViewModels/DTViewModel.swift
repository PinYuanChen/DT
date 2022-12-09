
import Foundation
import RxSwift
import RxCocoa

protocol DTViewModelPrototype {
    var output: DTViewModelOutput { get }
    var input: DTViewModelInput { get }
}

protocol DTViewModelOutput {
    var lastGameResult: Observable<GameResultModel> { get }
    var gameResult: Observable<GameResultModel> { get }
    var showCurrentTime: Observable<Void> { get }
    var showWinPlay: Observable<String> { get }
}

protocol DTViewModelInput {
    func getLastGameResult()
    func getGameResult()
    func getWinPlay()
    func getCurrentTime()
    func getSelectedChipIndex(_ index: Int)
}

class DTViewModel: DTViewModelPrototype {

    var output: DTViewModelOutput { self }
    var input: DTViewModelInput { self }

    private let _lastGameResult = PublishRelay<GameResultModel>()
    private let _gameResult = BehaviorRelay<GameResultModel?>(value: nil)
    private let _showCurrentTime = PublishRelay<Void>()
    private var winner = ""
    private let _showWinPlay = PublishRelay<String>()
    private let _selectedChipIndex = BehaviorRelay<Int>(value: 0)
    private let disposeBag = DisposeBag()
}

extension DTViewModel: DTViewModelOutput {
    
    var lastGameResult: Observable<GameResultModel> {
        _lastGameResult.asObservable()
    }
    
    var gameResult: Observable<GameResultModel> {
        _gameResult.compactMap { $0 }.asObservable()
    }
    
    var showCurrentTime: Observable<Void> {
        _showCurrentTime.asObservable()
    }

    var showWinPlay: Observable<String> {
        _showWinPlay.asObservable()
    }
}

extension DTViewModel: DTViewModelInput {
    func getLastGameResult() {
        let dragon = SuitModel(suit: .club, number: 10)
        let tiger = SuitModel(suit: .diamond, number: 9)
        let result = GameResultModel(dragon: dragon, tiger: tiger)
        _lastGameResult.accept(result)
        _gameResult.accept(result)
    }
    
    func getGameResult() {
        let dragon = getSuitResult()
        let tiger = getSuitResult()
        
        if dragon.number > tiger.number {
            winner = "dragon"
        } else if dragon.number < tiger.number {
            winner = "tiger"
        } else {
            winner = "tie"
        }
        
        _gameResult.accept(.init(dragon: dragon,
                                 tiger: tiger))
    }
    
    func getCurrentTime() {
        _showCurrentTime.accept(())
    }
    
    func getWinPlay() {
        _showWinPlay.accept(winner)
    }
    
    func getSelectedChipIndex(_ index: Int) {
        _selectedChipIndex.accept(index)
    }
}

private extension DTViewModel {
    func getSuitResult() -> SuitModel {
        let suit = Suit(rawValue: .random(in: 0...3)) ?? .club
        let num = Int.random(in: 1...13)
        return .init(suit: suit, number: num)
    }
}
