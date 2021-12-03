//
//  File name : BLE.swift
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

//protocol BLEDelegate {
//    func dataReceivedFromBLE()
//    func didDiscoverPeripherals()
//}

open class BLE: NSObject, CBPeripheralDelegate, CBCentralManagerDelegate {
    
    var centralManager: CBCentralManager?
    public var peripherals = [CBPeripheral]()
    var connectedPeripheral: CBPeripheral?
//    var delegate: BLEDelegate!
    public var RCharacteristic: CBCharacteristic?
    public var TCharacteristic: CBCharacteristic?
    
    var isBatteryNoticed = false
    var isAvailable = false
    var isAuthorized = true
    
    var writeIterationsComplete = 0
    let defaultIterations = 5
    
    var receivedData = ""
    var receiveIteration = 0
    
    var timer: Timer?
    
    var devicePeripheral: BLEConfiguration!
    
    init(_ _devicePeripheral: BLEConfiguration) {
        super.init()
        
        self.devicePeripheral = _devicePeripheral
        
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    //MARK:- CBCentralManagerDelegate
    open func centralManagerDidUpdateState(_ central: CBCentralManager) {
        
        switch central.state {
        case .poweredOff, .unsupported, .unknown:
            print("Bluetooth is Off.")

        case .poweredOn, .resetting:
            print("Bluetooth is On.")
            scanPeripherals()
            
        case .unauthorized:
            if #available(iOS 13.0, *) {
                switch central.authorization {
                case .denied, .notDetermined, .restricted:
                    isAuthorized = false
                default: break
                }
            } else {
                // Fallback on earlier versions
            }
        default:
            break
        }
        
    }
    
    public func scanPeripherals() {
        
        self.isAvailable = false
        self.peripherals.removeAll()
        self.connectedPeripheral = nil
        self.RCharacteristic = nil
        self.TCharacteristic = nil
        
        guard let central = centralManager else { return }
        print("Central scanning for", devicePeripheral.serviceUUID)
        central.scanForPeripherals(withServices: [devicePeripheral.serviceUUID], options: [CBCentralManagerScanOptionAllowDuplicatesKey : true])
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
            central.stopScan()
        }
    }
    
    open func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        
        if !peripherals.contains(peripheral) {
            self.peripherals.append(peripheral)
            print("Central discover peripheral")
//            delegate.didDiscoverPeripherals()
        }
    }
    
    open func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        
        if peripheral == self.connectedPeripheral {
            print("Connected to device.")
            peripheral.discoverServices([devicePeripheral.serviceUUID])
        }
    }
    
    open func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        
        // 블루투스 연결이 끊긴 경우 처리할 프로세스 추가
    }
    
    //MARK:- CBPeripheralDelegate
    open func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        if let services = peripheral.services {
            print("Discovered: \(services)")
            for service in services {
                
                if service.uuid == devicePeripheral.serviceUUID {
                    print("Senscup service found")
                    peripheral.discoverCharacteristics([devicePeripheral.writeCharacteristicUUID, devicePeripheral.readCharacteristicUUID], for: service)
                }
            }
        }
    }
    
    open func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        if let characteristics = service.characteristics {
            for characteristic in characteristics {
                if characteristic.uuid == devicePeripheral.writeCharacteristicUUID {

                    self.RCharacteristic = characteristic
                    
                    //TODO: 블루투스 연결 후 해야하는 업무 추가
                    
                    print("RX Characteristic found")
                } else if characteristic.uuid == devicePeripheral.readCharacteristicUUID {
                    peripheral.setNotifyValue(true, for: characteristic)
                    print("TX Characteristic found")
                }
            }
        }
    }
    
    open func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        guard error == nil else {
            print("ERROR while updateValue \(error!)")
            return
        }
        
        guard let data = characteristic.value else { return }
        guard let stringFromData = String(bytes: data, encoding: .utf8) else { return }
        print ("String from Received Data: \(stringFromData)")
        
    }
    
    public func connectPeripheral(index: Int) {
        let peripheral = peripherals[index]
        self.connectedPeripheral = peripheral
        self.connectedPeripheral?.delegate = self
        centralManager?.connect(peripheral, options: nil)
        self.isAvailable = true
    }
        
    open func writeValueToChar(/*withCharacteristic characteristic: CBCharacteristic,*/ withValue value: Data) {
        
        guard let rc = self.RCharacteristic, let cp = connectedPeripheral else { return }
        if #available(iOS 11.0, *) {
            if cp.canSendWriteWithoutResponse {
                let stringFromData = String(data: value, encoding: .utf8)
                print("Data is : \(stringFromData ?? "not available")")
                cp.writeValue(value, for: rc, type: .withoutResponse)
            }
        } else {
            // Fallback on earlier versions
        }
     }
    
    open func readValueFromChar(withCharacteristic characteristic: CBCharacteristic) {
        if characteristic.properties.contains(.read) && connectedPeripheral != nil {
            connectedPeripheral!.readValue(for: characteristic)
        }
    }
    
    open func disconnectFromDevice() {
        guard let central = centralManager else { return }
        guard let peripheral = self.connectedPeripheral else { return }
        central.cancelPeripheralConnection(peripheral)
    }
}
