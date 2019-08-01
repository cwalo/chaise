# Chaise
--

## Installation
* If `Carthage` is not installed: `brew install carthage`
* `carthage bootstrap --platform iOS`
* In `Source/Networking/SeatGeekCredentials`, add your API `client_id`.
* `command + R` and 🙏🏻

## Notes

I hope the project is fairly straightforward to navigate, but a few things to point out.

* AppCoordinator handles all navigation in the application. Even though I use storyboards here, you'll note there are no segues. Additionally, this is where I inject dependencies. Managed view controllers pass any data back to the AppCoordinator who then routes the application where it needs to go next.
* I leverage `Remote` and `Entity` models. The former matches the response from the API while the latter is a flattened version used to merge remote and local state (`isFavorite`, for instance).
* I chose Moya (an abstraction over Alamofire) as my networking library for its interface and ease of use during testing.
* `SearchViewController` is backed by an `EventSearchViewModel` that abstracts all networking and data manipulation and simply "subscribes" to state changes. Reactive-ish.
* Note the `Throttler` class to ensure we don't spam the API more than necessary. This can be fine tuned with a `delay` property during initialization.
* The `FavoritesManager` is an abstracted  JSON file reader/writer. Objects can favorite and unfavorite. Objects can listen for changes via `NotificationCenter` notifications. To avoid superfuous file I/O, it will only write to disk when the application is sent to the background or when `deinit` is called. To top it off, because the favorites file is stored in the `libraryDirectory` favorites are synced across devices.
* I've added _some_ tests to exhibit the test-able nature of the app. I can easily verify views are configured properly without needing to create any remote model objects, verify that our custom date formatter parses the expected date strings correctly. I also test the SearchViewModel reports expected states back to the controller. FavoriteManager has some simple API interface tests.
	* Tests TODO: more SearchViewModel tests, more unhappy cases, ImageFetcher UIView extension
* Print logs while searching are intentional to highlight additional things I would show/do in the UI
