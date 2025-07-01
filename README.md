# Prism Quiz

**A Simple Trivia Quiz App**

## How to Run

### Prerequisites

-   **Flutter SDK** (version 3.0 or above)
-   Android/iOS Emulator or Physical Device

### Installation

1. **Clone the Repository**

    ```bash
    git clone https://github.com/hussainkazarani/prism.git
    cd prism
    ```

2. **Install Dependencies**

    ```bash
    flutter pub get
    ```

3. **Run the App**
    ```bash
    flutter run
    ```

## Overview

Prism Quiz is a trivia app that lets you test your knowledge across different categories. Pick a category, answer questions, and see how well you did. Uses the Open Trivia Database API for questions.

## Features

-   **Category Selection**: Choose from various quiz categories
-   **Timed Questions**: 10-second timer for each question
-   **Score Tracking**: See your results at the end
-   **Clean UI**: Simple navigation with bottom nav bar

## How It Works

1. **Splash Screen**: Video intro that leads to the main app
2. **Home/Categories**: Switch between home and category selection using bottom nav
3. **Quiz Flow**: Pick a category → Answer 10 questions → See results
4. **Question Timer**: Auto-checks answers when time runs out
5. **Results**: Shows final score and option to play again

The app fetches categories from the API, gets random questions for selected categories, and tracks your answers to show a final score.
