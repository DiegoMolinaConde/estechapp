//
//  ViewController.swift
//  EstechApp
//
//  Created by dam2 on 11/3/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var Usuario: UITextField!
    @IBOutlet weak var Contraseña: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func IniciarSesion(_ sender: Any) {
        self.navigateToTabBarController(withIdentifier: "StudentController", token: "")
        
        
        guard let email = Usuario.text, let password = Contraseña.text else {
            showAlert(message: "Por favor, introduce tu correo y contraseña")
            return
        }
        
     /*   let parameters = ["email": email, "password": password]
        
        sendLoginRequest(parameters: parameters) { result in
            switch result {
            case .success(let response):
                if response.roles.contains(where: { $0.authority == "ROLE_TEACHER" }) {
                    // Navegar al tab bar del profesor
                    DispatchQueue.main.async {
                        self.navigateToTabBarController(withIdentifier: "ProfesorController", token: response.token)
                    }
                } else if response.roles.contains(where: { $0.authority == "ROLE_STUDENT" }) {
                    // Navegar al tab bar del estudiante
                    DispatchQueue.main.async {
                        self.navigateToTabBarController(withIdentifier: "StudentController", token: response.token)
                    }
                } else {
                    self.showAlert(message: "Usuario o contraseña incorrectos")
                }
            case .failure(let error):
                self.showAlert(message: "Error: \(error.localizedDescription)")
            }
        }*/
    }
    
    func sendLoginRequest(parameters: [String: String], completion: @escaping (Result<LoginResponse, Error>) -> Void) {
        // Define la URL del endpoint de inicio de sesión en tu servidor
        guard let url = URL(string: "http://localhost:8080/login") else {
            print("URL inválida")
            return
        }
        
        // Crea la solicitud HTTP POST
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // Configura el cuerpo de la solicitud con los parámetros de inicio de sesión
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
            print("Error al configurar el cuerpo de la solicitud: \(error)")
            completion(.failure(error))
            return
        }
        
        // Configura el encabezado de la solicitud para indicar que se espera una respuesta JSON
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Envía la solicitud al servidor
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error al enviar la solicitud: \(error)")
                completion(.failure(error))
                return
            }
            
            // Verifica si se recibió una respuesta válida del servidor
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Respuesta no válida del servidor")
                completion(.failure(NSError(domain: "Servidor", code: 500, userInfo: nil)))
                return
            }
            
            // Procesa la respuesta del servidor
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let loginResponse = try decoder.decode(LoginResponse.self, from: data)
                    completion(.success(loginResponse))
                } catch let error {
                    print("Error al decodificar la respuesta del servidor: \(error)")
                    completion(.failure(error))
                }
            } else {
                print("No se recibieron datos del servidor")
                completion(.failure(NSError(domain: "Servidor", code: 500, userInfo: nil)))
            }
        }
        
        task.resume()
    }
    
    func navigateToTabBarController(withIdentifier identifier: String, token: String) {
        // Guardar el token en UserDefaults
        UserDefaults.standard.set(token, forKey: "Token")
        
        // Navegar al tab bar controller adecuado
        if let tabBarController = storyboard?.instantiateViewController(withIdentifier: identifier) {
            tabBarController.modalPresentationStyle = .fullScreen
            present(tabBarController, animated: true, completion: nil)
        }
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Alerta", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}
