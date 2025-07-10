// web/firebase-messaging-sw.js
importScripts('https://www.gstatic.com/firebasejs/10.12.0/firebase-app-compat.js');
importScripts('https://www.gstatic.com/firebasejs/10.12.0/firebase-messaging-compat.js');

firebase.initializeApp({
  apiKey: "AIzaSyB8IGTzvDtXMr4UO1K0Bj48vJybIaAj4Ok",
  authDomain: "notification-test-20bf1.firebaseapp.com",
  projectId: "notification-test-20bf1",
 storageBucket: "notification-test-20bf1.firebasestorage.app",
 messagingSenderId: "459786430343",
 appId: "1:459786430343:web:6951b56e0e8892b5ec9522",
});

const messaging = firebase.messaging();
