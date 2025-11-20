# GreenTrail

**Discover authentic local communities. Connect with grassroots travel experiences.**

GreenTrail is a Ruby on Rails web application designed to help travelers explore small towns and local communities in an authentic way. If small towns are going to thrive on their own terms, they need visibility. Local festivals, family-owned hotels, street taco stands, and passionate local guides all need a way to reach travelers seeking genuine community experiences.

## About

GreenTrail bridges the gap between passionate travelers and local community providers. The more people add their businesses and local favorites to a community page, the more interesting that community becomes to visitors.

Originally built with Node.js, Express, and Handlebars, this version rebuilds GreenTrail using Ruby on Rails with modern web technologies.

## Features

### For Travelers

- **Discover Communities**: Browse communities by location (Country → Province → Town)
- **Smart Search**: Search communities by name or location with filters for events and amenities
- **Explore Local Providers**: View categorized local businesses and services:
  - **Explore**: Local attractions and points of interest
  - **Eat**: Restaurants, cafes, and food establishments
  - **Stay**: Accommodations and lodging options
  - **Events**: Community events and happenings
  - **Amenities**: Local services and facilities
- **Save Favorites**: Create a personalized dashboard of communities you want to visit
- **Trip Planning**: Track your saved destinations in one place

### For Communities

- Showcase local providers and attractions
- Highlight community events (one-time and recurring)
- Connect travelers with authentic local experiences
- Build visibility for small towns and grassroots tourism

## Technology Stack

- **Ruby**: 3.1.0
- **Rails**: 7.2.2
- **Database**: PostgreSQL
- **Styling**: TailwindCSS
- **JavaScript**: Hotwire (Turbo + Stimulus)
- **Authentication**: Devise
- **File Storage**: ActiveStorage
- **SEO**: FriendlyId for URL slugs

### Key Gems

- `devise` - User authentication and authorization
- `friendly_id` - SEO-friendly URLs for communities
- `tailwindcss-rails` - Utility-first CSS framework
- `turbo-rails` - SPA-like page transitions and real-time updates
- `stimulus-rails` - JavaScript framework
- `image_processing` - Image upload and processing

## Getting Started

### Prerequisites

- Ruby 3.1.0
- Rails 7.2.2
- PostgreSQL
- Node.js and Yarn (for asset compilation)

### Installation

1. Clone the repository:
```bash
git clone <repository-url>
cd greentrail_rails
```

2. Install dependencies:
```bash
bundle install
yarn install
```

3. Set up environment variables:
```bash
cp .env.example .env
# Edit .env with your configuration
```

4. Create and set up the database:
```bash
rails db:create
rails db:migrate
rails db:seed
```

5. Start the development server:
```bash
bin/dev
```

6. Visit `http://localhost:3000` in your browser

### Environment Variables

Create a `.env` file in the root directory with the following variables:

```
DATABASE_USERNAME=your_db_username
DATABASE_PASSWORD=your_db_password
DEVISE_SECRET_KEY=your_devise_secret
# Add other environment variables as needed
```

## Database Structure

### Core Models

- **Location Hierarchy** (Single Table Inheritance)
  - Country → Province → Town
- **Community**: Represents a local community (belongs to Town)
- **Provider**: Local businesses and services (belongs to Community)
- **Site**: Physical locations within a community
- **Event**: One-time community events
- **EventSeries**: Recurring community events
- **Traveler**: Application users with roles (traveler/admin)
- **SavedCommunity**: Join table for travelers' saved communities
- **Tag**: Tagging system for providers

### Key Relationships

- A Town has one Community
- A Community has many Providers (categorized by type)
- Providers can have Tags (many-to-many)
- Travelers can save many Communities
- Events and EventSeries belong to Communities

## Testing

The application uses RSpec for testing:

```bash
# Run all tests
bundle exec rspec

# Run specific test file
bundle exec rspec spec/models/community_spec.rb
```

### Testing Tools

- RSpec - Testing framework
- FactoryBot - Test data factories
- Faker - Fake data generation
- Capybara - Integration testing
- Selenium WebDriver - Browser automation

## Development Tools

- **Brakeman**: Security vulnerability scanner
- **RuboCop**: Code style and quality analyzer
- **Letter Opener**: Preview emails in development

Run code quality checks:
```bash
# Security scan
bundle exec brakeman

# Style check
bundle exec rubocop
```

## Seeding Data

The seed file creates sample data including:
- 5 countries with provinces, towns, and communities
- 15 providers per community (3 per category)
- Sample events and event series
- 5 test travelers

```bash
rails db:seed
```

## User Roles

- **Traveler** (default): Can browse communities, save favorites, manage profile
- **Admin**: Extended permissions for managing communities and providers (in development)

## Key Routes

```
GET  /                          # Homepage
GET  /communities               # Browse communities
GET  /communities/:slug         # View community details
POST /search_communities        # Search communities
GET  /dashboard                 # Traveler dashboard (authenticated)
GET  /locations                 # Browse by location hierarchy
GET  /travelers/sign_up         # Register new account
GET  /travelers/sign_in         # Login
```

## Authentication Features

Powered by Devise with the following modules:
- Database authenticatable
- Registerable
- Recoverable (password reset)
- Rememberable
- Validatable
- Confirmable (email confirmation)
- Lockable (account locking after failed attempts)

## Contributing

Contributions are welcome! Please follow these guidelines:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Code Style

- Follow Ruby and Rails conventions
- Run RuboCop before committing
- Write tests for new features
- Keep commits focused and descriptive

## Roadmap

### Planned Features

- [ ] Admin interface for managing communities and providers
- [ ] Enhanced event management system
- [ ] User reviews and ratings for providers
- [ ] Messaging system between travelers and providers
- [ ] Trip planning tools and itinerary builder
- [ ] Budget tracking for trips
- [ ] Embedded interactive maps
- [ ] Mobile API for native apps
- [ ] Multi-language support
- [ ] Social sharing features
- [ ] Provider analytics dashboard

## License

[Add your license information here]

## Contact

[Add contact information or links here]

## Acknowledgments

GreenTrail was originally built with Node.js, Express, and Handlebars. This Rails version represents a complete rebuild with modern web technologies while maintaining the core mission: connecting travelers with authentic local community experiences.

---

**Built with love for small towns and grassroots tourism.**
