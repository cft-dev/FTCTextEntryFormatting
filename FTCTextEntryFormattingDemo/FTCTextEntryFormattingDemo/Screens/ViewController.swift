// Copyright (c) 2017 CFT
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
	@IBOutlet var tableView: UITableView!

	let formattingExampleItems: [FormattingExampleItem] = FormattingExampleItem.makeItems()

	override func viewDidLoad()
	{
		super.viewDidLoad()
	}

	public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
	{
		return self.formattingExampleItems.count
	}

	public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
	{
		let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)

		cell.textLabel?.text = formattingExampleItems[indexPath.row].text
		cell.detailTextLabel?.text = formattingExampleItems[indexPath.row].detailText

		return cell
	}

	public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
	{
		tableView.deselectRow(at: indexPath, animated: true)

		if let vc = self.storyboard?.instantiateViewController(withIdentifier: "EntryViewController") as? EntryViewController
		{
			vc.formattingConfig = formattingExampleItems[indexPath.row].config
			vc.keyboard = formattingExampleItems[indexPath.row].keyboard

			self.present(vc, animated: true, completion: nil)
		}
	}
}
