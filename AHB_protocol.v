`timescale 1ns / 1ps
module AHB_protocol(output [31:0] ADDRESS, output [31:0] DATA, output [31:0] DATA_OUT, input HTRANS,
                    input HWRITE, input [31:0] ALU_RESULT,input [31:0] RS2_DATA, input [31:0] DATA_REC, input CLOCK);

wire [31:0] HADDR, HWDATA, HRDATA;
wire HRESP, HREADY;

AHB_master MASTER(HADDR, HWDATA, HRESP, DATA_OUT, ALU_RESULT, RS2_DATA, HRDATA, HREADY, HTRANS, HWRITE, CLOCK);

AHB_slave SLAVE(HRDATA, HREADY, ADDRESS, DATA, HWDATA, HRESP, HADDR, DATA_REC, HWRITE, HTRANS, CLOCK);

endmodule
