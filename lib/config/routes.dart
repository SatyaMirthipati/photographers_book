import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart' as f;

import '../ui/screens/auth/login_screen.dart';
import '../ui/screens/auth/mobile_screen.dart';
import '../ui/screens/auth/register_screen.dart';
import '../ui/screens/auth/reset_password_screen.dart';
import '../ui/screens/bookings/album_details_screen.dart';
import '../ui/screens/bookings/booking_details_screen.dart';
import '../ui/screens/bookings/booking_events_screen.dart';
import '../ui/screens/bookings/booking_payments_screen.dart';
import '../ui/screens/bookings/create_booking/add_basic_details_screen.dart';
import '../ui/screens/bookings/my_booking_screen.dart';
import '../ui/screens/bookings/receive_payment_screen.dart';
import '../ui/screens/events/edit_event_details_screen.dart';
import '../ui/screens/events/event_details_screen.dart';
import '../ui/screens/events/my_events_screen.dart';
import '../ui/screens/main/main_screen.dart';
import '../ui/screens/profile/due_list_screen.dart';
import '../ui/screens/profile/profile_details_screen.dart';
import '../ui/screens/profile/profile_screen.dart';
import '../ui/screens/sheets/create_sheet_screen.dart';
import '../ui/screens/sheets/edit_sheet_screen.dart';
import '../ui/screens/splash/splash_screen.dart';

extension MaterialFluro on FluroRouter {
  void defineMat(String path, Handler handler) {
    define(
      path,
      handler: handler,
      transitionType: TransitionType.material,
    );
  }
}

extension RouteString on String {
  String setId(String id) {
    return this.replaceFirst(':id', id);
  }
}

class Routes {
  //Auth flow
  static String root = '/';
  static String login = '/login';
  static String register = '/register';
  static String mobile = '/mobile';
  static String resetPassword = '/resetPassword';

  //Main Screen
  static String main = '/main';

  //Profile flow
  static String profile = '/profile';
  static String profileDetails = '/profileDetails';
  static String dueList = '/dueList';

  //Sheets flow
  static String createSheet = '/createSheet';
  static String editSheet = '/editSheet/:id';

  //Booking flow
  static String addBasicDetails = '/addBasicDetails/:id';
  static String myBookings = '/myBookings';
  static String bookingDetails = '/bookingDetails/:id';
  static String bookingEvents = '/bookingEvents';
  static String bookingSheets = '/bookingSheets';
  static String bookingPayments = '/bookingPayments';
  static String receivePayment = '/receivePayment';

  //Events flow
  static String myEvents = '/myEvents';
  static String eventDetails = '/eventDetails/:id';
  static String editEvent = '/editEvent/:id';

  static void configureRoutes(FluroRouter router) {
    router.notFoundHandler = notFoundHandler;

    router.define(
      root,
      handler: rootHandler,
      transitionType: TransitionType.material,
    );

    router.define(
      login,
      handler: loginHandler,
      transitionType: TransitionType.material,
    );

    router.define(
      register,
      handler: registerHandler,
      transitionType: TransitionType.material,
    );

    router.define(
      mobile,
      handler: mobileHandler,
      transitionType: TransitionType.material,
    );

    router.define(
      resetPassword,
      handler: resetPasswordHandler,
      transitionType: TransitionType.material,
    );

    router.define(
      main,
      handler: mainHandler,
      transitionType: TransitionType.material,
    );

    router.define(
      profile,
      handler: profileHandler,
      transitionType: TransitionType.material,
    );

    router.define(
      createSheet,
      handler: createSheetHandler,
      transitionType: TransitionType.material,
    );

    router.define(
      editSheet,
      handler: editSheetHandler,
      transitionType: TransitionType.material,
    );

    router.define(
      profileDetails,
      handler: profileDetailsHandler,
      transitionType: TransitionType.material,
    );

    router.define(
      addBasicDetails,
      handler: addBasicDetailsHandler,
      transitionType: TransitionType.material,
    );

    router.define(
      myEvents,
      handler: myEventsHandler,
      transitionType: TransitionType.material,
    );

    router.define(
      myBookings,
      handler: myBookingsHandler,
      transitionType: TransitionType.material,
    );

    router.define(
      bookingDetails,
      handler: bookingDetailsHandler,
      transitionType: TransitionType.material,
    );

    router.define(
      eventDetails,
      handler: eventDetailsHandler,
      transitionType: TransitionType.material,
    );

    router.define(
      '$bookingEvents/:bookingId',
      handler: bookingEventsHandler,
      transitionType: TransitionType.material,
    );

    router.define(
      '$bookingSheets/:bookingId',
      handler: bookingSheetsHandler,
      transitionType: TransitionType.material,
    );

    router.define(
      '$bookingPayments/:bookingId',
      handler: bookingPaymentsHandler,
      transitionType: TransitionType.material,
    );

    router.define(
      editEvent,
      handler: editEventHandler,
      transitionType: TransitionType.material,
    );

    router.define(
      dueList,
      handler: dueListHandler,
      transitionType: TransitionType.material,
    );

    router.define(
      '$receivePayment/:id/:amount',
      handler: receivePaymentHandler,
      transitionType: TransitionType.material,
    );
  }
}

var notFoundHandler = Handler(
  type: HandlerType.function,
  handlerFunc: (context, params) {
    var path = f.ModalRoute.of(context!)!.settings.name;
    return f.ErrorWidget('$path route was not found!');
  },
);

var rootHandler = Handler(handlerFunc: (c, p) => const SplashScreen());

var loginHandler = Handler(handlerFunc: (c, p) => const LoginScreen());

var registerHandler = Handler(handlerFunc: (c, p) => const RegisterScreen());

var mobileHandler = Handler(handlerFunc: (c, p) => const MobileScreen());

var resetPasswordHandler = Handler(
  handlerFunc: (context, params) => const ResetPasswordScreen(),
);

var mainHandler = Handler(handlerFunc: (context, params) => const MainScreen());

var profileHandler = Handler(handlerFunc: (c, p) => const ProfileScreen());

var createSheetHandler = Handler(
  handlerFunc: (context, params) => const CreateSheetScreen(),
);

var editSheetHandler = Handler(
  handlerFunc: (context, params) => EditSheetScreen(id: params['id']![0]),
);

var profileDetailsHandler = Handler(
  handlerFunc: (context, params) => const ProfileDetailsScreen(),
);

var addBasicDetailsHandler = Handler(
  handlerFunc: (context, params) => const AddBasicDetailsScreen(),
);

var myEventsHandler = Handler(handlerFunc: (c, p) => const MyEventsScreen());

var myBookingsHandler = Handler(handlerFunc: (c, p) => const MyBookingScreen());

var bookingDetailsHandler = Handler(
  handlerFunc: (context, params) => BookingDetailsScreen(id: params['id']![0]),
);

var eventDetailsHandler = Handler(
  handlerFunc: (context, params) => EventDetailsScreen(id: params['id']![0]),
);

var bookingEventsHandler = Handler(
  handlerFunc: (c, p) => BookingEventsScreen(bookingId: p['bookingId']![0]),
);

var bookingSheetsHandler = Handler(
  handlerFunc: (c, p) => AlbumDetailsScreen(bookingId: p['bookingId']![0]),
);

var bookingPaymentsHandler = Handler(
  handlerFunc: (c, p) => BookingPaymentsScreen(bookingId: p['bookingId']![0]),
);

var editEventHandler = Handler(
  handlerFunc: (context, params) => EditEventDetails(id: params['id']![0]),
);

var dueListHandler = Handler(handlerFunc: (c, p) => const DueListScreen());

var receivePaymentHandler = Handler(
  handlerFunc: (context, params) => ReceivePaymentScreen(
    id: params['id']![0],
    amount: params['amount']![0],
  ),
);

var demoHandler = Handler(handlerFunc: (context, params) => f.Container());
