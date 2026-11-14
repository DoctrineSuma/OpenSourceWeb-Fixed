//"fancy" math for calculating time in ms from tick_usage percentage and the length of ticks
//percent_of_tick_used * (ticklag * 100(to convert to ms)) / 100(percent ratio)
//collapsed to percent_of_tick_used * tick_lag
// Math constants.

#define R_IDEAL_GAS_EQUATION       8.31    // kPa*L/(K*mol).
#define ONE_ATMOSPHERE             101.325 // kPa.
#define IDEAL_GAS_ENTROPY_CONSTANT 1164    // (mol^3 * s^3) / (kg^3 * L).

// Radiation constants.

#define COLDCAVE  253.15 //    -20.0 degrees celcius
#define COLDDIRT  263.15 //    -10.0 degrees celcius
#define T0C  273.15 //    0.0 degrees celcius
#define T20C 293.15 //   20.0 degrees celcius
#define TCMB 2.7    // -270.3 degrees celcius

#define CLAMP01(x) max(0, min(1, x))
#define ATMOS_PRECISION 0.0001
#define QUANTIZE(variable) (round(variable, ATMOS_PRECISION))
