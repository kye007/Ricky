//
//  ShowEpisodeCharactersViewController.swift
//  Rick
//
//  Created by George Kye on 2019-07-04.
//  Copyright © 2019 georgekye. All rights reserved.
//

import UIKit
import Morty

class ShowEpisodeCharactersViewController: UIViewController, AppDisplayable {
    
    // MARK: - Controls
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.tableFooterView = UIView() // removes separator lines for empty cells
        }
    }
    
    @IBOutlet private weak var episodeNameLabel: UILabel!
    @IBOutlet private weak var episodeSeasonLabel: UILabel!
    @IBOutlet private weak var episodeAirDateLabel: UILabel!
    
     @IBOutlet private weak var charactersActivityIndicator: UIActivityIndicatorView!
    
    // MARK: - Interactor
    var apiClient: RickMortyAPIServiceType = RickMortyAPINetworkService()
    
    // MARK: - Internal
    public var params: EpisodeViewModel?
    
    typealias CharacterSectionViewModel = (
        status: RickMortyCharacterStatus, characters: [CharacterViewModel]
    )
    
    private var characterViewModels: [CharacterSectionViewModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let params = params else { return }
        loadCharacters()
        display(episode: params)
        
        // avoid using stale model
        self.params = nil
    }
}

// MARK: - Delegates

private extension ShowEpisodeCharactersViewController {
    
    var characterCell: String { return "characterCell" }
}

extension ShowEpisodeCharactersViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return characterViewModels.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characterViewModels.get(section)?.characters.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: characterCell, for: indexPath)
        guard let model = characterViewModels.get(indexPath.section)?.characters.get(indexPath.row) else { return cell }
        (cell as? ShowEpisodeCharacterCell)?.bind(model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return characterViewModels.get(section)?.status.rawValue
    }
}

extension ShowEpisodeCharactersViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let model = characterViewModels.get(indexPath.section)?
            .characters.get(indexPath.row) else { return  }
        
        show(character: model)
    }
}

// MARK: - Controller
extension ShowEpisodeCharactersViewController: ShowEpisodeCharactersController {
    
    func loadCharacters() {
        charactersActivityIndicator.startAnimating()
        
        // Fetch all characters for episode
        guard let characters = params?.object.characters else { return }
        
        // Group async requests
        let dispatchGroup = DispatchGroup()
        
        var errors: [Error] = []
        var foundCharacters: [RickMortyCharacterType] = []
        
        for episode in characters {
            dispatchGroup.enter()
            
            let request = RickMortyAPIServiceModels.CharacterRequest(
                characterURLReference: episode
            )
            
            apiClient.fetch(character: request) {
                defer { dispatchGroup.leave() }
                do {
                    let character = try $0.get()
                    foundCharacters.append(character)
                } catch {
                    errors.append(error)
                }
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            self.charactersActivityIndicator.stopAnimating()
            
            // Display error if all requests failed
            if let error = errors.last, characters.isEmpty {
                return self.display(error, handler: nil)
            }
            
            self.display(characters: foundCharacters)
        }
    }
}

extension ShowEpisodeCharactersViewController: ShowEpisodeCharactersDisplayable {
    
    func display(episode: EpisodeViewModel) {
        episodeAirDateLabel.text = episode.airDate
        episodeSeasonLabel.text = episode.episodeMeta
        episodeNameLabel.text = episode.name
        
        title = episode.episodeMeta
    }
    
    func display(characters models: [RickMortyCharacterType]) {
        // Group found characters by status
        let viewModels: [CharacterSectionViewModel] = Dictionary(
            grouping: models,
            by: {$0.status}).enumerated().map {
                let characters = $0.element.value.sorted(by: {$0.created > $1.created}).map{
                    CharacterViewModel($0)
                }
                
                return CharacterSectionViewModel(
                    (status: $0.element.key, characters: characters)
                )
            }.sorted(by: {$0.status.rawValue < $1.status.rawValue})
        
        characterViewModels = viewModels
        tableView.reloadData()
    }
}

extension ShowEpisodeCharactersViewController: ShowEpisodeCharactersRouterAble {
    
    func show(character: CharacterViewModel) {
        let controller = UIViewController.make(fromStoryboard: .showCharacter)
        (controller as? ShowCharacterViewController)?.character = character
        show(controller, sender: self)
    }
}
