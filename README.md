
## **NovaWeather**
  
NovaWeather is a modern Flutter application, a port of [Nova Weather SwiftUI](https://github.com/ZackOverend/NovaWeather) that fetches and displays real-time weather data for multiple saved locations. It features a custom UI with gradient backgrounds, blurred card elements, and support for both light and dark themes. The app connects to a [Flask backend](https://github.com/ZackOverend/novaweather-backend) that serves weather data using the OpenWeatherMap API.

## Preview
---
![Image](https://github.com/user-attachments/assets/14a2336d-1790-4e91-8a09-9c0f6959e607)
![Image](https://github.com/user-attachments/assets/8e2f7a02-410a-4c15-ac9e-74980c0aa11e)
---

### **Features**

- Add and save multiple cities
- Tap to view detailed weather data
- Clean, responsive UI with custom theming
- Blurred glass-style weather detail cards
- Light and dark mode support
- Data served via a custom Flask API

---

### **Tech Stack**

#### **Flutter (Frontend)**

- Stateful widget architecture
- shared_preferences for local data storage
- http package for API integration
- Custom ThemeData for light/dark support
#### **Flask (Backend)**

- Python + Flask server with /weather POST endpoint
- OpenWeatherMap API integration
- CORS enabled for cross-platform communication

---
