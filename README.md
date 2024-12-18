# devfest_ado_2024
The idea of the project is to have a seamless means of interaction. 

# Feature of the App
# HomeScree
    - Next Session - Fetch data fro GoogleSheet
    - Upcoming session - Fetch data from Google SHeet
    - Live Twitter (X) feed

# AgendaScreen
    - Complete event Agenda - This fetch data from GoogleSheet 
    - Sample template Sheet - https://4tin.ng/sampelsheet

# GallerScreen
     - Take photo
    - Store locally
    - Automatically upload to Google Photo Album created

# NoteScreen
    - Jot down notes during sessions. (Store in cloud)

# PartnersScreen
    - Sponsors and Partners logo with link to their website 



## Getting Started

Setup your Flutter Env with your prefer ID

## Files to Edit 1
    - ...\devfest_ado_2024\lib\core\config\api_config.dart
- [Your-googleApiKey] // create your project on CLoud console 
- [Your-page-TwitterId] // Use https://twiteridfinder.com/ to find your ID (this has to be numbers only)
- [Your- twitterBearerToken] // from Twitter Developer App

## File to Edit 2
    - ...\devfest_ado_2024\lib\features\gallery\services\gallery_service.dart
- line 13 // Replace with your Google Photo Album ID (can be found in your album URL link)

## File to Edit 3
    - ... \devfest_ado_2024\lib\features\home\domain\models\session.dart
- From line 25 - Session Type // you can change it your your taste, you can as well add more type

## File to Edit 4
    - ...\devfest_ado_2024\lib\features\agenda\services\agenda_service.dart
- line 17 & 18 
- static const _spreadsheetId = 'Replace-with-your-GoogleSheetID'; //you can find this in the URL
  static const _apiKey = 'Replace-with-your-API'; //Enable Google Sheet API in your consule projrct, set your  oAuth Screen 

## File to Edit 5
  - ...\devfest_ado_2024\lib\features\home\data\services\sheets_service.dart
- Line 11 //Replace with your SheetID
- Line 12 // Replace with your PROJECT API
- Line 21 // Replace it with you Sheet Tab Name and Specify the colum 

## File to Edit 6
  - ...\devfest_ado_2024\lib\features\partners\data\partners_data.dart
  - Make sure to add your images to assets folder, add their names, url and the rest 

## File to Edit 7
  - Locate main.dart file change GDG Ado-Ekiti
  - Locate HomeScreen - Change GDG Ado Ekiti
  - Locate mainScreen - Change the name to yours 
  - Locate OnboardScreen and change the text, and make sure the images are in your assets folder, and properly place in you Pubspec.yaml

## Others - There are implementations which are not functioning yet
  - User connectivity and interactions
  - Note like and share

## Download the APK
 https://4tin.ng/Devfestapp


NB: Please note if you found well cooked beans, we are sorry, we will keep fixing the errors till it its perfect. 


# Author -
# name: David Oluwabusayo
# email: amdjflow@gmail.com
# Phone: +2348058667925

