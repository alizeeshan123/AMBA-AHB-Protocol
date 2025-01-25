`timescale 1ns / 1ps
module AHB_slave (output reg [31:0] HRDATA, output reg HREADY, output reg [31:0] HADDR_OUT, output reg [31:0] HWDATA_out,
                input [31:0] HWDATA, input HRESP, input [31:0] HADDR, input [31:0] HRDATA_in, input HWRITE, input HTRANS, input HCLK);
                    
    parameter IDLE = 2'b00, WRITE = 2'b01, READ = 2'b10;
    reg [1:0] PRESENT_STATE, NEXT_STATE;
    
    initial
        begin
            PRESENT_STATE <= IDLE;
            HREADY <= 1'b1;
        end
  
    always@(posedge HCLK)
         begin
             PRESENT_STATE <= NEXT_STATE;
         end
        
    always@(*)
        begin
                case(PRESENT_STATE)
                    IDLE : begin
                        case({HTRANS, HWRITE, HRESP})
                                      
                              3'b110 : begin
                                        NEXT_STATE <= WRITE;
                                       end
                                       
                              3'b100 : begin
                                        NEXT_STATE <= READ;
                                       end
                         
                              default : begin
                                            HREADY <= 1'b0;
                                            HADDR_OUT <= 32'dx;
                                            HWDATA_out <= 32'dx;
                                            HRDATA <= 32'dx;
                                        end
                         endcase

                            end
                        
                    READ : begin
                                HRDATA <= HRDATA_in;
                                HADDR_OUT <= HADDR;
                                HWDATA_out <= 32'hxxxxxxxx;
                                NEXT_STATE <= IDLE;
                            end
 
                    WRITE : begin
                                HADDR_OUT <= HADDR;
                                HWDATA_out <= HWDATA;
                                HRDATA <= 32'hxxxxxxxx;
                                NEXT_STATE <= IDLE;
                            end
                    endcase
            end
endmodule
