//
//  Storyboards.swift
//  Rick
//
//  Created by George Kye on 2019-07-04.
//  Copyright © 2019 georgekye. All rights reserved.
//

import UIKit

enum Storyboard: String {
    case listEpisodes = "ListEpisodes"
    case showEpisodeCharacters = "ShowEpisodeCharacters"
    case showCharacter = "ShowCharacter"
}

extension UIViewController {
    
    /// Constructs an instance of the UIViewController type.
    ///
    /// - Parameters:
    ///   - storyboard: The Storyboard where the UIViewController is bound to.
    ///   - bundle: The bundle where the Storyboard is stored.
    ///   - identifier: The identifier of the UIViewController on the Storyboard,
    ///         or will fallback on the UIViewController designated as the initial
    ///         storyboard, or the UIViewController in the Storyboard with the
    ///         same identifier as the type name.
    /// - Returns: An instance of the UIViewController type.
    static func make<T: UIViewController>(
        fromStoryboard storyboard: Storyboard,
        inBundle bundle: Bundle? = nil,
        identifier: String? = nil) -> T {
        return make(fromStoryboard: storyboard.rawValue, inBundle: bundle, identifier: identifier)
    }
    
    /// Constructs an instance of the UIViewController type.
    ///
    /// - Parameters:
    ///   - storyboard: The Storyboard where the UIViewController is bound to.
    ///   - bundle: The bundle where the Storyboard is stored.
    ///   - identifier: The identifier of the UIViewController on the Storyboard,
    ///         or will fallback on the UIViewController designated as the initial
    ///         storyboard, or the UIViewController in the Storyboard with the
    ///         same identifier as the type name.
    /// - Returns: An instance of the UIViewController type.
    static func make<T: UIViewController>(
        fromStoryboard storyboard: String,
        inBundle bundle: Bundle? = nil,
        identifier: String? = nil) -> T {
        let storyboard = UIStoryboard(name: storyboard, bundle: bundle)
        
        guard let controller = (identifier != nil
            ? storyboard.instantiateViewController(withIdentifier: identifier!)
            : (storyboard.instantiateInitialViewController()
                ?? storyboard.instantiateViewController(withIdentifier: String(describing: T.self)))) as? T else {
                    // Check crash logs for occurances, confirm remote logger properly setup
                    fatalError("Invalid controller for storyboard \(storyboard).")
        }
        
        return controller
    }
}

