defmodule MessageSystem.MsgHandlerTest do
  use ExUnit.Case
  import MessageSystem.MsgHandler

  test "decode/1 decodes json into a map" do
    assert decode("{\"record_source\": \"POS\"}") == %{"record_source" => "POS"}
  end

  test "sanitize/1 upcases record keys in message" do
    result = sanitize(%{"record"  => %{"attr1" => "hey", "attr2" => ""}})
    assert result == %{"record" => %{"ATTR1" => "hey", "ATTR2" => ""}}
  end

  test "validate/1 makes sure the msg is a map with the proper keys" do
    bad_map = %{"no_headers" => "hehe"}
    assert_raise FunctionClauseError, fn -> validate(bad_map) end

    bad_map = %{"headers" => %{"no_sub_keys" => "hehe"}}
    assert_raise MatchError, fn -> validate(bad_map) end
  end

  test "validate/1 returns the map" do
    good_map = %{
      "headers" => %{
        "message_source" => "",
        "record_source"  => "",
        "record_mode"    => ""}}
    assert validate(good_map) == good_map
  end

  test "validate_headers/1 makes sure specific keys exists" do
    bad_headers = %{"message_source" => 3}
    assert_raise MatchError, fn -> validate_headers(bad_headers) end

    good_headers = %{
      "message_source" => "",
      "record_source"  => "",
      "record_mode"    => ""}
    assert validate_headers(good_headers) == good_headers
  end

  test "map_to_public/1" do
    customer_map = %{customer_number: "123", name: "Hebediah"}
    postal_address_map = %{
      address_line_1: "one happy day",
      city: "Greatsville",
      state: "NC",
      zip: "12345"}

    result = map_to_public(arcust_record)
    assert result == [customer_map, postal_address_map]
  end

  def arcust_record do
    %MessageSystem.POS.Arcust{
      "RCCST#":  "123",
      "RCNAME":  "Hebediah",
      "RCADDR1": "one happy day",
      "RCCITY":  "Greatsville",
      "RCSTATE": "NC",
      "RCZIP":   "12345"}
  end
end

