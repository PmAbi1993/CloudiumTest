import UIKit

enum EXStorBoardName {
    case `default`
    case custom(name: String)
    var name: String {
        switch self {
        case .default:
            return "Main"
        case .custom(name: let name):
            return name
        }
    }
}

protocol StoryBoardInitiable: class {
    static var storyBoardName: EXStorBoardName { get }
}

extension StoryBoardInitiable where Self: UIViewController {

    static func instance<T: StoryBoardInitiable>(bundle: Bundle? = nil) -> T {
        let storyBoard: UIStoryboard = UIStoryboard(name: storyBoardName.name, bundle: bundle)
        let controllerName: String = String(describing: self)
        let instantiatedInstance = storyBoard.instantiateViewController(withIdentifier: controllerName)
        guard let instantiatedController: T = instantiatedInstance as? T else {
            fatalError("Could not instantiate initial storyboard with name: \(String(describing: self))")
        }
        return instantiatedController
    }
}
