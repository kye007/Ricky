//
//  ListEpisodesViewController.swift
//  Rick
//
//  Created by George Kye on 2019-07-04.
//  Copyright © 2019 georgekye. All rights reserved.
//

import UIKit
import Morty

class ListEpisodesViewController: UIViewController, AppDisplayable {
    
    // MARK: - Controls
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.tableFooterView = UIView() // removes separator lines for empty cells
            tableView.register(
                UINib(nibName: "CardViewCell", bundle: nil),
                forCellReuseIdentifier: episodeCellID
            )
            tableView.allowsSelection = false
        }
    }
    
    // MARK: - Interactor
    var apiClient: RickMortyAPIServiceType = RickMortyAPINetworkService()
    
    // MARK: - Internal
    private var pageInfo: RickMortyAPIServiceModels.ResponseInfo?
    private var episodesViewModels: [EpisodeViewModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadEpisodes()
    }
}

// MARK: - Delegates

private extension ListEpisodesViewController {
    var episodeCellID: String { return "EpisodeCell" }
}

extension ListEpisodesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodesViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: episodeCellID, for: indexPath)
        guard let model = episodesViewModels.get(indexPath.row) else { return cell }
        (cell as? CardViewCell)?.bind(model, handler: { [weak self] in
            // Bind tap action
            self?.showCharacters(episode: model)
        })
        return cell
    }
}

// MARK: - Controller
extension ListEpisodesViewController: ListEpisodesController {
    
    func loadEpisodes() {
        apiClient.fetchEpisodes {
            do {
                let episodes = try $0.get()
                self.display(episodes: episodes)
            } catch {
                self.display(error, handler: nil)
            }
        }
    }
}

extension ListEpisodesViewController: ListEpisdeControllerDisplayable {
    
    func display(episodes model: RickMortyEpisodesType) {
        pageInfo = model.info
        
        
        let models = model.episodes.map {
            EpisodeViewModel($0)
        }
        
        if pageInfo?.prev == nil {
            episodesViewModels = models
        } else {
            // Display incoming paginated data
            episodesViewModels.append(contentsOf: models)
        }
        
        tableView.reloadData()
    }
}

extension ListEpisodesViewController: ListEpisodesRouterAble {
    
    func showCharacters(episode: EpisodeViewModel) {
        let controller = UIViewController.make(fromStoryboard: .showEpisodeCharacters)
        // Send episode param along to next screen
        (controller as? ShowEpisodeCharactersViewController)?.params = episode
        show(controller, sender: self)
    }
}
