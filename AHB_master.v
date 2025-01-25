`timescale 1ns / 1ps
module AHB_master(output reg [31:0] HADDR, output reg [31:0] HWDATA, output reg HRESP, output reg [31:0] HRDATA_out, 
               input [31:0] ALU_result, input [31:0] RS2_data, input [31:0] HRDATA, input HREADY, input HTRANS, input HWRITE, input HCLK); 
                                 
    parameter IDLE = 2'b00, READ = 2'b01, WRITE = 2'b10;
    reg [1:0] PRESENT_STATE, NEXT_STATE;
    
    initial
        begin
            PRESENT_STATE <= IDLE;
            HRESP <= 1'b0;
        end
        
    always@(posedge HCLK)
                begin
                    PRESENT_STATE <= NEXT_STATE; 
                end

    always@(*)
        begin
            case(PRESENT_STATE)
                IDLE : begin
                    case({HTRANS, HWRITE, HREADY})
                        
                        3'b101 : begin
                                    NEXT_STATE <= READ;
                                 end
                                 
                        3'b111 : begin
                                    NEXT_STATE <= WRITE;
                                 end
                        
                        default : begin
                                    HRESP <= 1'b1;
                                    HADDR <= 32'h00000000;
                                    HWDATA <= 32'h00000000;
                                    HRDATA_out <= 32'h00000000;
                                  end
                    endcase
                        end
                        
                READ : begin
                            HADDR <= ALU_result;
                            HWDATA <= 32'hxxxxxxxx;
                            HRDATA_out <= HRDATA;
                            NEXT_STATE <= IDLE;
                        end
                
                WRITE : begin
                            HADDR <= ALU_result;
                            HWDATA <= RS2_data;
                            HRDATA_out <= 32'hxxxxxxxx;
                            NEXT_STATE <= IDLE;
                        end
                endcase    
       end

endmodule
