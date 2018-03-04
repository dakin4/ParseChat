//
//  LoginViewController.swift
//  ParseChat
//
//  Created by David King on 3/3/18.
//  Copyright © 2018 David King. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameLogin: UITextField!
    
    @IBOutlet weak var passwordLabel: UITextField!
    
    var userChange = false
    
    var passwordChange = false
   
    @IBAction func UserTextClicked(_ sender: AnyObject) {
        
        
        userChange = true
        usernameLogin.text = ""
        
    }
  
    @IBAction func PasswordTextClicked(_ sender: AnyObject) {
        
        passwordLabel.text = ""
        passwordChange = true
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        

        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func SignInClicked(_ sender: AnyObject) {
        //both must be clicked in in order to succesfully login
        //username can be username but it cant be empty
        if(userChange == true && passwordChange == true )
        {
           if (usernameLogin.text == "" || passwordLabel.text == "")
           {
            alert(Title: "Login Failure", Message: "Dont Forget to Input both Your Password and Username")
            
           }
    
            // sucess
           else
           
           {
           SignIn()
        
            }

        }
        else{
            alert(Title: "Sign in Error", Message: "Please Input Your Password and Username")
        }
    }
    
    func alert(Title: String, Message: String){
        
        let alertController = UIAlertController(title: Title, message: Message, preferredStyle: .alert)
        
        var okAction = UIAlertAction(title: "OK", style: .cancel) { (action) in
            // handle case of user logging out
        }
        // add the logout action to the alert controller
        alertController.addAction(okAction)
        
        present(alertController, animated: true) {
            // optional code for what happens after the alert controller has finished presenting
        }
        

        
        
        
    }

    func SignIn () {
        let newUser = PFUser()
        
        let username = usernameLogin.text
        let password = passwordLabel.text
        
        PFUser.logInWithUsername(inBackground: username!, password: password!) {(user: PFUser?, error: Error?) in
            if let error = error {
                self.alert(Title: "Login Fail", Message: error.localizedDescription)
                print("user log in failed: \(error.localizedDescription)")
            }
            else {
                print("User logged in sucess")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
                
                
            
            }
        }

        
        }
    
    func SignUp () {
        let newUser = PFUser()
        
        newUser.username = usernameLogin.text
        
        newUser.password = passwordLabel.text
        
        
        
        newUser.signUpInBackground
            {(success: Bool, error: Error?) in
                if let error = error
                {
                    self.alert(Title: "Sign Up Error", Message: error.localizedDescription)
                    print(error.localizedDescription)
                }
                    
                else {
                    print("username success ")
                    self.performSegue(withIdentifier: "loginSegue", sender: nil)
                }
                
        }

        
        
    }
    
    @IBAction func SignUpClicked(_ sender: AnyObject) {
        if(userChange == true && passwordChange == true )
        {
            if (usernameLogin.text == "" || passwordLabel.text == "")
            {
                alert(Title: "Sign Up Failure", Message: "Dont Forget to Input both Your Password and Username")
                
            }
                
                // sucess
            else
                
            {
                SignUp()
                
            }
            
        }
        else{
            alert(Title: "Sign Up Error", Message: "Please Sign Up")
        }
        
        
        
        
        }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

