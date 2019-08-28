module branchcontroller(in, ctrl, out);
	input [31:0] in;
	input [2:0] ctrl;
	output out;

	assign out = controller(ctrl);

	function controller(input [2:0] ctrl);
		begin
			case(ctrl)
			3'b000: ~|in;
			3'b001:	|in;
			3'b100:	in[0];
			3'b101: ~in[0];
			3'b110: in[0];
			3'b111: ~in[0];
			default:
			endcase
		end
	endfunction
endmodule
