`include "traffic_light.v"
`define period_clk 1000000000
module traffic_light_tb();

	wire [2:0] light_A;
	wire [2:0] light_B;
	reg clk;
	reg rst;


	traffic_light Traffic_Light(light_A,light_B,clk,rst);

	
	initial clk = 1;
	always #(`period_clk / 2) clk = ~clk;

	initial begin
		rst = 0;

		#`period_clk;
		rst = 1;

		#`period_clk;
		rst = 0;

		#(`period_clk);

	end

endmodule
