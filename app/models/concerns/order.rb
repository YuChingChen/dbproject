class Order < ActiveRecord::Base
	self.table_name = "a05b00_order"

def self.data_count
	query  = <<-SQL
	(select agent.Agent_No,count(paxdata.Pax_Key) as colacount
	from (select * from a05b00_order limit 500) as neworder
	inner join a04a1_agentno as agent on agent.Agent_No=neworder.Agent_No
	inner join a05b01_paxdata as paxdata on paxdata.Order_No=neworder.Order_No
	where agent.Internal_Mark="-1" and neworder.Input_Date > "2010-05-04"
	group by agent.Agent_No)
	union
	(select agent.Agent_No,count(paxdata.Pax_Key) 
	from (select * from a05b00_order limit 500) as neworder
	inner join a04a1_agentno as agent on agent.Agent_No=neworder.Agent_No
	inner join a05b01_paxdata as paxdata on paxdata.Order_No=neworder.Order_No
	where agent.Internal_Mark="0" and neworder.Input_Date < "2010-05-04"
	group by agent.Agent_No);
	SQL

	 data=Order.find_by_sql(query)
	 data.map{|d| {name: d.Agent_No,count: d.colacount}}
end		

end