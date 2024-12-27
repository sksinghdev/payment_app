# Clean Architecture for a Login App in Flutter

This document outlines the Clean Architecture structure for a Flutter-based login application, describing the responsibilities and organization of various layers and components.

Project Structure

├── core/
│   ├── api_service.dart
│   ├── connection_helper.dart
│   ├── db_key.dart
│   ├── feature_injection.dart
│   ├── function.dart
│   ├── features/
│        login
│        ├── data/
│        │   ├── datasources/
│        │   │   ├── Local
│        │   │       ├── login_datsource_provider.dart
│        │   │       ├── login_datsource_service.dart
│        │   │
│        │   │   ├── remote
│        │   │       ├── login_datsource.dart
│        │   ├── entities/
│        │   │   ├── user_domain_model.dart
│        │   ├── mapper/
│        │       ├── login_domain_mapper.dart
│        │   ├── repositories/
│        │       ├── login_repository_impl.dart
│        ├── domain/
│        │   ├── repositories/
│        │   │   ├── login_interface_repository.dart
│        │   │   ├── login_repository.dart
│        │   ├── usecases/
│        │       ├── login_use_case.dart
│        ├── presentation/
│        │   ├── bloc/
│        │   │   ├── login_cubit.dart
│        │   │   ├── login_state.dart
│        │   ├── entities/
│        │       ├── hive
│        │           ├── login_hive_types.dart
│        │       ├── login_error.dart
│        │       ├── login_user_model.dart
│        │       ├── login_user_model.g.dart
│        │   ├── widgets/
│        │       ├── user_text_field.dart
│
├── main.dart

# Core Layer

The core folder contains:

api_service.dart: Handles API calls and networking.

connection_helper.dart: Provides utilities to check internet connectivity.

db_key.dart: Defines keys used for local database operations.

feature_injection.dart: Manages dependency injection for features.

function.dart: Includes shared utility functions.

# Features Layer

The features/login folder is divided into three layers: data, domain, and presentation.

# Data Layer

The data layer handles data retrieval and storage.

datasources/:

Local: Contains login_datsource_provider.dart and login_datsource_service.dart for local data operations.

Remote: Contains login_datsource.dart for remote API interactions.

entities/: Includes user_domain_model.dart, which defines data structures used in the domain layer.

mapper/: Contains login_domain_mapper.dart to map data models to domain entities.

repositories/: Implements data repositories, e.g., login_repository_impl.dart.

# Domain Layer

The domain layer is the core business logic layer.

repositories/:

login_interface_repository.dart: Defines repository interfaces.

login_repository.dart: Specifies domain logic for login.

usecases/: Implements business use cases, such as login_use_case.dart.

# Presentation Layer

The presentation layer manages the UI and state management.

bloc/:

login_cubit.dart: Handles the state and logic for login.

login_state.dart: Defines various states (e.g., loading, success, failure).

entities/:

hive/: Contains login_hive_types.dart for local data types.

login_error.dart: Defines error handling.

login_user_model.dart and login_user_model.g.dart: Represent user data models for UI.

widgets/: Includes reusable UI components like user_text_field.dart.

Main File

The main.dart file serves as the entry point for the application, initializing the app and setting up dependency injection.







        
