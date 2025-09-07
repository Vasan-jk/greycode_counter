
  // Dump the signals to a VCD file. You can view it with gtkwave or surfer.


// tb_gray_counter.v
`timescale 1ns/1ps

module tb_gray_counter;
    reg clk;
    reg rst_n;
    wire [7:0] gray;


     initial begin
    $dumpfile("tb.vcd");
    $dumpvars(0, tb);
    #1;
  end
    // Instantiate DUT
    gray_counter dut (
        .clk(clk),
        .rst_n(rst_n),
        .gray(gray)
    );

    // Clock generator: 10ns period = 100MHz
    always #5 clk = ~clk;

    initial begin
        // init
        clk = 0;
        rst_n = 0;

        // apply reset
        #20 rst_n = 1;

        // run simulation for 20 cycles
        repeat (20) begin
            @(posedge clk);
            $display("Time=%0t, Gray=%b", $time, gray);
        end

        $stop;
    end
endmodule
