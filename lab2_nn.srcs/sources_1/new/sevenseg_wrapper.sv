module sevenseg_wrapper(
    input  logic [3:0] SW,
    output logic [6:0] HEX0,
    output logic [7:0] AN
);

    sevenseg decoder (
        .data(SW),
        .segments(HEX0)
    );

    // Active-low: enable right-most digit only
    assign AN = 8'b11111110;

endmodule