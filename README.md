# Key Vision
Key Vision is an iOS application for managing cameras and doors in your home. 
The app uses the Realm database, follows the MVC architectural pattern, and implements programmatic UI using code.

## Screenshots
<div align="left">
    <img src="https://github.com/remiie/KeyVision/blob/main/Screenshots/Screenshot1.png" alt="Screenshot 1" width="200" />
    <img src="https://github.com/remiie/KeyVision/blob/main/Screenshots/Screenshot2.png" alt="Screenshot 2" width="200" />
</div>

## Features
- Data Caching: Camera and door data for your home is cached in a local database using Realm. This allows the app to work offline, even when there is no internet connection.
- Favorites and Renaming: Users can add cameras and doors to their favorites list and rename them for convenient management. The changes are saved in the database.
- Snapshot Retrieval: The app retrieves snapshots from the server, allowing you to view the current state of your cameras in real-time.
- Forced Data Refresh: There is an option to forcibly refresh data from the server, ensuring you always have the most up-to-date information about your cameras and doors.
- Door Opening/Closing: The app includes a button for opening and closing doors.
## Dependencies
- Realm: Realm is the primary dependency for managing the database. It is integrated into the app and provides data management and access capabilities.
- CocoaPods: The app uses CocoaPods for dependency management. Make sure you have CocoaPods installed and run the pod install command to install all the necessary dependencies.

## System Requirements
iOS 15 or later
## Installation and Setup
1. Clone the Key Vision repository on your local computer.
2. Navigate to the project directory and run the pod install command to install the dependencies specified in the Podfile.
3. Open the KeyVision.xcworkspace file in Xcode.
4. Build and run the app on the simulator or a physical device.

## Usage
- After launching the Key Vision app, you will see a list of available cameras and doors in your home.
- To add an item to your favorites, simply tap the "Favorites" button next to it.
- To rename an item, tap on it, and you will be able to edit its name.
- You can force a data refresh from the server by pulling down on the screen or tapping the refresh button.
- To open or close a door, use the provided button.
