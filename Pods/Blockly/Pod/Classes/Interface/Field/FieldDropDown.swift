//
//  FieldDropDown.swift
//  Pods
//
//  Created by Joey Chan on 15/09/2015.
//
//

import UIKit

public class FieldDropDown: UIPickerView, UIPickerViewDataSource, UIPickerViewDelegate {

    public var data: [String]
    
    public init(data: [String]) {
        self.data = data
        super.init(frame: DefaultInputFrame)
        self.delegate = self
        self.dataSource = self
    }
    
    public func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }
    
    public func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return data[row]
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
