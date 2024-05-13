//
//  HistoryCheckInPresenter.swift
//  EstechApp
//
//  Created by Junior Quevedo Gutiérrez  on 12/05/24.
//

import Foundation
import BDRCoreNetwork

protocol HistoryCheckInPresenter {
    var view: HistoryCheckinView? { get set }
    func fetchHistory()
}

class HistoryCheckInPresenterDefault: HistoryCheckInPresenter {
    weak var view: HistoryCheckinView?
    private let networkRequest: BederrApiManager
    private let session: SessionManager
    init(networkRequest: BederrApiManager = BederrApiManager.shared ,
         session: SessionManager = SessionManager.shared) {
        self.networkRequest = networkRequest
        self.session = session
    }
    
    func fetchHistory() {
        let endpoint = EstechAppEndpoints.listCheckins
        
        networkRequest
            .setEndpoint(endpoint.path, .v5)
            .setHttpMethod(endpoint.method)
            .setParameter(endpoint.parameters)
            .subscribeAndReceivedData{ [weak self] (result) in
                switch result {
                case .success(let dataRaw):
                    guard let raw = dataRaw as? Data,
                          let response = [CheckInResponse].decodeJsonData(raw) else {
                        self?.view?.showLoading(isActive: false)
                        self?.view?.showError(message: "Error al decodificar la respuesta del servidor")
                        return
                    }
                    
                    let results = response.map({ item in
                        Fichaje.init(day: 1, month: 1, year: 1, hour: "10:12")
                    })
                    
                    self?.view?.show(checkIn: results);
                case .failure(let error):
                    self?.view?.showLoading(isActive: false)
                    self?.view?.showError(message: error.localizedDescription)
                }
            }
    }
    
    
}
