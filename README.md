
## **NovaWeather**
<img src="https://github.com/user-attachments/assets/264b2810-3288-495a-94c8-8fde0f003b82" width="600"/>&nbsp;&nbsp;&nbsp;


NovaWeather is a modern Flutter application, a port of [Nova Weather SwiftUI](https://github.com/ZackOverend/NovaWeather) that fetches and displays real-time weather data for multiple saved locations. It features a custom UI with gradient backgrounds, blurred card elements, and support for both light and dark themes. The app connects to a [Flask backend](https://github.com/ZackOverend/novaweather-backend) that serves weather data using the OpenWeatherMap API.

## Preview
---

<p float="left">
  
  <img src="https://github.com/user-attachments/assets/f72f77c1-8b0c-472c-8e5b-9482f79e5dff" width="300"/>&nbsp;&nbsp;&nbsp;
  <img src="https://github.com/user-attachments/assets/98315585-607d-4178-b4e6-f27929450cff" width="300"/>
</p>

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
