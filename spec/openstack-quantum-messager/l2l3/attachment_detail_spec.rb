# -*- encoding: utf-8 -*-
require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Openstack::QuantumMessager::AttachmentDetail do
  before do
    config = {:url => "http://localhost:9696", :tenant => "XYZ"}
    @messager = Openstack::QuantumMessager::L2l3.new(config)
    @attachment_detail = {"attachment_detail" => {"interface_id" => "a4:ba:db:05:6e:f8", "ip" => "192.168.3.4"}}
  end

  it "should generate the correct json syntax for attachment_detail creation" do
    url = "http://localhost:9696/v1.0/extensions/l2l3/tenants/XYZ/attachment_details.json"
    HTTParty.should_receive(:post).with(
      url,
      :body => @attachment_detail.to_json,
      :headers => {"Content-Type" => "application/json"}
    )
    @messager.attachment_detail.create("a4:ba:db:05:6e:f8", "192.168.3.4")
  end

  it "should return the attachment_detail uuid" do
    attachment_detail = @messager.attachment_detail.create("a4:ba:db:05:6e:f8", "192.168.3.4")
    attachment_detail.should_not be_nil
    attachment_detail["id"].should match(/\w{8}-\w{4}-\w{4}-\w{4}-\w{12}/)
  end
end