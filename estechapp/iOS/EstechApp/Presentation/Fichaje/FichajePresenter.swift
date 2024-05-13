//
//  FichajePresenter.swift
//  EstechApp
//
//  Created by Junior Quevedo Gutiérrez  on 12/05/24.
//

import Foundation
import BDRModel
import BDRCoreNetwork

protocol FichajePresenter: AnyObject {
    var view: FichajeView? { get set } 
    func fetchTutorias()
    func fetchHorarios()
    func fetchInfoUser()
    func fetchAddCheckin()
}

class FichajePresenterDefault: FichajePresenter {
    weak var view: FichajeView?
    private let networkRequest: BederrApiManager
    private let session: SessionManager
    private let kCheckInLasState = "kCheckInLasState"
    init(networkRequest: BederrApiManager = BederrApiManager.shared ,
         session: SessionManager = SessionManager.shared) {
        self.networkRequest = networkRequest
        self.session = session
    }
    
    func fetchTutorias() {
        
    }
    
    func fetchHorarios() {
        
    }
    
    func fetchInfoUser() {
        view?.showName(name: session.user?.firstName ?? "")
        let lastState = UserDefaults.standard.bool(forKey: kCheckInLasState)
        view?.showStateCheckIn(isCheckIn: lastState)
    }
    
    func fetchAddCheckin() {
        let lastState = UserDefaults.standard.bool(forKey: kCheckInLasState)
        let endpoint = EstechAppEndpoints.addChekIn(
            [
                "checkIn": lastState,
                "date": DateFormatter.sharedFormatter.stringFromDate(Date(), withFormat: kJSONDateFormatter),
                "user": ["id": session.user?.id ?? 0]
            ]
        )
        
        networkRequest
            .setEndpoint(endpoint.path, .v5)
            .setHttpMethod(endpoint.method)
            .setParameter(endpoint.parameters)
            .subscribeAndReceivedData{ [weak self] (result) in
                switch result {
                case .success(let dataRaw):
                    guard let raw = dataRaw as? Data,
                          let response = CheckInResponse.decodeJsonData(raw) else {
                        self?.view?.showLoading(isActive: false)
                        self?.view?.showError(message: "Error al decodificar la respuesta del servidor")
                        return
                    }
                    
                    UserDefaults.standard.set(response.checkIn, forKey: self?.kCheckInLasState ?? "-")
                    self?.view?.showStateCheckIn(isCheckIn: response.checkIn)
                case .failure(let error):
                    self?.view?.showLoading(isActive: false)
                    self?.view?.showError(message: error.localizedDescription)
                }
            }
    }
    
    
}
