<<<<<<< HEAD
# Flutter Number Trivia Clean Architecture

A Flutter application that demonstrates Clean Architecture principles while implementing a Number Trivia feature. This project follows best practices and modern Flutter development patterns.

## Features

- Clean Architecture implementation
- Number Trivia functionality
- State management using BLoC pattern
- Dependency injection using GetIt
- Error handling and network connectivity checks
- Unit and widget testing

## Architecture

The project follows Clean Architecture principles with the following layers:
- Presentation Layer (UI)
- Domain Layer (Business Logic)
- Data Layer (Data Sources)

## Getting Started

### Prerequisites

- Flutter SDK (>=3.3.4)
- Dart SDK (>=3.3.4)
- Android Studio / VS Code
- Git

### Installation

1. Clone the repository:
```bash
git clone https://github.com/Abdulkhaliq-84/flutter-number-trivia-clean-architecture.git
```

2. Navigate to the project directory:
```bash
cd flutter-number-trivia-clean-architecture
```

3. Install dependencies:
```bash
flutter pub get
```

4. Run the app:
```bash
flutter run
```

## Dependencies

- flutter_bloc: ^8.1.6
- get_it: ^8.0.0
- dartz: ^0.10.1
- equatable: ^2.0.5
- http: ^1.2.2
- connectivity_plus: ^6.0.5
- internet_connection_checker: ^1.0.0+1
- shared_preferences: ^2.2.3

## Project Structure

```
lib/
├── core/
│   ├── error/
│   ├── network/
│   └── usecases/
├── features/
│   └── number_trivia/
│       ├── data/
│       ├── domain/
│       └── presentation/
└── injection_container.dart
```

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Author

- Abdulkhaliq-84
- GitHub: [@Abdulkhaliq-84](https://github.com/Abdulkhaliq-84)
=======
# flutter-number-trivia-clean-architecture
>>>>>>> origin/main
