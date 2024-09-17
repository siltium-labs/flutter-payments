## v0.1.0 - Version inicial
Initial release:
- Realizar Pagos en MercadoPago de forma automatica por el SDK nativo de Android y ¡OS
- Realizar Pagos en MercadoPago de forma manual empleando un popup para cargar la información de la tarjeta haciendo uso de las API de Mercado Pago
- Creación de PreferenceID de MercadoPago

## v0.2.0
- SDK nativo de ¡OS deprecado el 26/08/2023, SDK nativo de Android funcionando correctamente
- Realizar Pagos en MercadoPago por medio de un WebView usando Checkout PRO
- Realizar Pagos en TotalCoin por medio de un WebView
- Creación y actualización de PreferenceID de MercadoPago

## v0.3.0
- Realizar Pagos en MacroClick por medio de un WebView
- Se implemnto con sobre carga poder usar el WebView sin app bar, con app bar y en popup
- El modelo "PaymentResultModel" se le agrego los campos "link" y "downloadLink"
  - "link": almacenaria el link donde se puede visualizar ya sea un comprobante por ejemplo
  - "downloadLink": almacenaria el link de descarga del comprobante
