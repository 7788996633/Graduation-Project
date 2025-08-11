// Please see this file for the latest firebase-js-sdk version:
// https://github.com/firebase/flutterfire/blob/main/packages/firebase_core/firebase_core_web/lib/src/firebase_sdk_version.dart
importScripts("https://www.gstatic.com/firebasejs/10.7.0/firebase-app-compat.js");
importScripts("https://www.gstatic.com/firebasejs/10.7.0/firebase-messaging-compat.js");

firebase.initializeApp({
       apiKey: 'AIzaSyDA8w2eKNM_7NHTxKEPonqXhdjRDl5YYUY',
       appId: '1:34322017082:web:a7dc48a6c146b865397e03',
       messagingSenderId: '34322017082',
       projectId: 'lawcompanyapp',
       authDomain: 'lawcompanyapp.firebaseapp.com',
       storageBucket: 'lawcompanyapp.firebasestorage.app',
});

const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage(async (payload) => {
  console.log('Received background message:', payload);

  const notificationTitle = payload.notification.title;
  const notificationOptions = {
    body: payload.notification.body,
//    icon: '/icons/Icon-192.png',
//    badge: '/icons/Icon-192.png',
    data: payload.data,
    click_action: payload.notification.click_action,
  };

  self.registration.showNotification(notificationTitle, notificationOptions);
});