------------------------------------------
# **Flutter Payments: Siltium Component to make payments**<br> 

## **Descripción**
Plugin para incluir en proyectos mobile de Siltium, permite realizar pagos usando la SDK nativa o de forma manual mostrando un popup para cargar los datos de la tarjeta de credito o debito
<br>
<br>

## **Versión**
**v0.1.0 - Version inicial**
<br>
- Realizar pagos en MercadoPago de forma automatica por el SDK o de forma manual empleando un popup para cargar la información de la tarjeta.
<br>

**v0.2.0**
<br>
- Realizar pagos en MercadoPago por medio de un WebView usando Checkout PRO
- Realizar pagos por medio de TotalCoin.
<br>
<br>

## **Instalación de la Librería (Android y iOS)**
EN FLUTTER:

1) Agregar la libreria en `pubspec.yaml`:
```yaml
dependencies:
  flutter_payments:
    git:
      url: https://github.com/siltium-labs/flutter-payments.git
      ref: development
```
Nota: Si se realizan cambios en la rama de dicho repositorio, es necesario quitar la librería (comentarla), correr el comando `flutter pub get`, volver a agregar la librería (descomentarla) y finalmente volver a correr el comando `flutter pub get`.

PARA ANDROID:

2) Modificar el compileSdkVersion a 33 en `project_name\android\app\build.gradle`:
```gradle
android {
    compileSdkVersion 33
    ...
}
```

3) Modificar el minSdkVersion a 21 en `project_name\android\app\build.gradle`:
```gradle
android {
    defaultConfig {
        minSdkVersion 21
        ...
    }
}
```

## **Como capturar los resultados del Pago**
- Ejemplo:
```gradle
void _showResult(PaymentResultModel paymentResultModel) {
    if (paymentResultModel.errorMessage != null) {
      //print("Pago Error: ${paymentResult.errorMessage}");
    } else if (paymentResultModel.result.toLowerCase() == "canceled") {
      //print("Pago Cancelado");
    } else if (paymentResultModel.status == "rejected") {
      //print("Pago Rechazado");
    } else if (paymentResultModel.status == "approved") {
      //print("Pago Aprobado");
    } else if (paymentResultModel.status == "in_process") {
      //print("Pago pendiente");
    }
  }
```
