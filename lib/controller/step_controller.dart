import 'package:get/get.dart';
import 'package:pedometer/pedometer.dart';

class StepController extends GetxController {


@override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    print("-----------------Step Controller Call Hua----------------");
    initPlatformState();
  }
  
  void initPlatformState() {
    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    _pedestrianStatusStream
        .listen(onPedestrianStatusChanged)
        .onError(onPedestrianStatusError);

    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);

    if (!isClosed) return;
  }

  late Stream<StepCount> _stepCountStream;
  late Stream<PedestrianStatus> _pedestrianStatusStream;
  String status = 'stopped', steps = '0';

  int i = 0;
  void onStepCount(StepCount event) {
    print(event);

    steps = event.steps.toString();
    i += 1;
    print("---------------------onStep Call hua--------------------");
    print("---------------------$i--------------------");
    print("---------------------$steps--------------------");
    update();
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    print(event);

    status = event.status;
    update();
  }

  void onPedestrianStatusError(error) {
    print('onPedestrianStatusError: $error');

    status = 'Pedestrian Status not available';

    print(status);
    update();
  }

  void onStepCountError(error) {
    print('onStepCountError: $error');

    steps = 'Step Count not available';
    update();
  }
}
