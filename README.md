# 🛍️ Shopfy

Shopfy is a modern e-commerce mobile application built with **Flutter**, powered by **Firebase** for backend services, and structured using the **MVC (Model-View-Controller)** architectural pattern. It allows users to browse products, manage carts, and securely place orders.

---

## 🚀 Features

- 📱 Beautiful & responsive UI with Flutter
- 🔥 Firebase Authentication (Email & Password)
- ☁️ Firebase Firestore for real-time product & order management
- 🛒 Product listing and detailed view
- 🛍️ Add to Cart / Remove from Cart
- 🧾 Order placement and order history
- 🔐 Secure login and logout
- 📂 MVC folder structure for scalability and clean code
- 🌙 Light/Dark Theme Support (optional)

---

## 📸 Screenshots

| Login | Product List | Cart | Order History |
|-------|--------------|------|----------------|
| ![](screenshots/login.png) | ![](screenshots/products.png) | ![](screenshots/cart.png) | ![](screenshots/orders.png) |

---

## 🏗️ Architecture

The app follows the **MVC (Model-View-Controller)** pattern:

```
lib/
├── controllers/      # Business logic (e.g., Auth, Cart, Products)
├── models/           # Data models (e.g., Product, User, Order)
├── views/            # UI widgets and screens
├── services/         # Firebase services
├── utils/            # Theme, constants, helpers
└── main.dart         # Entry point
```

---

## 🔧 Tech Stack

- **Flutter** (UI Framework)
- **Firebase Authentication** (Login/Signup)
- **Cloud Firestore** (Database)
- **Firebase Storage** (Product images)
- **MVC Architecture**

---

## 🛠️ Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/shopfy.git
   cd shopfy
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Set up Firebase**
   - Create a Firebase project in [Firebase Console](https://console.firebase.google.com/)
   - Add an Android/iOS app to your Firebase project
   - Download `google-services.json` (for Android) or `GoogleService-Info.plist` (for iOS)
   - Place it in the appropriate directory (`android/app` or `ios/Runner`)
   - Enable **Authentication** and **Firestore Database**

4. **Run the app**
   ```bash
   flutter run
   ```

---

## 📁 Firebase Setup Tips

- 🔐 Enable **Email & Password** in Firebase Authentication
- 📦 Create collections in Firestore:
  - `products`
  - `orders`
  - `users`

---

## 🤝 Contributing

Contributions are welcome! Feel free to submit a pull request or open an issue.

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 💬 Contact

Developed by **[Your Name]**  
📧 Email: your.email@example.com  
🌐 Portfolio: [yourwebsite.com](https://yourwebsite.com)

---

## ⭐️ Give a Star

If you liked this project, consider giving it a ⭐️ on GitHub!
