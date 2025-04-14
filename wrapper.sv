`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.03.2025 09:36:49
// Design Name: 
// Module Name: wrapper
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

module wrapper(
    input logic CLK100MHZ,
    input logic [15:0] SW,
    input CPU_RESETN,
    
    output logic [15:0] LED,
    output CA,
    output CB,
    output CC,
    output CD,
    output CE,
    output CF,
    output CG,
    output DP,
    output [7:0] AN
    
    );
    
    logic lock;
    /*
    for m in range():
        fro n in range*(:
            for o1 inr a    
            
                if (800 < 100 * n / m < 1200 and abs(100 * n / m / o1) < 0.01)
    
    */
    
    PLLE2_BASE #(
      .BANDWIDTH("OPTIMIZED"),  // OPTIMIZED, HIGH, LOW
      .CLKFBOUT_MULT(63),  // 39       // Multiply value for all CLKOUT, (2-64)
      .CLKFBOUT_PHASE(0.0),     // Phase offset in degrees of CLKFB, (-360.000-360.000).
      // Please fix this 
      .CLKIN1_PERIOD(10),      // Input clock period in ns to ps resolution (i.e. 33.333 is 30 MHz).
      
      // CLKOUT0_DIVIDE - CLKOUT5_DIVIDE: Divide amount for each CLKOUT (1-128)
      .CLKOUT0_DIVIDE(23), // 39
      .CLKOUT1_DIVIDE(15), // 60
      .CLKOUT2_DIVIDE(1),
      .CLKOUT3_DIVIDE(1),
      .CLKOUT4_DIVIDE(1),
      .CLKOUT5_DIVIDE(1),
      // CLKOUT0_DUTY_CYCLE - CLKOUT5_DUTY_CYCLE: Duty cycle for each CLKOUT (0.001-0.999).
      .CLKOUT0_DUTY_CYCLE(0.5),
      .CLKOUT1_DUTY_CYCLE(0.5),
      .CLKOUT2_DUTY_CYCLE(0.5),
      .CLKOUT3_DUTY_CYCLE(0.5),
      .CLKOUT4_DUTY_CYCLE(0.5),
      .CLKOUT5_DUTY_CYCLE(0.5),
      // CLKOUT0_PHASE - CLKOUT5_PHASE: Phase offset for each CLKOUT (-360.000-360.000).
      .CLKOUT0_PHASE(0.0),
      .CLKOUT1_PHASE(70.0),
      .CLKOUT2_PHASE(0.0),
      .CLKOUT3_PHASE(0.0),
      .CLKOUT4_PHASE(0.0),
      .CLKOUT5_PHASE(0.0),
      .DIVCLK_DIVIDE(7),        // Master division value, (1-56)
      .REF_JITTER1(0.0),        // Reference input jitter in UI, (0.000-0.999).
      .STARTUP_WAIT("FALSE")    // Delay DONE until PLL Locks, ("TRUE"/"FALSE")
   )
   PLLE2_BASE_inst (
      // Clock Outputs: 1-bit (each) output: User configurable clock outputs
      .CLKOUT0(CLKOUT0),   // 1-bit output: CLKOUT0
      .CLKOUT1(CLKOUT1),   // 1-bit output: CLKOUT1
      .CLKOUT2(CLKOUT2),   // 1-bit output: CLKOUT2
      .CLKOUT3(CLKOUT3),   // 1-bit output: CLKOUT3
      .CLKOUT4(CLKOUT4),   // 1-bit output: CLKOUT4
      .CLKOUT5(CLKOUT5),   // 1-bit output: CLKOUT5
      // Feedback Clocks: 1-bit (each) output: Clock feedback ports
      .CLKFBOUT(CLKFBOUT), // 1-bit output: Feedback clock
      .LOCKED(lock),     // 1-bit output: LOCK
      .CLKIN1(CLK100MHZ),     // 1-bit input: Input clock
      // Control Ports: 1-bit (each) input: PLL control ports
      .PWRDWN(SW[7]),     // 1-bit input: Power-down
      .RST(~CPU_RESETN),           // 1-bit input: Reset
      // Feedback Clocks: 1-bit (each) input: Clock feedback ports
      .CLKFBIN(CLKFBOUT)    // 1-bit input: Feedback clock
   );
   // assign LED[0] = ~LOCKED;
   logic [33:0] count1;
   logic [33:0] count2;
   assign lck = lock;
   assign LED[0] = ~lock; 
   assign f1 = CLKOUT0;
   assign f2 = CLKOUT1;
   assign CPU_RESETN = &count1 | &count2;
   counter cnt1(
                .en(SW[0]),
                .clk(CLKOUT0),
                .rst(CPU_RESETN),
                
                .cnt(count1)
                );
         
	counter cnt2(
                .en(SW[0]),
                .clk(CLKOUT1),
                .rst(CPU_RESETN),
                
                .cnt(count2)
                );				
			
     cnt2hex c2x (
     .clk_100MHz_i(CLK100MHZ),
     .rst_n(CPU_RESETN),
     .cnt_val_1_i(count1[33:18]),
     .cnt_val_2_i(count2[33:18]),
     .HEX_o({DP, CG, CF, CE, CD, CC, CB, CA}),
     .AN_o(AN)
     );
    
endmodule
