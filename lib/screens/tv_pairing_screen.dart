import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:smart_tv_app/config/tv_theme.dart';
import 'package:smart_tv_app/providers/tv_provider.dart';

class TvPairingScreen extends StatelessWidget {
  const TvPairingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tvProvider = context.watch<TvProvider>();

    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Panel de Instrucciones
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(left: 80.0, right: 40.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Vincular TV',
                      style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        color: TvTheme.primary,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      '1. Abre la app VitalHabit en tu teléfono móvil.\n'
                      '2. Ve a Configuración > Dispositivos Vinculados.\n'
                      '3. Escanea el código QR que aparece en pantalla.',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 48),
                    // Código alternativo por si falla el QR
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      decoration: BoxDecoration(
                        color: TvTheme.surfaceElevated,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.pin_outlined, color: TvTheme.primaryFocused, size: 32),
                            const SizedBox(width: 16),
                            Text(
                              'Código manual: ${tvProvider.pairingCode}',
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // Panel del QR
            Expanded(
              flex: 1,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(32),
                    boxShadow: [
                      BoxShadow(
                        color: TvTheme.primary.withValues(alpha: 0.2),
                        blurRadius: 30,
                        spreadRadius: 10,
                      )
                    ]
                  ),
                  child: QrImageView(
                    data: 'VITALHABIT:TV:${tvProvider.pairingCode}',
                    version: QrVersions.auto,
                    size: 350.0,
                    eyeStyle: const QrEyeStyle(
                      eyeShape: QrEyeShape.circle,
                      color: Colors.black87,
                    ),
                    dataModuleStyle: const QrDataModuleStyle(
                      dataModuleShape: QrDataModuleShape.circle,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
