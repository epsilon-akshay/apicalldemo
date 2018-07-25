require "sinBinCall/version"
require 'httparty'
require 'webmock/rspec'
class SinBin

	include HTTParty 
	base_uri "g-allocation-sinbin-filter-haproxy-a-01/"

	def self.driver_inside_sinbin(id)
		
		response_for_get = self.get('/driver/6/sinbin_status',{ :headers => {"X_OWNER_ID" => id}  })
		response_for_get.body
	end
end

a= SinBin.driver_inside_sinbin("6").class


describe SinBin do
	it "test for 6 call" do 
		stub_request(:get,"g-allocation-sinbin-filter-haproxy-a-01/driver/6/sinbin_status").with(headers: {"X_OWNER_ID" => "6"}).to_return( body: "{\"inSinbin\":false,\"reason\":\"\",\"timeoutSeconds\":0,\"sinbinStartTimestamp\":0,\"sinbinEndTimestamp\":0}")
		
		expect(SinBin.driver_inside_sinbin("6")).to eq("{\"inSinbin\":false,\"reason\":\"\",\"timeoutSeconds\":0,\"sinbinStartTimestamp\":0,\"sinbinEndTimestamp\":0}")

	end

	
end
