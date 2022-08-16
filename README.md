# Small Github App
This application takes user to github login page and after user granted obligatory permissions to the app,app shows a list of public repositories.
user can revoke application access to his data in his profile on Github.

# Requirement
- XCode 12.5 or later
- macOS Big Sur or later

# Installation
- To run the project :
- Open `GitClient.xcodeproj`

# Language used 
- Swift 5.4

# App Version
- 1.0.0 
# Design Pattern Used

## Clean Swift VIP
Clean Swift (a.k.a VIP) is Uncle Bob’s Clean Architecture applied to iOS and Mac projects. The Clean Swift Architecture is not a framework. It is a set of Xcode templates to generate the Clean Architecture components for you. That means you have the freedom to modify the templates to suit your needs.
- View Controller
  - The viewController has two main roles, one being as an entry point for any actions of the current scene, the other being to display the formatted information contained in the viewmodel back to the user
- Interactor
  - The role of the interactor is mainly the computation part of a scene. This is where you would fetch data (network or local), detect errors, make calculations, compute entries.
- Presenter
  - The presenter has a very precise role. Its main focus is to create a representation of parts of the data to be displayed on screen at a specific moment in time. This data representation is contained in an element called the viewmodel. Once it has formatted the raw data the presenter sends it back to the controller to be displayed.
- Worker
  - The worker is a secondary element in the clean swift schema. Its main role has to do with the heavy lifting and unburdening of the interactor from things like network api calls, database requests and so on.
- Models
  - This component encapsulates the request, response and viewmodel representation for each flow of action of the scene.
- Router
  - This element is linked to the controller. It takes care of the transition between scenes 

![Vip](https://www.netguru.com/hs-fs/hubfs/894db5a4-4fdf-4928-b887-07836f7ec843.jpeg?width=1604&name=894db5a4-4fdf-4928-b887-07836f7ec843.jpeg)

# Features

## Login View
- It Takes user to Github Site 
- ask user to input his credential info
- after succesful  login,it asks user to have access to Repo,User
- then open app with a deeplink as a request uri
- started handshaking with server for getting Access Token

## Dashboard
-  shows user personal info
-  show a list of repos

## Data Caching
- Kechain is used for saving access token in a secure enviroment. 

# Assumptions        
-   The app is designed for iPhones and iPad.        
-   App currently supports English and Persian languages.
-   Mobile and iPad platform supported: iOS (13.x,14.x, 15.x)        
-   Device support : iPhone , iPad  
-   Accsee token caching is available.



# Frameworks/Libraries used
- Moya
- SnapKit
- Kingfisher
- R.Swift
- Swiftlint


# Unit Test
- There is a part of unit test for dashboard



