# Sample iOS Project testing with Ethernom SDK 



## The necessary usage and how to use Library in iOS 

### Add Bluetooth permission inside your Info.list 
- [ ] NSBluetoothPeripheralUsageDescription: is requesting the ability to connect to Bluetooth peripherals . ” Explain the reasons for Bluetooth usage” .
- [ ] NSBluetoothAlwaysUsageDescription:   to that tells the user why the app needs access to Bluetooth.  “ Explain the reasons for Bluetooth usage”.

### Configure and Initialize EthHFS SDK
- [ ] Import EthFSH in header of your AppDelegate.swift  and Initialize initETHService = true

### BLE Connectivity API
- [ ] InitBLEConnection and ETHConnectivityDeviceDelegate callback handler
- [ ] EthBLEScan(Device): This API use for scan all Ethernom Card that advertising near by User Application with the Discover Device Callback Handler whenever detect the advertisement packet
- [ ] EthBLEConnection(Device): This API use for connect to the Ethernom Card that advertise for connect with Connection Callback Handler to indicate the connection success or fail.
- [ ] EthBLEDisconnect(Device): This API use for disconnect the Ethernom Card device  with the Disconnect Device Callback
