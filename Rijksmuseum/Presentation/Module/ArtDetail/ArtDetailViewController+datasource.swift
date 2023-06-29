
//  Created by Gayan Dias on 28/06/2023.


import UIKit

extension ArtDetailViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.artDetails.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.numberOfLines = 0
        let item = self.viewModel.artDetails[indexPath.row]
        cell.textLabel?.text = item.value
        cell.textLabel?.font = .ubuntuItalic(size: 18)
        cell.selectionStyle = .none
        return cell
    }
}
