# BMI Calculator - Clean Architecture

## 📁 Project Structure

```
lib/
├── main.dart                     # App entry point
├── constants/
│   └── app_constants.dart        # Colors, text styles, and UI constants
├── models/
│   ├── bmi_data.dart            # User input data model
│   └── bmi_result.dart          # BMI calculation result model
├── services/
│   └── bmi_calculator_service.dart # Business logic for BMI calculations
├── widgets/
│   ├── gradient_button.dart     # Reusable gradient button
│   ├── custom_text_field.dart   # Reusable styled text input
│   └── info_card.dart           # Reusable information card
└── screens/
    ├── home_screen.dart         # Main input screen
    └── result_screen.dart       # Results display screen
```

## 🏗️ Architecture Layers

### 1. **Models** (Data Layer)

- `BmiData`: Represents user input (gender, height, weight, age)
- `BmiResult`: Represents calculation results with category and advice
- Pure data classes with no business logic

### 2. **Services** (Business Logic Layer)

- `BmiCalculatorService`: Contains all BMI calculation logic
- Determines BMI category, color coding, and health advice
- Stateless service with pure functions

### 3. **Constants** (Configuration Layer)

- `AppColors`: Centralized color definitions
- `AppTextStyles`: Consistent text styling
- Makes design changes easy and maintainable

### 4. **Widgets** (Reusable UI Components)

- `GradientButton`: Styled button with gradient background
- `CustomTextField`: Styled text input with validation
- `InfoCard`: Information display card
- Promotes code reuse and consistency

### 5. **Screens** (Presentation Layer)

- `HomeScreen`: User input interface
- `ResultScreen`: Results display interface
- Contains only UI logic and state management

## ✨ Benefits of This Architecture

### **Separation of Concerns**

- Each layer has a single responsibility
- Business logic separated from UI
- Easy to test individual components

### **Maintainability**

- Changes in one layer don't affect others
- Easy to modify styling, logic, or UI independently
- Clear code organization

### **Reusability**

- Widgets can be reused across screens
- Services can be used by multiple UI components
- Constants ensure consistency

### **Testability**

- Business logic can be tested without UI
- Models are simple data structures
- Services are pure functions

### **Scalability**

- Easy to add new features
- Simple to extend existing functionality
- Clear structure for team development

## 🔄 Data Flow

1. **User Input** → `HomeScreen` collects data
2. **Validation** → Form validation in UI layer
3. **Model Creation** → `BmiData` object created
4. **Business Logic** → `BmiCalculatorService` processes data
5. **Result** → `BmiResult` object returned
6. **Display** → `ResultScreen` shows formatted results

## 🎨 UI Consistency

- **Colors**: Centralized in `AppColors`
- **Typography**: Standardized in `AppTextStyles`
- **Components**: Reusable widgets for common elements
- **Animations**: Consistent throughout the app

## 🚀 Usage

```dart
// Example: Using the service
final bmiData = BmiData(
  isMale: true,
  height: 175.0,
  weight: 70.0,
  age: 25,
);

final result = BmiCalculatorService.calculateBmi(bmiData);
print('BMI: ${result.value}');
print('Category: ${result.categoryText}');
```

This clean architecture ensures your BMI calculator is:

- **Professional** and well-organized
- **Easy to maintain** and extend
- **Consistent** in design and behavior
- **Scalable** for future features
