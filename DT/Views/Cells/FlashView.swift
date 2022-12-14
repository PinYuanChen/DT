
import UIKit
import SnapKit
import RxSwift
import RxCocoa

class FlashView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let disposeBag = DisposeBag()
}

// MARK: - Setup UI
private extension FlashView {

    func setupUI() {

    }

}

// MARK: - Bind
private extension FlashView {
    func bind() { }
}
