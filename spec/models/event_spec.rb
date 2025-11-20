require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'associations' do
    describe 'belongs_to community' do
      it 'belongs to a community' do
        community = create(:community)
        event = create(:event, community: community)

        expect(event.community).to eq(community)
      end

      it 'is invalid without a community' do
        event = build(:event, community: nil)
        expect(event).not_to be_valid
      end
    end

    describe 'belongs_to site' do
      it 'belongs to a site' do
        site = create(:site)
        event = create(:event, site: site)

        expect(event.site).to eq(site)
      end

      it 'is valid without a site (optional)' do
        event = build(:event, site: nil)
        expect(event).to be_valid
      end
    end

    describe 'has_many event_series' do
      it 'has many event_series' do
        event = create(:event)
        expect(event).to respond_to(:event_series)
        expect(event.event_series).to eq([])
      end

      it 'can have multiple event_series' do
        event = create(:event)
        series1 = create(:event_series, event: event)
        series2 = create(:event_series, event: event)

        expect(event.event_series).to contain_exactly(series1, series2)
      end

      it 'destroys dependent event_series when destroyed' do
        event = create(:event)
        series1 = create(:event_series, event: event)
        series2 = create(:event_series, event: event)

        expect { event.destroy }.to change { EventSeries.count }.by(-2)
      end
    end
  end

  describe 'validations' do
    describe 'event_name presence' do
      it 'is valid with an event_name' do
        event = build(:event, event_name: 'Summer Festival')
        expect(event).to be_valid
      end

      it 'is invalid without an event_name' do
        event = build(:event, event_name: nil)
        expect(event).not_to be_valid
        expect(event.errors[:event_name]).to include("can't be blank")
      end

      it 'is invalid with an empty event_name' do
        event = build(:event, event_name: '')
        expect(event).not_to be_valid
        expect(event.errors[:event_name]).to include("can't be blank")
      end
    end

    describe 'date presence' do
      it 'is valid with a date' do
        event = build(:event, date: Date.today)
        expect(event).to be_valid
      end

      it 'is invalid without a date' do
        event = build(:event, date: nil)
        expect(event).not_to be_valid
        expect(event.errors[:date]).to include("can't be blank")
      end
    end

    describe 'category presence' do
      it 'is valid with a category' do
        event = build(:event, category: 'Festival')
        expect(event).to be_valid
      end

      it 'is invalid without a category' do
        event = build(:event, category: nil)
        expect(event).not_to be_valid
        expect(event.errors[:category]).to include("can't be blank")
      end

      it 'is invalid with an empty category' do
        event = build(:event, category: '')
        expect(event).not_to be_valid
        expect(event.errors[:category]).to include("can't be blank")
      end
    end

    describe 'description presence' do
      it 'is valid with a description' do
        event = build(:event, description: 'A fun event')
        expect(event).to be_valid
      end

      it 'is invalid without a description' do
        event = build(:event, description: nil)
        expect(event).not_to be_valid
        expect(event.errors[:description]).to include("can't be blank")
      end

      it 'is invalid with an empty description' do
        event = build(:event, description: '')
        expect(event).not_to be_valid
        expect(event.errors[:description]).to include("can't be blank")
      end
    end
  end

  describe 'alias attributes' do
    it 'aliases title as event_name' do
      event = create(:event, title: 'Music Festival')
      expect(event.event_name).to eq('Music Festival')
    end

    it 'can set event_name using the alias' do
      event = create(:event)
      event.event_name = 'Food Festival'
      expect(event.title).to eq('Food Festival')
    end
  end

  describe 'factory' do
    it 'has a valid factory' do
      event = build(:event)
      expect(event).to be_valid
    end

    it 'creates an event with a title' do
      event = create(:event)
      expect(event.title).to be_present
    end

    it 'creates an event with a date' do
      event = create(:event)
      expect(event.date).to be_present
    end

    it 'creates an event with a category' do
      event = create(:event)
      expect(event.category).to be_present
    end

    it 'creates an event with a description' do
      event = create(:event)
      expect(event.description).to be_present
    end

    it 'creates an event with a community' do
      event = create(:event)
      expect(event.community).to be_present
      expect(event.community).to be_a(Community)
    end

    it 'creates an event with a site' do
      event = create(:event)
      expect(event.site).to be_present
      expect(event.site).to be_a(Site)
    end
  end

  describe 'database columns' do
    it 'has a title column' do
      event = create(:event, title: 'Test Event')
      expect(event.title).to eq('Test Event')
    end

    it 'has a date column' do
      event = create(:event, date: Date.new(2024, 12, 25))
      expect(event.date).to eq(Date.new(2024, 12, 25))
    end

    it 'has a category column' do
      event = create(:event, category: 'Music')
      expect(event.category).to eq('Music')
    end

    it 'has a description column' do
      event = create(:event, description: 'A wonderful event')
      expect(event.description).to eq('A wonderful event')
    end

    it 'has a community_id foreign key' do
      event = create(:event)
      expect(event.community_id).to be_present
    end

    it 'has a site_id foreign key' do
      event = create(:event)
      expect(event.site_id).to be_present
    end

    it 'has timestamps' do
      event = create(:event)
      expect(event.created_at).to be_present
      expect(event.updated_at).to be_present
    end
  end
end
