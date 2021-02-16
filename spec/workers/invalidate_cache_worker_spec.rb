require 'rails_helper'

RSpec.describe InvalidateCacheWorker do
  describe '.perform' do
    it 'makes call to API' do
      mock_response = double('Response')
      allow(Faraday).to receive(:delete) { mock_response }
      allow(mock_response).to receive(:status).and_return(204)

      worker = described_class.new
      worker.perform({ 'type' => 'unit', 'identifier' => 'unit-slug' })
      expect(Faraday)
        .to have_received(:delete)
        .with('https://test-tc-api.com/api/cache', { identifier: 'unit-slug', resource: 'unit' })
    end

    context 'when API call fails' do
      it 'logs message to sentry' do
        allow(Raven).to receive(:capture_message)
        mock_response = double('Response')
        allow(Faraday).to receive(:delete) { mock_response }
        allow(mock_response).to receive(:status).and_return(401)
        allow(mock_response).to receive(:body).and_return('Invalid token')

        worker = described_class.new
        worker.perform({ 'type' => 'unit', 'identifier' => 'unit-slug' })
        expect(Raven)
          .to have_received(:capture_message)
          .with('Error making call to clear cache. Error: 401 - Invalid token; Resource: {"type"=>"unit", "identifier"=>"unit-slug"}')
      end
    end
  end
end
