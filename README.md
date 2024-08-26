# Hacker News App

A modern, Flutter-based Hacker News client that uses the official Hacker News API to fetch and display top stories and their comments. This app demonstrates the implementation of the BLoC (Business Logic Component) pattern for state management in Flutter.

## Features

- Fetch and display top stories from Hacker News
- View comments for each story
- Infinite scrolling for stories and nested comments
- Error handling and loading states
- Clean architecture using the BLoC pattern

## Architecture

This app follows the BLoC (Business Logic Component) pattern, which separates the presentation layer from the business logic. The main components of the architecture are:

1. **Presentation Layer**: UI components (screens and widgets)
2. **Business Logic Layer**: BLoCs (Business Logic Components)
3. **Data Layer**: API services

### Folder Structure

![Folder Structure](https://github.com/achiit/siyatechnews/blob/main/assets/appimages/Screenshot%202024-08-27%20at%204.09.10%20AM.png)


## Implementation Details

### BLoC Pattern

The app uses two main BLoCs:

1. **HackerNewsBloc**: Manages the state of the top stories list.
2. **CommentsBloc**: Manages the state of comments for a specific story.

Each BLoC consists of three main parts:

- **Events**: Represent user actions or system events.
- **States**: Represent the current state of the app or a specific component.
- **BLoC**: Contains the business logic to transform events into states.

### Fetching Data

The app uses the `HackerNewsService` to fetch data from the Hacker News API:

1. Fetch top story IDs from `https://hacker-news.firebaseio.com/v0/topstories.json`
2. For each story ID, fetch the story details from `https://hacker-news.firebaseio.com/v0/item/{id}.json`

### Infinite Scrolling

The app implements infinite scrolling for both the story list and nested comments:

1. Initially, a fixed number of stories or comments are loaded.
2. When the user scrolls near the end of the list, a new event is dispatched to the respective BLoC to load more items.
3. The BLoC fetches the next batch of items and updates the state.
4. The UI reacts to the state change and displays the new items.

### Error Handling

Both BLoCs include error states to handle API failures or other exceptions. When an error occurs, the UI displays an error message to the user.

### Demo

![Demo Video](https://github.com/achiit/siyatechnews/blob/main/assets/appimages/demo.gif)

## Getting Started

To run this project:

1. Ensure you have Flutter installed on your machine.
2. Clone this repository: `git clone https://github.com/achiit/siyatechnews.git`
3. Navigate to the project directory: `cd hacker-news-app`
4. Get the dependencies: `flutter pub get`
5. Run the app: `flutter run`

## Dependencies

- `flutter_bloc`: For implementing the BLoC pattern
- `http`: For making API requests
- `equatable`: For comparing objects in Dart

Add these dependencies to your `pubspec.yaml` file:

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_bloc: ^8.0.0
  http: ^0.13.3
  equatable: ^2.0.3
```

- Made with ❤️ by Achintya Singh
- Time taken 2hours...
