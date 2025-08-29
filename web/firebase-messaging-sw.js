// Please see this file for the latest firebase-js-sdk version:
// https://github.com/firebase/flutterfire/blob/main/packages/firebase_core/firebase_core_web/lib/src/firebase_sdk_version.dart
importScripts("https://www.gstatic.com/firebasejs/10.7.0/firebase-app-compat.js");
importScripts("https://www.gstatic.com/firebasejs/10.7.0/firebase-messaging-compat.js");

firebase.initializeApp({
  apiKey: 'AIzaSyDA8w2eKNM_7NHTxKEPonqXhdjRDl5YYUY',
     appId: '1:34322017082:web:8e204e1444885ed8397e03',
     messagingSenderId: '34322017082',
     projectId: 'lawcompanyapp',
     authDomain: 'lawcompanyapp.firebaseapp.com',
     storageBucket: 'lawcompanyapp.firebasestorage.app',
     measurementId: 'G-DCZYKB2BDJ',
});

const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((message) => {
  console.log("onBackgroundMessage", message);
});