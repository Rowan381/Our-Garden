# Environment Setup Guide

## Required Environment Variables

Create a `.env` file in the root directory with the following variables:

```env
# App Configuration
APP_NAME=Our Garden
APP_VERSION=1.0.0
ENVIRONMENT=development

# API Keys
OPENAI_API_KEY=your_openai_api_key_here
KINDWISE_API_KEY=your_kindwise_api_key_here
GOOGLE_MAPS_API_KEY=your_google_maps_api_key_here
GEOAPIFY_API_KEY=your_geoapify_api_key_here

# Firebase Configuration
FIREBASE_API_KEY=your_firebase_api_key_here
FIREBASE_PROJECT_ID=your_firebase_project_id_here
FIREBASE_MESSAGING_SENDER_ID=your_firebase_messaging_sender_id_here
FIREBASE_APP_ID=your_firebase_app_id_here

# Stripe Configuration (if using payments)
STRIPE_PUBLISHABLE_KEY=your_stripe_publishable_key_here
STRIPE_SECRET_KEY=your_stripe_secret_key_here

# Other Services
MAPBOX_ACCESS_TOKEN=your_mapbox_access_token_here
```

## Getting API Keys

### OpenAI API Key
1. Go to [OpenAI Platform](https://platform.openai.com/)
2. Sign up or log in
3. Navigate to API Keys section
4. Create a new API key
5. Copy the key to your `.env` file

### Kindwise API Key (Plant Identification)
1. Go to [Plant.id](https://plant.id/)
2. Sign up for an account
3. Get your API key from the dashboard
4. Copy the key to your `.env` file

### Google Maps API Key
1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Create a new project or select existing one
3. Enable Maps SDK for Android/iOS
4. Create credentials (API Key)
5. Copy the key to your `.env` file

### Geoapify API Key
1. Go to [Geoapify](https://www.geoapify.com/)
2. Sign up for a free account
3. Get your API key from the dashboard
4. Copy the key to your `.env` file

### Firebase Configuration
1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Create a new project or select existing one
3. Add your app (Android/iOS)
4. Download the configuration file
5. Extract the values and add them to your `.env` file

## Security Notes

- Never commit your `.env` file to version control
- Add `.env` to your `.gitignore` file
- Use different API keys for development and production
- Regularly rotate your API keys
- Monitor API usage to avoid unexpected charges

## Validation

The app will validate all required environment variables on startup. If any are missing, you'll see an error message listing the missing variables. 