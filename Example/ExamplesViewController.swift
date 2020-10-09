//
//  ExamplesViewController.swift
//  Example
//
//  Created by Harley-xk on 2020/9/30.
//  Copyright © 2020 Harley. All rights reserved.
//

import UIKit

protocol AnyChyrsanExample {
    var name: String { get }
    func show(in viewController: UIViewController)
}

struct ExampleGroup {
    var name: String
    var examples: [AnyChyrsanExample]
}

class ExamplesViewController: UITableViewController {

    var exampleGroups: [ExampleGroup] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        exampleGroups = [
            ExampleGroup(name: "Showing Animations", examples: [
                SpringAnimationExample(),
                CubicAnimationExample()
            ]),
            ExampleGroup(name: "Indicators", examples: [
                SystemIndicatorExample(),
                RingIndicatorExample(stretch: false),
                RingIndicatorExample(stretch: true),
                CircleDotsIndicatorExample(),
                GIFIndicatorExample()
            ]),
            ExampleGroup(name: "Progress", examples: [
                RingProgressExample(),
                BarProgressExample()
            ]),
            ExampleGroup(name: "Static States", examples: [
                SuccessStateExample(),
                FailureStateExample(),
                CustomIconExamples(),
                PlainTextExample.shortExample,
                PlainTextExample.longExample
            ])
        ]
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return exampleGroups.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return exampleGroups[section].name
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exampleGroups[section].examples.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let example = exampleGroups[indexPath.section].examples[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExampleCell", for: indexPath)
        cell.textLabel?.text = example.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let example = exampleGroups[indexPath.section].examples[indexPath.row]
        example.show(in: self)
    }
}

extension DispatchQueue {
    func asyncAfter(seconds: TimeInterval, task: @escaping () -> ()) {
        asyncAfter(deadline: .now() + .milliseconds(Int(seconds * 1000))) {
            task()
        }
    }
}
