//
//  JuegosViewController.swift
//  ColeccionDeJuegos
//
//  Created by Mac 19 on 17/05/23.
//

import UIKit

class JuegosViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var agregarActualizarBoton: UIButton!
    var imagePicker = UIImagePickerController()
    var juego:Juego? = nil
    
    @IBAction func eliminarTapped(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.delete(juego!)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController?.popViewController(animated: true)
    }
    @IBAction func agregarTapped(_ sender: Any) {
        if juego != nil {
          juego!.titulo! = titutloTextField.text!
          juego!.imagen = imageView.image?.jpegData(compressionQuality: 0.50)
        } else {
          let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
          let juego = Juego(context: context)
          juego.titulo = titutloTextField.text
          juego.imagen = imageView.image?.jpegData(compressionQuality: 0.50)
        }
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController?.popViewController(animated: true)

    }
    
    @IBOutlet weak var titutloTextField: UITextField!

    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func fotosTapped(_ sender: Any) {
        
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    @IBAction func camaraTapped(_ sender: Any) {
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let imagenSeleccionada = info[.originalImage] as? UIImage
        imageView.image = imagenSeleccionada
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    
    @IBOutlet weak var eliminarBoton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        
        if juego != nil {
          imageView.image = UIImage(data: (juego!.imagen!) as Data)
        titutloTextField.text = juego!.titulo
        agregarActualizarBoton.setTitle("Actualizar", for: .normal)

        }else {
            eliminarBoton.isHidden = true
          }


    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
