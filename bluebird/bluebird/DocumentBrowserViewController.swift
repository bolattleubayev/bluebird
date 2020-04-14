//
//  DocumentBrowserViewController.swift
//  bluebird
//
//  Created by macbook on 1/22/20.
//  Copyright © 2020 bolattleubayev. All rights reserved.
//

import UIKit


class DocumentBrowserViewController: UIDocumentBrowserViewController, UIDocumentBrowserViewControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
        
        allowsDocumentCreation = true
        allowsPickingMultipleItems = false
        
        // putting blank template to applicationSupport filder
        // to make it be "behind the scene"
        // create the local URL first
        
        template = try? FileManager.default.url(
            for: .applicationSupportDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: true
            ).appendingPathComponent("Untitled.bluebird")
        // create document on specified template URL
        if template != nil {
            allowsDocumentCreation = FileManager.default.createFile(atPath: template!.path, contents: Data())
        }
        
        // Update the style of the UIDocumentBrowserViewController
        // browserUserInterfaceStyle = .dark
        // view.tintColor = .white
    }
    
    var template: URL?
    
    // MARK: UIDocumentBrowserViewControllerDelegate
    
    func documentBrowser(_ controller: UIDocumentBrowserViewController, didRequestDocumentCreationWithHandler importHandler: @escaping (URL?, UIDocumentBrowserViewController.ImportMode) -> Void) {
        importHandler(template, .copy)
    }
    
    func documentBrowser(_ controller: UIDocumentBrowserViewController, didPickDocumentsAt documentURLs: [URL]) {
        guard let sourceURL = documentURLs.first else { return }
        
        // Present the Document View Controller for the first document that was picked.
        // If you support picking multiple items, make sure you handle them all.
        presentDocument(at: sourceURL)
    }
    
    func documentBrowser(_ controller: UIDocumentBrowserViewController, didImportDocumentAt sourceURL: URL, toDestinationURL destinationURL: URL) {
        // Present the Document View Controller for the new newly created document
        presentDocument(at: destinationURL)
    }
    
    func documentBrowser(_ controller: UIDocumentBrowserViewController, failedToImportDocumentAt documentURL: URL, error: Error?) {
        // Make sure to handle the failed import appropriately, e.g., by presenting an error message to the user.
    }
    
    // MARK: Document Presentation
    
    func presentDocument(at documentURL: URL) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let documentVC = storyBoard.instantiateViewController(withIdentifier: "DocumentMVC")
        // .contents is an extension that is stored in Utilities file
        // connecting to Navigation Controller
        if let mainMenuTableViewController = documentVC.contents as? MainMenuTableViewController {
            mainMenuTableViewController.document = bluebirdDocument(fileURL: documentURL)
        }
        // forcing full screen presentation
        documentVC.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
        present(documentVC, animated:  true)
    }
}

