import 'package:go_router/go_router.dart';
import '../../views/employee_list/employee_list_view.dart';
import '../../views/add_employee/add_employee_view.dart';
import '../../views/employee_detail/employee_detail_view.dart';
import '../../views/edit_employee/edit_employee_view.dart';
import '../../views/attendance/attendance_view.dart';

class AppRouter {
  static final router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => const EmployeeListView()),
      GoRoute(path: '/add', builder: (context, state) => const AddEmployeeView()),
      GoRoute(
        path: '/detail/:id',
        builder: (context, state) =>
            EmployeeDetailView(id: state.pathParameters['id']!),
      ),
      GoRoute(
        path: '/edit/:id',
        builder: (context, state) =>
            EditEmployeeView(id: state.pathParameters['id']!),
      ),
      GoRoute(
        path: '/attendance',
        builder: (context, state) => const AttendanceView(),
      ),
    ],
  );
}
