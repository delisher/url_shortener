require 'rails_helper'

RSpec.describe UrlsController, type: :controller do
  let!(:url_obj) { create :url }
  let(:slug) { url_obj.slug }
  let(:original_url) { url_obj.original_url }

  describe '#show' do
    subject { get :show, params: { slug: slug } }

    context 'when object with slug exists' do
      it 'returns original_url' do
        expect { subject }.to change { url_obj.reload.hits }.by(1)
        expect(response.body).to eq(url_obj.original_url.to_json)
        expect(response).to have_http_status(200)
      end
    end
    context 'when object with slug does not exist' do
      let(:slug) { 'wrong_slug' }

      it 'returns 404' do
        subject
        expect(response).to have_http_status(404)
      end
    end
  end

  describe '#stat' do
    subject { get :stats, params: { slug: slug } }

    context 'when object with slug exists' do
      it 'returns original_url' do
        subject
        expect(response).to have_http_status(200)
        expect(response.body).to eq(url_obj.hits.to_json)
      end
    end
    context 'when object with slug does not exist' do
      let(:slug) { 'wrong_slug' }

      it 'returns 404' do
        subject
        expect(response).to have_http_status(404)
      end
    end
  end

  describe '#post' do
    subject { post :create, params: { original_url: original_url } }

    context 'when object with original_url exists' do
      it 'returns slug' do
        subject
        expect(response).to have_http_status(200)
        expect(response.body).to eq(url_obj.short.to_json)
      end
    end

    context 'when object with original_url does not exist' do
      let(:original_url) { Faker::Internet.url }

      it 'creates new url object' do
        expect { subject }.to change { Url.count }.by(1)
        expect(response).to have_http_status(200)
      end
    end

    context 'when original_url is not valid' do
      let(:original_url) { Faker::Lorem.word }

      it 'returns error' do
        expect { subject }.not_to change { Url.count }
        expect(response).to have_http_status(400)
      end
    end
  end
end
