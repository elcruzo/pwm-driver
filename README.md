# pwm-driver

pwm generator for motor control. verilog.

## features

- configurable frequency
- 8-bit duty cycle resolution
- dead-time insertion for h-bridge
- dual channels

## build

open in vivado, synthesize, program.

## pins

see `constraints/basys3.xdc`

## frequency table

| sel | freq   |
|-----|--------|
| 0   | 1kHz   |
| 1   | 2kHz   |
| 2   | 4kHz   |
| 3   | 8kHz   |
| 4   | 16kHz  |
| 5   | 32kHz  |

## dead time

dead time prevents shoot-through in h-bridge drivers.
set via switches, value in clock cycles.
