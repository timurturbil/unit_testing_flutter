import 'package:testing/core/models/product.dart';
import 'package:testing/core/services/api.dart';
import 'api_test.mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';

@GenerateMocks([http.Client])
void main() {
  group('FetchProducts', () {
    test('return Product if the http call completes successfully', () async {
      final client = MockClient();
      // Use Mockito to return a successful response when it calls the
      // provided http.Client.
      when(client.get(Uri.https('unit-test-medium-default-rtdb.firebaseio.com',
              'products/0.json')))
          .thenAnswer((_) async => http.Response(
              '{"id":1, "imageUrl":"https://assets.mmsrg.com/isr/166325/c1/-/ASSET_MMS_79293006/fee_325_225_png/APPLE-Airpods-Pro-Kablosuz-Kulak-%C4%B0%C3%A7i-Kulakl%C4%B1k-Beyaz","name":"AirPods Pro","price":249}',
              200));
      expect(await API().getProducts(client), isA<Product>());
    });
    test('throws an exception if the http call fails', () {
      final client = MockClient();
      // Use Mockito to return an unsuccessful response when it calls the
      // provided http.Client.
      when(client.get(Uri.https('unit-test-medium-default-rtdb.firebaseio.com',
              'products/0.json')))
          .thenAnswer((_) async => http.Response('not found', 404));
      expect(API().getProducts(client), throwsException);
    });
  });
}
