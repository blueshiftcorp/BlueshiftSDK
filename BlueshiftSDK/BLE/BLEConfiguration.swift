//
//  File name : BLEConfiguration.swift
//
//  Copyright (c) 2009-2021 Blueshift Corporation. All right reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//
//  Created by Blueshift on 2021/09/08
//

import Foundation
import CoreBluetooth

public protocol BLEConfiguration {
    
    /// Service UUID
    /// Sample : CBUUID.init(string: "0000abf0-0000-1000-8000-00805f9b34fb")
    var serviceUUID: CBUUID { get }
    
    /// Write Characteristic UUID
    /// Sample : CBUUID.init(string: "0000abf1-0000-1000-8000-00805f9b34fb")
    var writeCharacteristicUUID: CBUUID { get }
    
    /// Read Characteristic UUID
    /// CBUUID.init(string: "0000abf2-0000-1000-8000-00805f9b34fb")
    var readCharacteristicUUID: CBUUID { get }
}
