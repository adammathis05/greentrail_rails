require 'rails_helper'

RSpec.describe EventSeries, type: :model do
  describe 'associations' do
    describe 'belongs_to event' do
      it 'belongs to an event' do
        event = create(:event)
        event_series = create(:event_series, event: event)

        expect(event_series.event).to eq(event)
      end

      it 'is valid without an event (optional)' do
        event_series = build(:event_series, event: nil)
        expect(event_series).to be_valid
      end
    end

    describe 'belongs_to community' do
      it 'belongs to a community' do
        community = create(:community)
        event_series = create(:event_series, community: community)

        expect(event_series.community).to eq(community)
      end

      it 'is invalid without a community' do
        event_series = build(:event_series, community: nil)
        expect(event_series).not_to be_valid
      end
    end

    describe 'belongs_to site' do
      it 'belongs to a site' do
        site = create(:site)
        event_series = create(:event_series, site: site)

        expect(event_series.site).to eq(site)
      end

      it 'is valid without a site (optional)' do
        event_series = build(:event_series, site: nil)
        expect(event_series).to be_valid
      end
    end
  end

  describe 'validations' do
    describe 'event_series_name presence' do
      it 'is valid with an event_series_name' do
        event_series = build(:event_series, event_series_name: 'Weekly Yoga')
        expect(event_series).to be_valid
      end

      it 'is invalid without an event_series_name' do
        event_series = build(:event_series, event_series_name: nil)
        expect(event_series).not_to be_valid
        expect(event_series.errors[:event_series_name]).to include("can't be blank")
      end

      it 'is invalid with an empty event_series_name' do
        event_series = build(:event_series, event_series_name: '')
        expect(event_series).not_to be_valid
        expect(event_series.errors[:event_series_name]).to include("can't be blank")
      end
    end

    describe 'category presence' do
      it 'is valid with a category' do
        event_series = build(:event_series, category: 'Fitness')
        expect(event_series).to be_valid
      end

      it 'is invalid without a category' do
        event_series = build(:event_series, category: nil)
        expect(event_series).not_to be_valid
        expect(event_series.errors[:category]).to include("can't be blank")
      end

      it 'is invalid with an empty category' do
        event_series = build(:event_series, category: '')
        expect(event_series).not_to be_valid
        expect(event_series.errors[:category]).to include("can't be blank")
      end
    end

    describe 'description presence' do
      it 'is valid with a description' do
        event_series = build(:event_series, description: 'A recurring event')
        expect(event_series).to be_valid
      end

      it 'is invalid without a description' do
        event_series = build(:event_series, description: nil)
        expect(event_series).not_to be_valid
        expect(event_series.errors[:description]).to include("can't be blank")
      end

      it 'is invalid with an empty description' do
        event_series = build(:event_series, description: '')
        expect(event_series).not_to be_valid
        expect(event_series.errors[:description]).to include("can't be blank")
      end
    end
  end

  describe 'alias attributes' do
    it 'aliases name as event_series_name' do
      event_series = create(:event_series, name: 'Weekly Meditation')
      expect(event_series.event_series_name).to eq('Weekly Meditation')
    end

    it 'can set event_series_name using the alias' do
      event_series = create(:event_series)
      event_series.event_series_name = 'Monthly Book Club'
      expect(event_series.name).to eq('Monthly Book Club')
    end
  end

  describe 'factory' do
    it 'has a valid factory' do
      event_series = build(:event_series)
      expect(event_series).to be_valid
    end

    it 'creates an event_series with a name' do
      event_series = create(:event_series)
      expect(event_series.name).to be_present
    end

    it 'creates an event_series with a category' do
      event_series = create(:event_series)
      expect(event_series.category).to be_present
    end

    it 'creates an event_series with a description' do
      event_series = create(:event_series)
      expect(event_series.description).to be_present
    end

    it 'creates an event_series with an event' do
      event_series = create(:event_series)
      expect(event_series.event).to be_present
      expect(event_series.event).to be_a(Event)
    end

    it 'creates an event_series with a community' do
      event_series = create(:event_series)
      expect(event_series.community).to be_present
      expect(event_series.community).to be_a(Community)
    end

    it 'creates an event_series with a site' do
      event_series = create(:event_series)
      expect(event_series.site).to be_present
      expect(event_series.site).to be_a(Site)
    end
  end

  describe 'database columns' do
    it 'has a name column' do
      event_series = create(:event_series, name: 'Test Series')
      expect(event_series.name).to eq('Test Series')
    end

    it 'has a date column' do
      event_series = create(:event_series, date: Date.new(2024, 12, 25))
      expect(event_series.date).to eq(Date.new(2024, 12, 25))
    end

    it 'has a day_of_week column' do
      event_series = create(:event_series, day_of_week: 'Monday')
      expect(event_series.day_of_week).to eq('Monday')
    end

    it 'has a time column' do
      event_series = create(:event_series, time: '10:00')
      expect(event_series.time).to be_present
    end

    it 'has a category column' do
      event_series = create(:event_series, category: 'Wellness')
      expect(event_series.category).to eq('Wellness')
    end

    it 'has a description column' do
      event_series = create(:event_series, description: 'A great series')
      expect(event_series.description).to eq('A great series')
    end

    it 'has an event_id foreign key' do
      event_series = create(:event_series)
      expect(event_series.event_id).to be_present
    end

    it 'has a community_id foreign key' do
      event_series = create(:event_series)
      expect(event_series.community_id).to be_present
    end

    it 'has a site_id foreign key' do
      event_series = create(:event_series)
      expect(event_series.site_id).to be_present
    end

    it 'has timestamps' do
      event_series = create(:event_series)
      expect(event_series.created_at).to be_present
      expect(event_series.updated_at).to be_present
    end
  end
end
