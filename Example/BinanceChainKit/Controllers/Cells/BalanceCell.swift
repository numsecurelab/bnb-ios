import UIKit

class BalanceCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel?
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var valueLabel: UILabel?

    func bind(adapter: BinanceChainAdapter) {
        let syncStateString: String

        switch adapter.syncState {
        case .synced: syncStateString = "Synced!"
        case .syncing: syncStateString = "Syncing"
        case .notSynced: syncStateString = "Not Synced"
        }

        nameLabel?.text = adapter.name

        set(string: """
                    Sync state:
                    Block height:
                    Balance:
                    """, alignment: .left, label: titleLabel)

        set(string: """
                    \(syncStateString)
                    \(adapter.latestBlockHeight.map { "# \($0)" } ?? "n/a")
                    \(adapter.balance) \(adapter.coin)
                    """, alignment: .right, label: valueLabel)
    }

    private func set(string: String, alignment: NSTextAlignment, label: UILabel?) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        paragraphStyle.alignment = alignment

        let attributedString = NSMutableAttributedString(string: string)
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))

        label?.attributedText = attributedString
    }

}
