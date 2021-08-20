import 'package:connectivity/connectivity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ideas/common/device/network_info.dart';
import 'package:mocktail/mocktail.dart';

class MockConnectivity extends Mock implements Connectivity {}

void main() {
  late MockConnectivity connectivity;
  late NetworkInfo networkInfo;

  setUp(() {
    connectivity = MockConnectivity();
    networkInfo = NetworkInfo(connectivity);
  });

  test('should return true if the device is connected', () async {
    //Arrange
    when(() => connectivity.checkConnectivity()).thenAnswer((_) async => ConnectivityResult.wifi);
    //Act
    var result = await networkInfo.isConnected;
    //Assert
    expect(result, true);
  });

  test('should return false if the device is disconnected', () async {
    //Arrange
    when(() => connectivity.checkConnectivity()).thenAnswer((_) async => ConnectivityResult.none);
    //Act
    var result = await networkInfo.isConnected;
    //Assert
    expect(result, false);
  });
}
