//
//  DataCell.swift
//  SensorsApp
//
//  Created by Gundars Kokins on 31/08/2020.
//  Copyright © 2020 Gundars Kokins. All rights reserved.
//

import SwiftUI

struct DataCell: View {
    var cellName: String
    var cellData: Double
    var body: some View {
        HStack {
            Text(cellName)
            Spacer()
            Text("\(cellData)")
        }
    }
}

struct DataCell_Previews: PreviewProvider {
    @State static var data = 2.0
    static var previews: some View {
        DataCell(cellName: "Demo", cellData: data)
    }
}
