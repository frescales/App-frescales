import 'package:flutter_riverpod/flutter_riverpod.dart';

final mainMenuViewModelProvider = Provider((ref) => MainMenuViewModel());

class MainMenuViewModel {
  List<MenuItem> getMenuItems(String rol) {
    switch (rol.toLowerCase()) {
      case 'administrador':
        return MenuItem.adminItems;
      case 'supervisor':
        return MenuItem.supervisorItems;
      case 'obrero':
        return MenuItem.obreroItems;
      default:
        return [];
    }
  }
}

class MenuItem {
  final String title;
  final String route;

  MenuItem({required this.title, required this.route});

  static final adminItems = [
    MenuItem(title: 'Producción', route: '/produccion'),
    MenuItem(title: 'Insumos Aplicados', route: '/insumos'),
    MenuItem(title: 'Labores', route: '/labores'),
    MenuItem(title: 'Enfermedades', route: '/enfermedades'),
    MenuItem(title: 'Actividades', route: '/actividades'),
    MenuItem(title: 'Catálogo: Unidades', route: '/catalogos'),
  ];

  static final supervisorItems = adminItems.sublist(0, 5);
  static final obreroItems = adminItems.sublist(0, 5);
}
