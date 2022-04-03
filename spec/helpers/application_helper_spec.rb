require 'rails_helper'

RSpec.describe ApplicationHelper do
  describe '#flash_class' do
    it 'returns background class given :key' do
      expect(helper.flash_class('notice')).to eq('bg-success')
    end
  end

  describe '#shorten_relative_time' do
    it 'returns relative time in seconds' do
      expect(helper.shorten_relative_time(30.seconds.ago)).to eq('30s')
    end

    it 'returns relative time in minutes' do
      expect(helper.shorten_relative_time(30.minutes.ago)).to eq('30m')
    end

    it 'returns relative time in hours' do
      expect(helper.shorten_relative_time(1.hour.ago)).to eq('1h')
    end

    it 'returns date fully' do
      current_time = Time.zone.parse('January 1, 2022')
      yesterday = current_time - 1.day
      expect(helper.shorten_relative_time(yesterday, current_time: current_time)).to eq('Dec 31, 2021')
    end
  end
end
