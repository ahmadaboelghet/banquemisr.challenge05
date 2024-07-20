# MovieApp

MovieApp is an iOS application that fetches and displays a list of movies from the Movie Database API. It implements MVVM architecture with Repository Pattern and includes caching using UserDefaults, as well as error handling.

## Features

- Fetches movies from the Movie Database API
- Displays movies in a list view
- Caching of fetched movies using UserDefaults
- Error handling for network requests
- MVVM architecture with Repository Pattern
- Unit tests for APIService and MovieViewModel

## Requirements

- Xcode 12.0+
- Swift 5.0+
- iOS 13.0+

## Installation

1. Clone the repository:

```sh
git clone https://github.com/yourusername/MovieApp.git
```

2. Navigate to the project directory:

```sh
cd MovieApp
```

3. Open the project in Xcode:

```sh
open MovieApp.xcodeproj
```

4. Build and run the project on the simulator or a device.

## Architecture

The project follows the MVVM (Model-View-ViewModel) architecture with a Repository pattern to handle data fetching and caching.

- **Domain Layer**: Contains use cases and domain models.
- **Data Layer**: Contains repository implementations and API service.
- **Presentation Layer**: Contains view models and views.

## Caching and Error Handling

The `APIService` class includes methods for caching movie data using `UserDefaults` and handles various types of network errors. The `MovieViewModel` class provides user feedback based on the success or failure of data fetching operations.

## Unit Tests

Unit tests are included for the `APIService` and `MovieViewModel` classes. They can be found in the `MovieAppTests` directory.

### Running Tests

1. Open the project in Xcode.
2. Select the `MovieAppTests` target.
3. Press `Command + U` to run all tests.

## Development Workflow

1. Create a new branch for development:

```sh
git checkout -b dev
```

2. Make your changes and commit them:

```sh
git add .
git commit -m "final task commit"
```

3. Push the changes to the dev branch:

```sh
git push origin dev
```

4. Create a pull request on GitHub to merge the dev branch into the main branch.

5. Once the pull request is approved and merged, delete the dev branch:

```sh
git checkout main
git pull origin main
git branch -d dev
git push origin --delete dev
```
