`timescale 1ns / 1ps
module AHB_Decoder(output reg HSELx1, output reg HSELx2, output reg HMSEL, input HADDR);

    always@(HADDR)
        begin
            case(HADDR)
                1'b0 : {HSELx1, HSELx2, HMSEL} = 3'b100;
                1'b1 : {HSELx1, HSELx2, HMSEL} = 3'b011;
                default : {HSELx1, HSELx2, HMSEL} = 3'bxxx;
            endcase
        end
        
endmodule
