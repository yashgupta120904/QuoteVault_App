
Below is a **FULL, PROFESSIONAL `README.md` FILE** for **QuoteVault** that you can **copy-paste directly** into GitHub.
It includes:

* App overview
* Features
* Architecture & AI help summary
* Tech stack
* Installation steps
* APK download section
* Screenshots placeholder
* Environment setup

I’ve written it in a **clean, real-world open-source style** (not overhyped).

---

# 📜 QuoteVault

**QuoteVault** is a Flutter mobile application that delivers a carefully curated **Quote of the Day**, allows users to explore inspirational quotes, save favorites, and receive daily notifications — all powered by a backend-driven, automated architecture.

---

## ✨ Features

* 📅 **Quote of the Day** (same quote across app, notifications, and widget)
* 🔍 Explore and browse quotes
* ❤️ Save & manage favorite quotes
* ⏰ Daily quote notifications (user-defined time)
* 🧩 Home screen widget support
* 🌙 Dark / Light mode
* 🔐 Supabase authentication
* ☁️ Fully backend-driven daily quote logic

---

## 🧠 How AI Helped Shape the Architecture

AI was used as a **design assistant**, not just a coding tool.

It helped:

* Break the app idea into **frontend, backend, and automation layers**
* Decide **where logic should live** instead of putting everything in the app
* Centralize time-based logic on the server
* Ensure the same quote appears in the app, notifications, and widget
* Design a clean, scalable data flow before implementation

> **AI helped me think in data flows instead of screens, leading to a more reliable and maintainable architecture.**

---

## 🏗️ Architecture Overview

**Frontend (Flutter)**

* Displays data
* Handles user interactions
* Never decides the daily quote

**Backend (Supabase)**

* Stores quotes, favorites, and user settings
* Acts as the single source of truth

**Automation**

* Cloudflare Cron triggers scheduled tasks
* Supabase Edge Functions handle:

  * Daily quote selection
  * Notification scheduling

**Notifications**

* Firebase Cloud Messaging (FCM)

---

## 🔄 Quote of the Day Flow

1. Cloudflare Cron triggers a scheduled job
2. Supabase Edge Function selects a random unused quote
3. Quote is marked as `is_daily = true` in the database
4. Flutter app fetches the daily quote
5. Same quote is used for:

   * App UI
   * Push notification
   * Home screen widget

---

## 🛠️ Tech Stack

### Frontend

* Flutter
* Provider (state management)
* SharedPreferences
* Home Widget

### Backend

* Supabase (Auth + Database)
* Supabase Edge Functions

### Automation

* Cloudflare Cron Triggers

### Notifications

* Firebase Cloud Messaging (FCM)

---

## 📦 Installation (Local Setup)

### 1️⃣ Clone the Repository

```bash
git clone https://github.com/your-username/quotevault.git
cd quotevault
```

### 2️⃣ Install Dependencies

```bash
flutter pub get
```

### 3️⃣ Configure Environment

Create a `.env` file and add:

```env
SUPABASE_URL=your_supabase_url
SUPABASE_ANON_KEY=your_supabase_anon_key
```

### 4️⃣ Run the App

```bash
flutter run

---

## 🖼️ Screenshots

> *(Add screenshots here)*

```md
```

<img width="720" height="800" alt="image" src="https://github.com/user-attachments/assets/68aa396f-51f0-4362-a3a1-b84a5e247f6d" />

<img width="720" height="800" alt="image" src="https://github.com/user-attachments/assets/466a22e9-8ff0-4b72-973e-bc3ceb37ec2c" />

<img width="720" height="800" alt="image" src="https://github.com/user-attachments/assets/fa720729-1a0a-4d61-a586-3cd6d725d2be" />

<img width="720" height="800" alt="image" src="https://github.com/user-attachments/assets/4734affd-20fa-48d7-93cc-9b5f54226e64" />

<img width="720" height="800" alt="image" src="https://github.com/user-attachments/assets/75d12df7-3db3-45de-aed4-f1a803565fed" />





---

## 🔐 Authentication & Security

* Secure email-based authentication via Supabase
* No sensitive keys stored in the client
* Backend handles all critical logic

---

## 🚀 Future Improvements

* Quote categories & tags
* Search functionality
* Offline-first support
* Multiple widgets
* Analytics dashboard

---

## 🤝 Contributing

Contributions are welcome!
Feel free to open issues or submit pull requests.

---

## 📄 License

This project is licensed under the **MIT License**.

---

## 🙌 Acknowledgements

* Flutter & Supabase communities
* Open-source tools
* AI tools that helped refine architecture and data flow

---

## 👤 Author

**Yash Gupta**
Flutter Developer | Backend Enthusiast

---

### ⭐ If you like this project, don’t forget to star the repo!




Just tell me 😄

