`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.03.2025 10:15:31
// Design Name: 
// Module Name: cnt2hex
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module cnt2hex 
    (
    input  logic        clk_100MHz_i,
    input  logic        rst_n,
    
    input  logic [15:0] cnt_val_1_i,
    input  logic [15:0] cnt_val_2_i,
    
    output logic [7:0]  HEX_o,
    output logic [7:0]  AN_o
    
    );
    
    localparam CNT_480Hz_MAX_VAL = 18'd208_333;
    
    //--------------------
    
    logic        en_480Hz;
    logic [17:0] cnt_480Hz;
    
    always_ff @(posedge clk_100MHz_i) 
        if (!rst_n)
            cnt_480Hz <= 18'b0;
        else begin 
            if (cnt_480Hz < CNT_480Hz_MAX_VAL - 18'd1)
                cnt_480Hz <= cnt_480Hz + 18'd1;
            else
                cnt_480Hz <= 18'b0;
        end
    
    always_comb en_480Hz = cnt_480Hz == (CNT_480Hz_MAX_VAL - 18'd1);
    
    //--------------------
    
    logic [2:0]  cnt_an_on;
    logic an_0_on;
    logic an_1_on;
    logic an_2_on;
    logic an_3_on;
    logic an_4_on;
    logic an_5_on;
    logic an_6_on;
    logic an_7_on;
    
    always_ff @(posedge clk_100MHz_i) begin 
        if (!rst_n)
            cnt_an_on <= 3'd0;
        else if (en_480Hz) begin
            cnt_an_on <= cnt_an_on + 3'd1;
            end
    end
    
    always_comb an_0_on = cnt_an_on == 3'd0;
    always_comb an_1_on = cnt_an_on == 3'd1;
    always_comb an_2_on = cnt_an_on == 3'd2;
    always_comb an_3_on = cnt_an_on == 3'd3;
    always_comb an_4_on = cnt_an_on == 3'd4;
    always_comb an_5_on = cnt_an_on == 3'd5;
    always_comb an_6_on = cnt_an_on == 3'd6;
    always_comb an_7_on = cnt_an_on == 3'd7;
    
    //--------------------
    logic [31:0] hex_val_1;
    logic [31:0] hex_val_2;
    
    
    dec_to_hex dec_to_hex0 (.num(cnt_val_1_i[15:12]), .hex(hex_val_1[31:24]));
    dec_to_hex dec_to_hex1 (.num(cnt_val_1_i[11:8 ]), .hex(hex_val_1[23:16]));
    dec_to_hex dec_to_hex2 (.num(cnt_val_1_i[ 7:4 ]), .hex(hex_val_1[15:8 ]));
    dec_to_hex dec_to_hex3 (.num(cnt_val_1_i[ 3:0 ]), .hex(hex_val_1[ 7:0 ]));
    dec_to_hex dec_to_hex4 (.num(cnt_val_2_i[15:12]), .hex(hex_val_2[31:24]));
    dec_to_hex dec_to_hex5 (.num(cnt_val_2_i[11:8 ]), .hex(hex_val_2[23:16]));
    dec_to_hex dec_to_hex6 (.num(cnt_val_2_i[ 7:4 ]), .hex(hex_val_2[15:8 ]));
    dec_to_hex dec_to_hex7 (.num(cnt_val_2_i[ 3:0 ]), .hex(hex_val_2[ 7:0 ]));
    
    //--------------------
    
    always_comb AN_o = ~{an_7_on, an_6_on, an_5_on, an_4_on,
                        an_3_on, an_2_on, an_1_on, an_0_on};
    
    always_comb case(cnt_an_on)
        3'd7: HEX_o = hex_val_1[31:24];
        3'd6: HEX_o = hex_val_1[23:16];
        3'd5: HEX_o = hex_val_1[15:8 ];
        3'd4: HEX_o = hex_val_1[ 7:0 ];
        3'd3: HEX_o = hex_val_2[31:24];
        3'd2: HEX_o = hex_val_2[23:16];
        3'd1: HEX_o = hex_val_2[15:8 ];
        3'd0: HEX_o = hex_val_2[ 7:0 ];
    endcase
    
endmodule
