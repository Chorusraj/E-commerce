# 🛒 Flutter E-Commerce App

A modern **Flutter E-Commerce application** built using **Clean Architecture** and **BLoC state management**.  
This project demonstrates **scalable Flutter app development best practices** and is designed as a **portfolio project for fresher Flutter developers**.

---

## ✨ Features

- Product listing using REST API (Fake Store API)  
- Product details page with image, title, price, and description  
- Add to cart functionality  
- Increase / decrease product quantity in cart  
- Remove item from cart  
- Cart badge with total item count  
- Total price calculation  
- Cart persistence using Hive (local storage)  
- Empty cart state with user-friendly UI  
- Error handling for API & images  
- Clean and responsive UI  

---

## 🧱 Architecture

The project follows **Clean Architecture** principles:

### Layers

- **Data Layer** → Handles API calls and local storage (Hive)  
- **Domain Layer** → Contains entities and business logic  
- **Presentation Layer** → UI screens and BLoC state management  

---

## 🔧 Tech Stack

- Flutter & Dart  
- BLoC (flutter_bloc)  
- REST API (Fake Store API)  
- Hive (local persistence)  
- Clean Architecture & Monorepo structure  
- Git & GitHub  

---

## 🌐 API Used

- [Fake Store API](https://fakestoreapi.com/products)  

---

## 🚀 Getting Started

### 1️⃣ Clone the repository
```bash
git clone https://github.com/Chorusraj/E-commerce.git
cd E-commerce
```

### 2️⃣ Install dependencies
```bash
flutter pub get
```

### 3️⃣ Generate Hive adapters
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### 4️⃣ Run the app
```bash
flutter run
```

---

## 📸 Screenshots

### Product List
![Product List](screenshots/product_list.png)

### Product Details
![Product Details](screenshots/product_details.png)

### Cart Page
![Cart Page](screenshots/cart_page.png)

### Cart Empty Page
![Cart Empty Page](screenshots/cart_empty_page.png)

> Make sure your screenshots are placed in the `screenshots/` folder at the repo root.

---

## 🧪 Running Unit Tests

This app includes **unit tests for CartBloc and ProductBloc**.

### Run all tests
```bash
flutter test
```

### Tests cover:
- Adding/removing items from cart  
- Increasing/decreasing item quantity  
- Clearing cart  
- Fetching products success & failure  

> Unit tests run in Dart’s test environment, so no physical device or emulator is required.

---

## 📁 Project Structure

```
lib/
├─ core/           # Common classes, usecases, and utilities
├─ features/
│   ├─ products/
│   │   ├─ data/       # API & repositories
│   │   ├─ domain/     # Entities & usecases
│   │   └─ presentation/ # UI & Bloc
│   ├─ cart/
│       ├─ domain/
│       └─ presentation/
└─ main.dart

test/
├─ cart_bloc_test.dart
├─ product_bloc_test.dart

screenshots/
├─ product_list.png
├─ product_details.png
├─ cart_page.png
├─ cart_empty_page.png
```

---

## 🔮 Future Enhancements

- User authentication using Firebase  
- Order history & tracking  
- Product categories & search  
- Payment gateway integration  
- Push notifications for deals or cart reminders  

---

## 📝 Notes

- Hive adapters (`*.g.dart`) are included  
- Screenshots are stored in the `screenshots/` folder  
- Unit tests are in the `test/` folder  
- Can be extended for full-scale e-commerce functionality  

---

## 🔗 References

- [Flutter](https://flutter.dev/)  
- [Bloc Package](https://pub.dev/packages/flutter_bloc)  
- [Hive Package](https://pub.dev/packages/hive)  
- [Fake Store API](https://fakestoreapi.com/)  

---

## 👨‍💻 Author

**Chorus Rajbanshi** – Flutter Developer (Fresher)  

- GitHub: [https://github.com/Chorusraj](https://github.com/Chorusraj)  
- LinkedIn: [https://www.linkedin.com/in/chorus-rajbanshi-32ba7a330/](https://www.linkedin.com/in/chorus-rajbanshi-32ba7a330/)
