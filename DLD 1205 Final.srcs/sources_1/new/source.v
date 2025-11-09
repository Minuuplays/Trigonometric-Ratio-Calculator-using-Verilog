`timescale 1ns / 1ps

// Top-level module with button inputs and seven-segment display
module triRatio_top(
    input clk,                      // System clock
    input BTNU,                     // Button for sin
    input BTNL,                     // Button for cos
    input BTNR,                     // Button for tan
    input BTND,                     // Button for cot
    input [8:0] angle_deg,          // Angle input (from switches)
    output [6:0] seg,               // Seven-segment cathodes
    output [7:0] an,                // Seven-segment anodes (8 digits)
    output dp                       // Decimal point
);

    // Button debouncing and edge detection
    reg [2:0] sel_reg;
    reg compute_reg;
    wire [15:0] result;
    
    // Debounced button signals
    wire btnu_db, btnl_db, btnr_db, btnd_db;
    
    // Instantiate debouncer for each button
    debouncer db_u(.clk(clk), .btn(BTNU), .btn_db(btnu_db));
    debouncer db_l(.clk(clk), .btn(BTNL), .btn_db(btnl_db));
    debouncer db_r(.clk(clk), .btn(BTNR), .btn_db(btnr_db));
    debouncer db_d(.clk(clk), .btn(BTND), .btn_db(btnd_db));
    
    // Button to selector mapping
    always @(posedge clk) begin
        compute_reg <= 0;
        if (btnu_db) begin
            sel_reg <= 3'b000;      // sin
            compute_reg <= 1;
        end
        else if (btnl_db) begin
            sel_reg <= 3'b001;      // cos
            compute_reg <= 1;
        end
        else if (btnr_db) begin
            sel_reg <= 3'b010;      // tan
            compute_reg <= 1;
        end
        else if (btnd_db) begin
            sel_reg <= 3'b011;      // sin^2 + cos^2 = 1
            compute_reg <= 1;
        end
    end
    
    // Instantiate trigonometric calculator
    triRatio trig_calc(
        .angle_deg(angle_deg),
        .sel(sel_reg),
        .compute(compute_reg),
        .result(result)
    );
    
    // Instantiate seven-segment display controller
    seven_seg_display display(
        .clk(clk),
        .value(result),
        .seg(seg),
        .an(an),
        .dp(dp)
    );

endmodule

// Button debouncer module
module debouncer(
    input clk,
    input btn,
    output reg btn_db
);
    parameter DEBOUNCE_TIME = 20'd1000000; // ~10ms at 100MHz
    
    reg [19:0] counter;
    reg btn_sync_0, btn_sync_1;
    reg btn_state;
    
    always @(posedge clk) begin
        // Synchronize button input
        btn_sync_0 <= btn;
        btn_sync_1 <= btn_sync_0;
        
        btn_db <= 0;
        
        if (btn_sync_1 != btn_state) begin
            counter <= counter + 1;
            if (counter >= DEBOUNCE_TIME) begin
                btn_state <= btn_sync_1;
                counter <= 0;
                if (btn_sync_1) // Rising edge
                    btn_db <= 1;
            end
        end else begin
            counter <= 0;
        end
    end
endmodule

// Seven-segment display controller
module seven_seg_display(
    input clk,
    input [15:0] value,             // Fixed-point value (4.12 format)
    output reg [6:0] seg,
    output reg [7:0] an,
    output reg dp
);
    // Refresh counter for multiplexing
    reg [19:0] refresh_counter;
    wire [1:0] digit_select;
    
    // Convert fixed-point to decimal digits
    reg [3:0] digit [3:0];
    reg sign;
    reg [15:0] abs_value;
    integer decimal_value;
    integer i;
    
    assign digit_select = refresh_counter[19:18];
    
    always @(posedge clk) begin
        refresh_counter <= refresh_counter + 1;
    end
    
    // Convert fixed-point to decimal
    always @(*) begin
        // Extract sign and absolute value
        sign = value[15];
        abs_value = sign ? (~value + 1) : value;
        
        // Convert to decimal (value / 4096 gives integer, multiply by 100 for 2 decimal places)
        decimal_value = (abs_value * 100) / 4096;
        
        // Extract individual digits for -X.XX format
        // digit[3] = sign/blank, digit[2] = integer, digit[1] = first decimal, digit[0] = second decimal
        digit[3] = sign ? 4'd11 : 4'd10;        // Sign or blank
        digit[2] = (decimal_value / 100) % 10;  // Integer part
        digit[1] = (decimal_value / 10) % 10;   // First decimal
        digit[0] = decimal_value % 10;          // Second decimal
    end
    
    // Digit multiplexing
    always @(*) begin
        case(digit_select)
            2'd0: begin
                an = 8'b11111110;
                dp = 1'b1;  // No decimal point
            end
            2'd1: begin
                an = 8'b11111101;
                dp = 1'b1;  // No decimal point
            end
            2'd2: begin
                an = 8'b11111011;
                dp = 1'b0;  // Decimal point ON (after integer digit)
            end
            2'd3: begin
                an = 8'b11110111;
                dp = 1'b1;  // No decimal point
            end
        endcase
        
        // Decode digit to seven-segment
        case(digit[digit_select])
            4'd0: seg = 7'b1000000; // 0
            4'd1: seg = 7'b1111001; // 1
            4'd2: seg = 7'b0100100; // 2
            4'd3: seg = 7'b0110000; // 3
            4'd4: seg = 7'b0011001; // 4
            4'd5: seg = 7'b0010010; // 5
            4'd6: seg = 7'b0000010; // 6
            4'd7: seg = 7'b1111000; // 7
            4'd8: seg = 7'b0000000; // 8
            4'd9: seg = 7'b0010000; // 9
            4'd10: seg = 7'b1111111; // Blank
            4'd11: seg = 7'b0111111; // Minus sign
            default: seg = 7'b1111111; // Blank
        endcase
    end
endmodule

// Original trigonometric calculator module
module triRatio( 
    input [8:0] angle_deg,        // Angle in degrees (0-359)
    input [2:0] sel,              // Operation selector
    input compute,                // Trigger calculation
    output reg [15:0] result      // 16-bit fixed-point result (4.12 format)
);

    reg signed [31:0] x_rad;
    reg signed [31:0] sin_val;
    reg signed [31:0] cos_val;
    reg signed [31:0] temp;
    
    parameter PI_SCALED = 32'd12868;
    parameter ONE_SCALED = 32'd4096;
    
    always @(*) begin
        if (compute) begin
            x_rad = (angle_deg * PI_SCALED) / 180;
            
            // Calculate sine
            sin_val = x_rad;
            temp = (x_rad * x_rad) >>> 12;
            temp = (temp * x_rad) >>> 12;
            temp = temp / 6;
            sin_val = sin_val - temp;
            
            temp = (x_rad * x_rad) >>> 12;
            temp = (temp * x_rad) >>> 12;
            temp = (temp * x_rad) >>> 12;
            temp = (temp * x_rad) >>> 12;
            temp = temp / 120;
            sin_val = sin_val + temp;
            
            temp = (x_rad * x_rad) >>> 12;
            temp = (temp * x_rad) >>> 12;
            temp = (temp * x_rad) >>> 12;
            temp = (temp * x_rad) >>> 12;
            temp = (temp * x_rad) >>> 12;
            temp = (temp * x_rad) >>> 12;
            temp = temp / 5040;
            sin_val = sin_val - temp;
            
            // Calculate cosine
            cos_val = ONE_SCALED;
            temp = (x_rad * x_rad) >>> 12;
            temp = temp / 2;
            cos_val = cos_val - temp;
            
            temp = (x_rad * x_rad) >>> 12;
            temp = (temp * x_rad) >>> 12;
            temp = (temp * x_rad) >>> 12;
            temp = temp / 24;
            cos_val = cos_val + temp;
            
            temp = (x_rad * x_rad) >>> 12;
            temp = (temp * x_rad) >>> 12;
            temp = (temp * x_rad) >>> 12;
            temp = (temp * x_rad) >>> 12;
            temp = (temp * x_rad) >>> 12;
            temp = temp / 720;
            cos_val = cos_val - temp;
            
            // Select operation
            case(sel)
                3'b000: result = sin_val[15:0];
                3'b001: result = cos_val[15:0];
                3'b010: begin
                    if (cos_val != 0)
                        result = (sin_val <<< 12) / cos_val;
                    else
                        result = 16'hFFFF;
                end
                3'b011: result = 16'h1000;  // sin^2 + cos^2 = 1 (always 1.0 in 4.12 format)
                default: result = 16'h0000;
            endcase
        end
    end

endmodule