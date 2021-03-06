require 'helper'

class TestEppContactTransferResponse < Test::Unit::TestCase
  context 'EPP::Contact::TransferResponse' do
    context 'query' do
      setup do
        @response = EPP::Response.new(load_xml('contact/transfer-query'))
        @transfer_response = EPP::Contact::TransferResponse.new(@response)
      end

      should 'proxy methods to @response' do
        assert_equal @response.message, @transfer_response.message
      end

      should 'be successful' do
        assert @transfer_response.success?
        assert_equal 1000, @transfer_response.code
      end

      should 'have message' do
        assert_equal 'Command completed successfully', @transfer_response.message
      end
      
      should 'have contact id' do
        assert_equal 'sh8013', @transfer_response.id
      end

      should 'have transfer status' do
        assert_equal 'pending', @transfer_response.status
      end

      should 'have request ID' do
        assert_equal 'ClientX', @transfer_response.requested_id
      end

      should 'have request date' do
        # 2000-06-06T22:00:00.0Z
        expected = Time.gm(2000,6,6,22,00,00)
        assert_equal expected, @transfer_response.requested_date
      end
      
      should 'have action id' do
        assert_equal 'ClientY', @transfer_response.action_id
      end
      
      should 'have action date' do
        # 2000-06-11T22:00:00.0Z
        expected = Time.gm(2000,6,11,22,00,00)
        assert_equal expected, @transfer_response.action_date
      end
    end
    context 'request' do
      setup do
        @response = EPP::Response.new(load_xml('contact/transfer-request'))
        @transfer_response = EPP::Contact::TransferResponse.new(@response)
      end

      should 'proxy methods to @response' do
        assert_equal @response.message, @transfer_response.message
      end

      should 'be pending' do
        assert @transfer_response.pending?
        assert_equal 1001, @transfer_response.code
      end

      should 'have message' do
        assert_equal 'Command completed successfully; action pending', @transfer_response.message
      end
      
      should 'have contact id' do
        assert_equal 'sh8013', @transfer_response.id
      end
      
      should 'have transfer status' do
        assert_equal 'pending', @transfer_response.status
      end

      should 'have request ID' do
        assert_equal 'ClientX', @transfer_response.requested_id
      end

      should 'have request date' do
        # 2000-06-06T22:00:00.0Z
        expected = Time.gm(2000,6,8,22,00,00)
        assert_equal expected, @transfer_response.requested_date
      end
      
      should 'have action id' do
        assert_equal 'ClientY', @transfer_response.action_id
      end
      
      should 'have action date' do
        # 2000-06-13T22:00:00.0Z
        expected = Time.gm(2000,6,13,22,00,00)
        assert_equal expected, @transfer_response.action_date
      end
    end
  end
end
