# LabHouse Radio App

## How to run

Flutter Version: 3.13.3

To run the desired project either use the launch configuration in VSCode/Android Studio or use the following commands:

```sh
$ flutter run
```

## Testing

To run all unit and widget tests use the following command:

```sh
$ flutter test
```

## Architecture
- Application
    - Responsible for State Management 
    - Contains Blocs, Events and States
    - It is the connection between Business Logic (Repositories) and UI
- Data
    - Responsible for getting Remote Data and transforming it into Models
- Domain
    - Responsible for the Business Logic
    - It should be independent to the changes on the Data Layer
- Presentation
    - Responsible for the UI
    - Widgets call Bloc Events and listen Bloc States
