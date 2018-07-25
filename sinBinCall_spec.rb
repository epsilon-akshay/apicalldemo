require "sinBinCall/version"
require 'httparty'
require 'webmock/rspec'
class SinBin

	include HTTParty 
	base_uri "g-allocation-sinbin-filter-haproxy-a-01/"

	def self.driver_inside_sinbin(id)
		if(id.to_i > 10000.to_i)
			return "not valid"
		end


		response_for_get = self.get("/driver/#{id}/sinbin_status",{ :headers => {"X_OWNER_ID" => id}  })
		if_in_sinbin=JSON.parse(response_for_get.body)
		return if_in_sinbin["inSinbin"]
	end
end




describe SinBin do
	it "test for 6 id" do 
		stub_request(:get,"g-allocation-sinbin-filter-haproxy-a-01/driver/6/sinbin_status").with(headers: {"X_OWNER_ID" => "6"}).to_return( body: "{\"inSinbin\":false,\"reason\":\"\",\"timeoutSeconds\":0,\"sinbinStartTimestamp\":0,\"sinbinEndTimestamp\":0}")
		
		expect(SinBin.driver_inside_sinbin("6")).to eq(false)

	end

	it "test for 900 id" do 
		stub_request(:get,"g-allocation-sinbin-filter-haproxy-a-01/driver/900/sinbin_status").with(headers: {"X_OWNER_ID" => "900"}).to_return( body: "{\"inSinbin\":true,\"reason\":\"\",\"timeoutSeconds\":0,\"sinbinStartTimestamp\":0,\"sinbinEndTimestamp\":0}")
		
		expect(SinBin.driver_inside_sinbin("900")).to eq(true)

	end


	it "test for 8999999999999 id" do 
		stub_request(:get,"g-allocation-sinbin-filter-haproxy-a-01/driver/8999999999999/sinbin_status").with(headers: {"X_OWNER_ID" => "8999999999999"}).to_return( body: "not valid id")
		not 
		expect(SinBin.driver_inside_sinbin("8999999999999")).to eq("not valid")
	end

end
