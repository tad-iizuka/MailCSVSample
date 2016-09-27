//
//  ViewController.swift
//  MailCSVSample
//
//  Created by Tadashi on 2016/09/28.
//  Copyright © 2016 T@d. All rights reserved.
//

import UIKit
import MessageUI

class ViewController: UIViewController, MFMailComposeViewControllerDelegate {

	@IBOutlet weak var SendMail: UIButton!
	@IBAction func SendMail(_ sender: AnyObject) {

		// Make a CSV object
		var fileObject = String()
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
		for _ in 1...10 {
			fileObject.append(String(format:"%@\n", formatter.string(from: NSDate() as Date)))
		}

		// Make a mail body
        if MFMailComposeViewController.canSendMail() == false {
            print(String(format: "Error %@: %d",#file, #line))
            return
        }

        let mailCompose = MFMailComposeViewController()
//		let to = [""]
//		let cc = [""]
//		let bcc = [""]

        mailCompose.mailComposeDelegate = self
        mailCompose.setSubject("Attached CSV file")
//		mailCompose.setToRecipients(to)
//		mailCompose.setCcRecipients(cc)
//		mailCompose.setCcRecipients(cc)
        mailCompose.setMessageBody("Please make sure.", isHTML: false)

		let data = fileObject.data(using: String.Encoding.utf8)
		let fName = String(format:"%@\n", formatter.string(from: NSDate() as Date)) + ".csv"
		mailCompose.addAttachmentData(data!, mimeType: "text/csv", fileName: fName)

        self.present(mailCompose, animated: true, completion: nil)

	}

	override func viewDidLoad() {
		super.viewDidLoad()

		self.SendMail.layer.borderColor = UIColor.blue.cgColor
		self.SendMail.layer.borderWidth = 1.0
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}

	func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {

		if (error != nil) {
			print(String(format: "Error %@: %d",#file, #line))
		}

		switch result {
			case MFMailComposeResult.cancelled: break
			case MFMailComposeResult.saved: break
			case MFMailComposeResult.sent: break
			case MFMailComposeResult.failed: break
		}
		self.dismiss(animated: true, completion: nil)
	}
}

