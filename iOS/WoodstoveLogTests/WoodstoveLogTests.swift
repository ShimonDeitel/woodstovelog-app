import XCTest
@testable import WoodstoveLog

final class WoodstoveLogTests: XCTestCase {
    var store: Store!

    override func setUp() {
        super.setUp()
        store = Store()
        store.items = []
        store.save()
    }

    func testAddIncreasesCount() {
        let before = store.items.count
        _ = store.add(SweepEntry())
        XCTAssertEqual(store.items.count, before + 1)
    }

    func testAddRespectsFreeLimit() {
        store.isPro = false
        store.items = []
        for _ in 0..<Store.freeLimit {
            _ = store.add(SweepEntry())
        }
        XCTAssertEqual(store.items.count, Store.freeLimit)
        let result = store.add(SweepEntry())
        XCTAssertFalse(result)
        XCTAssertEqual(store.items.count, Store.freeLimit)
    }

    func testProBypassesLimit() {
        store.isPro = true
        store.items = []
        for _ in 0..<(Store.freeLimit + 3) {
            _ = store.add(SweepEntry())
        }
        XCTAssertEqual(store.items.count, Store.freeLimit + 3)
    }

    func testDeleteAtOffsets() {
        _ = store.add(SweepEntry())
        _ = store.add(SweepEntry())
        let before = store.items.count
        store.delete(at: IndexSet(integer: 0))
        XCTAssertEqual(store.items.count, before - 1)
    }

    func testDeleteSpecificItem() {
        _ = store.add(SweepEntry())
        guard let item = store.items.first else { return XCTFail("no item") }
        store.delete(item)
        XCTAssertFalse(store.items.contains(where: { $0.id == item.id }))
    }

    func testCanAddMoreWhenUnderLimit() {
        store.isPro = false
        store.items = []
        XCTAssertTrue(store.canAddMore)
    }

    func testUpdatePersistsChange() {
        _ = store.add(SweepEntry())
        guard let item = store.items.first else { return XCTFail("no item") }
        store.update(item)
        XCTAssertEqual(store.items.first?.id, item.id)
    }

    func testPersistenceReload() {
        store.items = []
        _ = store.add(SweepEntry())
        let reloaded = Store()
        reloaded.load()
        XCTAssertFalse(reloaded.items.isEmpty)
    }
}
