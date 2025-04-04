`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.04.2025 17:26:41
// Design Name: 
// Module Name: wrapper_tb
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


module wrapper_tb();
    logic CLK100MHZ;
    logic [15:0] SW;
    
    logic [15:0] LED;
    logic CPU_RESETN;
    logic CA;
    logic CB;
    logic CC;
    logic CD;
    logic CE;
    logic CF;
    logic CG;
    logic DP;
    logic [7:0] AN;     
    wrapper wp (
        .CLK100MHZ(CLK100MHZ),
        .SW(SW),
        .CPU_RESETN(CPU_RESETN),
        .LED(LED),
        .CA(CA),
        .CB(CB),
        .CC(CC),
        .CD(CD),
        .CE(CE),
        .CF(CF),
        .CG(CG),
        .DP(DP),
        .AN(AN)
    );
    initial begin 
        SW[7] <= 0;
        CPU_RESETN <= 1;
        #10;
        CPU_RESETN <= 0;
        
    end
    
    initial begin
    forever begin
        CLK100MHZ <= 1;
        #5;
        CLK100MHZ <= 0;
        #5;
    end
    end

endmodule
