# SendMoney iOS Application

This is a SendMoney iOS application built using **MVVM** architecture and following **Clean Architecture** principles. The app is designed to handle dynamic forms, user input validation, localization, and data management. 

### Key Features:
- **Login Screen**: 
  - Email and password validation with inline error messages.
  - Only valid email (`test@gmail.com`) and password (`Test@12345`) are accepted.
- **Dynamic Form Screen**:
  - The form loads data dynamically from a JSON file.
  - The form is built based on the services and providers selected by the user.
  - Validation logic is applied on the form fields based on the JSON data.
  - The form supports **Arabic** localization. When the user switches to Arabic, the form's text is displayed in Arabic.
- **Data Submission**:
  - Once the user submits the form, the data is saved using **Redux**.
- **List Screen**:
  - A table view displaying the saved data.
  - Each table view cell opens a details screen when tapped.
- **Detail Screen**:
  - The details screen displays the data in a **formatted JSON**.
  
### Architecture:
The app follows **MVVM (Model-View-ViewModel)** architecture, which provides a clear separation of concerns:
- **Model**: Represents the data structures and business logic.
- **View**: Handles UI elements (e.g., views, view controllers).
- **ViewModel**: Provides business logic, converting the model data into a format that the view can use.

### Languages:
- The app supports **English** and **Arabic** languages. The form dynamically adjusts based on the selected language, with text switching to Arabic when selected.

### Screens:
1. **Login Screen**:
   - Input fields for email and password.
   - Displays error messages for invalid inputs.
   - On successful login, the app navigates to the dynamic form screen.

2. **Dynamic Form Screen**:
   - Displays a form loaded from a JSON file.
   - The form adapts based on the selected service and provider.
   - Validation messages are displayed inline for incorrect inputs.
   - Supports Arabic localization for text fields and placeholders.

3. **List Screen**:
   - Displays a list of saved forms in a table view.
   - Each cell represents a saved form.
   - Tapping a cell navigates to the details screen.

4. **Details Screen**:
   - Displays the details of the selected form in a **formatted JSON**.

### Libraries and Frameworks:
- **Swift** (language)
- **MVVM** (architecture pattern)
- **Clean Architecture** (for code structure and separation of concerns)
- **Redux** (state management)
- **JSON** (data loading and parsing)

### How to Run:
1. Clone the repository to your local machine.
   ```bash
   git clone https://github.com/your-username/SendMoney-iOS.git
