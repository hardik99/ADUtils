//
//  ViewLayoutTest.swift
//  ADUtils
//
//  Created by Benjamin Lavialle on 16/05/2017.
//
//

import Foundation
import Quick
import ADUtils
import Nimble

class ViewLayout: QuickSpec {

    override func spec() {

        let veryLongText = "Lorem sizzle pimpin' sit amizzle, yippiyo adipiscing izzle. Nullizzle bling bling velit, away ghetto, suscipit dang, gravida vel, ass. Pellentesque eget tortor. Bow wow wow erizzle. Own yo' uhuh ... yih! sizzle dapibizzle turpis tempus shut the shizzle up. Maurizzle fo shizzle my nizzle crunk et turpizzle. Phat in tortizzle. Fizzle eleifend rhoncizzle i'm in the shizzle. In shut the shizzle up habitasse platea dictumst. Sheezy dapibizzle. Fo tellizzle urna, pretizzle eu, stuff shut the shizzle up, you son of a bizzle boofron, nunc. Fo suscipizzle. Integer sempizzle shizzle my nizzle crocodizzle ass purus"

        describe("layout properly") {

            let width: CGFloat = 100
            var view: UICollectionViewCell!

            beforeEach {
                view = UICollectionViewCell(
                    frame: CGRect(x: 0.0, y: 0.0, width: 320.0, height: 100.0)
                )
                let label = UILabel()
                label.numberOfLines = 0
                label.text = veryLongText
                view.contentView.addSubview(label)
                label.ad_pinToSuperview()
            }

            it("should compute height") {
                let height = view.ad_preferredLayoutHeight(fittingWidth: width)
                expect(height).to(equal(CGFloat(1218.0)))
            }
        }

        describe("layout UITableViewCell") {

            let width: CGFloat = 100
            var view: UITableViewCell!

            beforeEach {
                view = UITableViewCell(style: .default, reuseIdentifier: nil)
                view.frame = CGRect(x: 0.0, y: 0.0, width: 320.0, height: 100.0)
                let label = UILabel()
                label.numberOfLines = 0
                label.text = veryLongText
                view.contentView.addSubview(label)
                label.ad_pinToSuperview()
            }

            it("should compute height") {
                let height = view.ad_preferredCellLayoutHeight(fittingWidth: width)
                expect(height).to(equal(CGFloat(1218.0)))
            }
        }
    }
}
