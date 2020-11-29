# Tapir App

### Visitors
- Visitors can check in when visiting Tapir Grocer.
- When they check in, the app will capture the visitor's full name, NRIC number, body temperature, date, and time.
- Instead of typing the URL into their browser, visitors can quickly open the check in link.

### Owner
- Location owners can sign up with the app and generate a link to display to their visitors.
- When visitors visit this link, they can check in.
### Screenshot
#### Homepage
![Screenshot](https://user-images.githubusercontent.com/32286860/100548922-ce2fcb80-32aa-11eb-9f22-7f438ec6c566.png)

#### Visitor
![Screenshot](https://user-images.githubusercontent.com/32286860/100548923-cec86200-32aa-11eb-9976-92365e1adde6.png) 
![Screenshot](https://user-images.githubusercontent.com/32286860/100548916-ca9c4480-32aa-11eb-9ea5-0b1264b1c0ef.png) 

#### Owner
![Screenshot](https://user-images.githubusercontent.com/32286860/100548924-cf60f880-32aa-11eb-86e4-f1c17e0419e8.png) 
![Screenshot](https://user-images.githubusercontent.com/32286860/100548926-cf60f880-32aa-11eb-972f-206cf64d70f2.png) 
![Screenshot](https://user-images.githubusercontent.com/32286860/100548921-ccfe9e80-32aa-11eb-9f1d-41fe20f66bb0.png) 

## Installation
First, you will need to install [flutter](https://flutter.dev/docs/get-started/install ) following the instructions on their site.
#### Command
#### Install dependencies

```sh
flutter pub get
```

#### Run application

```sh
flutter emulators --launch <emulator_name>
flutter run
```
#### Build

```sh
flutter build apk
```

#### Run tests

```sh
flutter test
```


#### Configuration
- Place  php folder in htdocs/tapirGrocer/ : [PHP Folder](https://github.com/Hana9JJANG/checkin-flutter-app/tree/main/tapirGrocer)
- Make sure to define your database connection in htdocs/tapirGrocer/conn.php 
- Now you can test your app! Just set your redirect_uri to http://localhost:8000/auth / http://localhost/phpmyadmin/ and run a PHP server 
- Import database to the server : [Database](https://github.com/Hana9JJANG/checkin-flutter-app/blob/main/tapirGrocer.sql)


