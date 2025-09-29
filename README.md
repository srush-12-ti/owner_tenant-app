# Owner & Tenant App  

A Flutter-based mobile application designed to simplify **apartment and rental management** for owners and tenants. The app allows tenants to view and pay bills securely, while owners can track payments, register tenants, and send reminders.  



##  Features  

###  For Tenants  
-  Secure login with apartment name & credentials  
-  View bills (Rent, Water, Electricity, etc.)  
-  Receive reminders and messages from the owner  

### For Owners  
-  Register tenants with apartment details (floor, flat number, BHK)  
-  Track tenant payment status (Paid / Pending / Overdue)  
-  Send reminders to unpaid tenants  
-  View individual bills per tenant (rent, water, electricity)  
  



##  Tech Stack  

- **Framework**: [Flutter](https://flutter.dev/)  
- **Language**: Dart  
- **Database/Backend**: MySQL   
 


##  Project Structure  
├── main.dart # App entry point
├── auth/ # Login & registration
├── owner/ # Owner dashboard, tenant management
├── tenant/ # Tenant dashboard, bill payments
├── services/ # API & database services
├── widgets/ # Reusable UI components
└── utils/ # Constants, helpers


---

## 🚀 Getting Started  

### Prerequisites  
Ensure you have the following installed:  
- [Flutter SDK](https://docs.flutter.dev/get-started/install)  
- [Dart SDK](https://dart.dev/get-dart) (comes with Flutter)  
- Android Studio / VS Code  

### Installation  

```bash
# Clone the repository
git clone https://github.com/yourusername/owner_tenant_app.git

# Navigate to project folder
cd owner_tenant_app

# Install dependencies
flutter pub get

# Run the app
flutter run
      

