# KisanYantra: Farm Equipment Rental Discovery Platform

KisanYantra is a cross-platform Flutter application that helps farmers discover and rent nearby agricultural equipment, while also allowing equipment owners to publish listings and manage booking requests. The backend uses Supabase (PostgreSQL, Auth, Storage, and Realtime).

This README is designed as a full project reference for:
- Development onboarding
- System understanding
- Academic documentation and research-paper writing

## 1. Problem Statement

Small and medium farmers often cannot afford to buy expensive machinery such as tractors, harvesters, and seeders. At the same time, many equipment owners have underutilized assets. Existing rental processes are often manual, non-transparent, and geographically inefficient.

KisanYantra addresses this by providing:
- Location-aware equipment discovery
- Digital booking and approval workflow
- Rating and review based trust model
- Unified platform for renters, owners, and admins

## 2. Project Objectives

- Build a practical digital marketplace for farm equipment rental.
- Reduce search friction using location and filter-based discovery.
- Improve utilization of agricultural assets.
- Provide transparent booking lifecycle management.
- Offer analytics and moderation controls for administrators.

## 3. Core Features

### 3.1 Authentication and User Profiles
- Email-password authentication via Supabase Auth
- User profile creation and update
- Role-aware behavior (`user`, legacy `farmer`/`owner`, and `admin`)
- Password reset support

### 3.2 Equipment Listing Management
- Owners can create, update, and activate/deactivate listings
- Listing fields include type, description, price/day, address, geo-coordinates, images, and rating metadata
- Image upload through Supabase Storage buckets

### 3.3 Discovery and Search
- Nearby listing search using user location
- Radius-based filtering
- Category and price range filters
- Optional insurance-only filter
- Map visualization using OpenStreetMap tiles

### 3.4 Booking Lifecycle
- Booking request creation by renter/farmer
- Owner approval/decline flow
- Booking status progression (`Pending`, `Approved`, `Declined`, `Completed`)
- Conflict detection for overlapping bookings

### 3.5 Reviews and Reputation
- One review per completed booking
- Owner and listing rating recalculation through SQL RPC functions
- Review-based quality signals

### 3.6 Notifications and Realtime
- In-app notification records for booking and platform events
- Realtime subscriptions for bookings, notifications, and listings

### 3.7 Admin Dashboard
- Platform-level overview stats
- User verification flow
- Listing moderation and active-state toggle

## 4. Technology Stack

### Frontend
- Flutter (Dart)
- Provider (state management)
- flutter_map + latlong2 (map and geo-visualization)

### Backend and Data
- Supabase Auth
- Supabase PostgreSQL
- Supabase Storage
- Supabase Realtime

### Important Packages
- `supabase_flutter`
- `geolocator`, `geocoding`
- `image_picker`
- `flutter_rating_bar`
- `cached_network_image`
- `intl`, `timeago`
- `permission_handler`
- `connectivity_plus`
- `http`, `url_launcher`

## 5. High-Level Architecture

KisanYantra follows a layered structure:

1. Presentation layer
- Screens for auth, discovery, owner workflows, admin dashboard, and profile

2. State layer
- `AuthProvider` manages session, profile bootstrap, and auth-side state

3. Service layer
- `AuthService`, `ListingService`, `BookingService`, `ReviewService`, `NotificationService`, `StorageService`, `LocationService`

4. Data layer
- Supabase tables, policies, storage buckets, and SQL functions

## 6. Project Structure

Main app code lives in `lib/`:

- `main.dart`: App initialization, Supabase boot, route generation
- `models/`: Data models (user, listing, booking, review, notification)
- `providers/`: Provider-based state classes
- `services/`: Backend and domain logic wrappers
- `screens/`: UI flows for auth, renter, owner, admin, splash/onboarding
- `widgets/`: Reusable UI components
- `utils/`: Theme, constants, utility helpers

## 7. Database Design (Supabase)

The SQL setup script is provided in `supabase_setup.sql`.

### Main Tables
- `users`: profile, role, location, verification, rating summary
- `listings`: equipment inventory metadata and pricing
- `bookings`: renter-owner transactions and status lifecycle
- `reviews`: post-booking rating and feedback
- `notifications`: user-specific app notifications

### Data Integrity and Security
- Foreign keys across all transactional tables
- Status and role constraints via SQL checks
- Indexes for owner/listing/bookings/status/date queries
- Row Level Security (RLS) policies enabled on all main tables
- Trigger to auto-create `public.users` row when a new auth user is inserted

### Server-side SQL Functions
- `update_owner_rating(owner_uuid)`
- `update_listing_rating(listing_uuid)`

## 8. Functional Workflow

### User Journey
1. User signs up/signs in.
2. Profile is resolved or upserted in `public.users`.
3. User enters unified home.
4. User discovers listings near current location.
5. User places a booking request.
6. Owner approves or declines.
7. Booking completes, review is submitted, ratings update.

### Owner Journey
1. Owner creates and manages listings.
2. Owner receives incoming requests.
3. Owner updates booking status.
4. Owner tracks requests, activity, and revenue indicators.

### Admin Journey
1. Admin opens dashboard overview.
2. Admin verifies users and reviews listing state.
3. Admin enables/disables listings when needed.

## 9. Setup and Installation

## Prerequisites
- Flutter SDK (stable)
- Dart SDK (compatible with project constraints)
- A Supabase project
- Android Studio or VS Code

## Clone and Install

```bash
git clone <your-repository-url>
cd fixed
flutter pub get
```

## Configure Supabase

1. Open Supabase dashboard.
2. Run `supabase_setup.sql` in SQL Editor.
3. Create storage buckets:
- `listings`
- `profile-images`
4. Update Supabase URL and anon key in app constants.

Current constants are defined in `lib/utils/app_theme.dart`.

Security recommendation:
- Do not keep production keys hardcoded in source for public repositories.
- Move sensitive configuration to secure environment handling before production deployment.

## Run the App

```bash
flutter run
```

## Build Commands

```bash
flutter build apk
flutter build appbundle
flutter build web
```

## 10. Testing and Quality

Run checks:

```bash
flutter analyze
flutter test
```

Linting is configured through `analysis_options.yaml` using `flutter_lints`.

## 11. Routes and Navigation Summary

Key named routes include:
- `/` splash
- `/onboarding`
- `/login`
- `/register`
- `/forgot-password`
- `/home` unified renter-owner experience
- `/equipment-detail`
- `/booking-request`
- `/booking-detail`
- `/add-listing`
- `/admin`

## 12. Research-Paper Ready Notes

You can directly use this section as a starting baseline for a research manuscript.

### Suggested Paper Title
"KisanYantra: A Location-Aware Mobile Platform for Farm Equipment Rental Using Flutter and Supabase"

### Suggested Research Domains
- Agricultural informatics
- Digital sharing economy
- Mobile computing for rural ecosystems
- Geospatial decision support

### Candidate Evaluation Metrics
- Listing discovery latency (seconds)
- Booking completion rate
- Average owner asset utilization
- User retention and repeat booking rate
- Average search radius vs booking conversion
- Review score trends over time

### Suggested Methodology for Evaluation
1. Create synthetic and/or pilot real-world datasets.
2. Measure task completion time for renter and owner workflows.
3. Compare manual rental workflow vs app-enabled workflow.
4. Collect user feedback through SUS or custom usability scales.
5. Analyze reliability under low-connectivity conditions.

### Suggested Future Enhancements (for Discussion section)
- Dynamic pricing and demand forecasting
- Multilingual interface for regional adoption
- Offline-first caching for rural networks
- Digital payments and invoice integration
- Mechanic/service marketplace extension
- AI recommendation engine for equipment matching

## 13. Known Constraints

- Production-grade secret management is not yet externalized.
- Role model includes legacy values that should be unified long-term.
- Some advanced booking fields may require database schema parity checks depending on migration state.

## 14. License

This project includes a `LICENSE` file at repository root. Follow that license for redistribution, publication artifacts, and derivative work.

## 15. Acknowledgements

- Flutter ecosystem
- Supabase platform
- OpenStreetMap tile providers

---

If you are preparing a report, dissertation, or conference paper, this README can be used as:
- System overview chapter seed
- Implementation details section seed
- Experimental design checklist
- Limitations and future work reference
