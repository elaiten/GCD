//
//  SecondViewController.swift
//  GCD
//
//  Created by Руслан on 30.11.2023.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var actiovityIndecation: UIActivityIndicatorView!
    
    
    fileprivate var imageURL: URL?
    fileprivate var image: UIImage? {
        get {
            return imageView.image
        }
        
        set {
            actiovityIndecation.stopAnimating()
            actiovityIndecation.isHidden = true
            imageView.image = newValue
            imageView.sizeToFit()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        featchImage()
        delay(delay: 3) {
            self.loginAlert()
        }
    }
    
    fileprivate func delay(delay: Int, closure: @escaping()->()) {
//        выполняет блок кода спустя время от момента когда начали .now + .second
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(delay)) {
            closure()
        }
    }
//    всплывающий аллерт с разным вариантом ответа
    fileprivate func loginAlert() {
        let ac = UIAlertController(title: "Зарегистрированный", message: "Введите ваш логин и пароль", preferredStyle: .alert )
            
        
        let action = UIAlertAction(title: "Окей", style: .default, handler: nil)
        let cancelAction = UIAlertAction(title: "Отмена", style: .default, handler: nil)
        
        ac.addAction(action)
        ac.addAction(cancelAction)
        
        ac.addTextField { (usernameTF) in
            usernameTF.placeholder = "Введите логин"
        }
        ac.addTextField { (userpassword) in
            userpassword.placeholder = "Введите пароль"
            userpassword.isSecureTextEntry = true
        }
        
        self.present(ac, animated: true, completion: nil)
        }
    
//    загрузка фото с сайта
    fileprivate func featchImage() {
        self.imageURL = URL(string: "https://gas-kvas.com/uploads/posts/2023-02/1675484242_gas-kvas-com-p-kartinki-dlya-fonovogo-risunka-raboch-stol-22.jpg")
        actiovityIndecation.isHidden = false
        actiovityIndecation.startAnimating()
//        создаем константу очереди в которой добавляем ее метод реализации
//        это Cuncurrent Queue
        let queue = DispatchQueue.global(qos: .default)
        queue.async {
            guard let url = self.imageURL, let imageData = try? Data(contentsOf: url) else {return}
            DispatchQueue.main.async {
                self.image = UIImage(data: imageData)
            }
        }
           
            
        

    }
}
