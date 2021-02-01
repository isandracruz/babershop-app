require 'swagger_helper'

describe 'Barbershop Reservations API' do

  path '/api/v1/reservations' do

    post 'Creates a reservation' do
      tags 'Reservations'
      consumes 'application/json', 'application/xml'
      parameter name: :reservation, in: :body, schema: {
        type: :object,
        properties: {
          username: { type: :string },
          resdate: { type: :string },
          restime: { type: :string }
        },
        required: [ 'username','resdate','restime' ]
      }

      response '201', 'reservation created' do
        let(:reservation) { { username: 'peter1', resdate:'2021/01/23' ,restime: '14:00' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:reservation) { { username: 'alex3' } }
        run_test!
      end
    end
  end

  path '/api/v1/reservations' do

    get 'Show all reservations' do
      tags 'All Reservations'      

      response '200', 'reservation list' do
        let(:reservation) {reservation.all }
        run_test!
      end

      response '422', 'invalid request' do
        let(:reservation) { 'invalid' }
        run_test!
      end
    end
  end

  path '/api/v1/reservations/{id}' do

    get 'Show a reservation' do
      tags 'Show a reservation'
      produces 'application/json', 'application/xml'
      parameter name: :id, :in => :path, :type => :string

      response '200', 'reservation found' do
        schema type: :object,
          properties: {
            id: { type: :integer, },
            username: { type: :string },
            resdate: { type: :string },
            restime: { type: :string }
          },
          required: [ 'id', 'username', 'resdate' ,'restime' ]

        let(:id) { reservation.create(username: 'alex1', resdate: '2021/02/03', restime: '09:00').id }
        run_test!
      end

      response '404', 'reservation not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end

  path '/api/v1/reservations/{id}' do

    put 'Update a reservation' do
      tags 'Update a reservation'
      produces 'application/json', 'application/xml'
      parameter name: :id, :in => :path, :type => :string

      response '200', 'reservation update' do
        schema type: :object,
          properties: {
            id: { type: :integer, },
            username: { type: :string },
            resdate: { type: :string },
            restime: { type: :string }
          },
          required: [ 'id', 'username', 'resdate' ,'restime' ]

        let(:id) { reservation.create(username: 'alex1', resdate: '2021/02/03', restime: '09:00').id }
        run_test!
      end

      response '404', 'reservation not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end

  path '/api/v1/reservations/{id}' do

    delete 'Delete a reservation' do
      tags 'Delete a reservation'
      produces 'application/json', 'application/xml'
      parameter name: :id, :in => :path, :type => :string

      response '200', 'reservation delete' do
        schema type: :object,
          properties: {
            id: { type: :integer, },
            username: { type: :string },
            resdate: { type: :string },
            restime: { type: :string }
          },
          required: [ 'id' ]        
        run_test!
      end

      response '404', 'reservation not found' do
        let(:id) { 'invalid' }
        run_test!
      end
     end
    end
end