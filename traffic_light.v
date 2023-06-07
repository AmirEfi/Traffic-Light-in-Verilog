module traffic_light (
	output reg [2:0] light_A,
	output reg [2:0] light_B,
	input clk,
	input rst
);
	reg [3:0] time_counter; // 6 sec for green light and 1 sec for red/yellow light
	localparam
		gr_sec = 4'd6,
		rd_sec = 4'd1;

	reg [5:0] states; // 6 states that mentioned in the state machine
	localparam 
		s0 = 6'b000001,
		s1 = 6'b000010,
		s2 = 6'b000100,
		s3 = 6'b001000,
		s4 = 6'b010000,
		s5 = 6'b100000;

	always @ (posedge clk or posedge rst)
		if(rst == 1) // reset
			begin
			states <= s0;
			time_counter <= 0;
			end
		else
			case(states) // according to state machine in report file
				s0: if(time_counter < gr_sec)
					begin
						states <= s0;
						time_counter <= time_counter + 1;
					end
				    else
					begin
						states <= s1;
						time_counter <= 0;
					end
				
				s1: if(time_counter < rd_sec)
					begin
						states <= s1;
						time_counter <= time_counter + 1;
					end
				    else
					begin
						states <= s2;
						time_counter <= 0;
					end

				s2: if(time_counter < rd_sec)
					begin
						states <= s2;
						time_counter <= time_counter + 1;
					end
				    else
					begin
						states <= s3;
						time_counter <= 0;
				        end

				s3: if(time_counter < gr_sec)
					begin
						states <= s3;
						time_counter <= time_counter + 1;
					end
				    else
					begin
						states <= s4;
						time_counter <= 0;
					end

				s4: if(time_counter < rd_sec)
					begin
						states <= s4;
						time_counter <= time_counter + 1;
					end
				    else
					begin
						states <= s5;
						time_counter <= 0;
					end

				s5: if(time_counter < rd_sec)
					begin
						states <= s5;
						time_counter <= time_counter + 1;
					end
				    else
					begin
						states <= s0;
						time_counter <= 0;
					end
				    
                                    default states <= s0;
			endcase

		always @(*) // because it's sensitive and changes after a period of time
			begin
				case(states)
					s0: 
					   begin light_A <= 6'b100; light_B <= 3'b001; end // green A, red B
					s1: 
					   begin light_A <= 6'b010; light_B <= 3'b001; end // yellow A, red B
					s2: 
      					   begin light_A <= 6'b001; light_B <= 3'b001; end // red A, red B
					s3: 
					   begin light_A <= 6'b001; light_B <= 3'b100; end // red A, green B
					s4: 
					   begin light_A <= 6'b001; light_B <= 3'b010; end // red A, yellow B
					s5: 
					   begin light_A <= 6'b001; light_B <= 3'b001; end // red A, red B
				        default 
					   begin light_A <= 6'b001; light_B <= 3'b001; end // red A, red B
				endcase
			end

endmodule
