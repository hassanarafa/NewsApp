// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// class Web_View extends StatelessWidget {
//   const Web_View({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: WebViewWidget(
//           controller: WebViewController()
//             ..setJavaScriptMode(JavaScriptMode.unrestricted)
//             ..setBackgroundColor(const Color(0x00000000))
//             ..setNavigationDelegate(
//               NavigationDelegate(
//                 onProgress: (int progress) {
//                   // Update loading bar.
//                 },
//                 onPageStarted: (String url) {},
//                 onPageFinished: (String url) {},
//                 onWebResourceError: (WebResourceError error) {},
//                 onNavigationRequest: (NavigationRequest request) {
//                   if (request.url.startsWith('https://www.youtube.com/')) {
//                     return NavigationDecision.prevent;
//                   }
//                   return NavigationDecision.navigate;
//                 },
//               ),
//             )
//             ..loadRequest(Uri.parse('https://flutter.dev'))),
//     );
//   }
// }
