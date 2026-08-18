import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_tv_app/config/tv_theme.dart';
import 'package:smart_tv_app/providers/tv_provider.dart';
import 'package:smart_tv_app/widgets/stat_card.dart';

class TvDashboardScreen extends StatelessWidget {
  const TvDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tvProvider = context.watch<TvProvider>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            const Icon(Icons.tv, color: TvTheme.primary, size: 32),
            const SizedBox(width: 16),
            Text(
              'VitalHabit TV Dashboard',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 32.0),
            child: Row(
              children: [
                const Icon(Icons.circle, color: TvTheme.success, size: 16),
                const SizedBox(width: 8),
                Text('Conectado', style: Theme.of(context).textTheme.bodyLarge),
              ],
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(48.0),
        child: Row(
          children: [
            // Panel Lateral Izquierdo (Resumen general)
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '¡Buen trabajo!',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Mantener tus hábitos constantes te acerca a tus metas.',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: TvTheme.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 48),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: TvTheme.surfaceElevated,
                      foregroundColor: TvTheme.textPrimary,
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    icon: const Icon(Icons.logout, size: 28),
                    label: const Text('Desvincular Pantalla', style: TextStyle(fontSize: 20)),
                    onPressed: () {
                      context.read<TvProvider>().simulateUnpairing();
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(width: 48),
            // Panel Derecho (Grilla de Estadísticas)
            Expanded(
              flex: 2,
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 32,
                mainAxisSpacing: 32,
                childAspectRatio: 1.2,
                children: [
                  StatCard(
                    title: 'Días de Racha',
                    value: '${tvProvider.streakDays}',
                    icon: Icons.local_fire_department,
                    color: const Color(0xFFF59E0B), // Amber
                  ),
                  StatCard(
                    title: 'Hábitos Completados',
                    value: '${tvProvider.completedHabits}',
                    icon: Icons.check_circle_outline,
                    color: TvTheme.success,
                  ),
                  StatCard(
                    title: 'Tasa de Éxito',
                    value: '${tvProvider.successRate}%',
                    icon: Icons.analytics_outlined,
                    color: TvTheme.primaryFocused,
                  ),
                  const StatCard(
                    title: 'Meta Semanal',
                    value: '4/7',
                    icon: Icons.flag_outlined,
                    color: Color(0xFF06B6D4), // Cyan
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
