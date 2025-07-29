# Route Guards Implementation

## Overview
The application implements comprehensive route guards to ensure proper navigation based on authentication state and user organization status.

## Key Components

### 1. RouterNotifier (`lib/presentation/router/router_notifier.dart`)
- Listens to authentication state changes
- Implements redirect logic based on user state
- Manages navigation flow for authenticated and unauthenticated users

### 2. App Router (`lib/presentation/router/app_router.dart`)
- Integrates with RouterNotifier for reactive navigation
- Defines all application routes
- Uses GoRouter with refresh listener for dynamic redirects

## Navigation Flow

### Unauthenticated Users
1. **Splash Page** → Checks auth state → Redirects to:
   - Onboarding (if not completed)
   - Login (if onboarding completed)

2. **Protected Routes** → Automatically redirect to Login page

3. **Allowed Routes**:
   - `/` (splash)
   - `/login`
   - `/register`
   - `/forgot-password`
   - `/onboarding`
   - `/feature-tour`

### Authenticated Users

1. **Without Organization**:
   - Redirected to `/organization/setup`
   - Cannot access main app features until organization is created

2. **With Organization**:
   - Can access all app features
   - Auth pages (`/login`, `/register`) redirect to `/home`
   - Full access to inventory, settings, and other features

## Implementation Details

### Route Protection Logic
```dart
// In RouterNotifier.redirect():
1. Check if loading → no redirect
2. Check if splash page → no redirect
3. If not authenticated and accessing protected route → redirect to login
4. If authenticated without organization → redirect to organization setup
5. If authenticated with organization and on auth page → redirect to home
```

### Auth State Monitoring
- Uses Riverpod providers to watch authentication state
- Automatically triggers navigation on auth state changes
- Handles async loading states gracefully

### Post-Authentication Navigation
1. **Login Success**:
   - With organization → Home page
   - Without organization → Organization setup

2. **Registration Success**:
   - Always redirects to organization setup

3. **Onboarding Completion**:
   - Redirects to login page

## Testing Route Guards

### Manual Testing Steps
1. **Test Unauthenticated Access**:
   - Try accessing `/home` → Should redirect to login
   - Try accessing `/organization/settings` → Should redirect to login

2. **Test Authenticated Without Organization**:
   - Login with user without organization
   - Try accessing `/home` → Should redirect to organization setup

3. **Test Authenticated With Organization**:
   - Login with complete user
   - Try accessing `/login` → Should redirect to home
   - Access `/home` → Should work normally

4. **Test Navigation Flows**:
   - Complete onboarding → Should go to login
   - Register new account → Should go to organization setup
   - Login existing account → Should go to home or organization setup

## Security Considerations
- All route protection is enforced on the client side
- Backend APIs should also validate authentication and permissions
- Route guards prevent UI access but API calls need server-side validation