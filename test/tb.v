 `timescale 1ns/1ps

module tb_gray_counter;

    // DUT signals
    reg  clk;
    reg  rst_n;
    reg  [7:0] ui_in;
    reg  [7:0] uio_in;
    wire [7:0] uo_out;
    wire [7:0] uio_out;
    wire [7:0] uio_oe;

    // Instantiate DUT
    tt_um_gray_counter dut (
        .ui_in(ui_in),
        .uo_out(uo_out),
        .uio_in(uio_in),
        .uio_out(uio_out),
        .uio_oe(uio_oe),
        .clk(clk),
        .rst_n(rst_n)
    );
    initial begin
    $dumpfile("tb.vcd");
    $dumpvars(0, tb);
    #1;
  end
    // Clock generator (10ns period = 100 MHz)
    always #5 clk = ~clk;

    initial begin
        // Init
        clk    = 0;
        rst_n  = 0;
        ui_in  = 8'h00;
        uio_in = 8'h00;

        // Apply reset
        #20 rst_n = 1;

        // Run simulation for 20 cycles
        repeat (20) begin
            @(posedge clk);
            $display("Time=%0t, Gray=%b", $time, uo_out);
        end

        $finish;
    end

endmodule

