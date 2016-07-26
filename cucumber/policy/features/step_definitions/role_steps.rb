Given(/^I show the (\w+) "([^"]*)"$/) do |role_kind, role_id|
  invoke do
    possum.role_show [ role_kind, role_id ].join(":")
  end
end

Then(/^(\w+) "([^"]*)" is a role member( with admin option)?$/) do |role_kind, role_id, admin|
  members = @result['members']
  if admin
    members = members.select{|m| m['admin_option']}
  end
  expect(members.map{|m| m['member']}).to include(make_full_id(role_kind, role_id))
end
