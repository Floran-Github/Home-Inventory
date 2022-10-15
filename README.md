# Home Inventory Flutter Repository

## Setup

<h3>
Inorder to run this app you need to run django backend on your network and connect it to the app.
</h3>

<h4>
1. Install the backend
</h4>

<h5>
<a href="https://github.com/Floran-Github/Home-Inventory-backend/blob/main/README.md">Follow the step given here</a>
</h5>

<h4>
2. Find your IP address and copy it
</h4>

```bash
    ipconfig
```

<h4>
3. Open lib/constant/constant.dart and replace ip address with yours</h4>

```dart
static String baseURL= "http://192.168.0.202:8000/api/";
//                            | Your Ip addr|
```

<h4>4. Run the program</h4>
