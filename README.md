# VibrationDetection
This repository contains MATLAB script and Arduino code for Project I worked on detection of industrial vibrations and issue a warning if vibrations exceeds threshold.  
Most industrial devices are engineered to operate smoothly and avoid vibration, not produce it. In these machines, excess vibration can indicate problems or deterioration in the equipment. If the underlying causes are not corrected, the unwanted vibration itself can cause additional damage.If the vibrations in a machine exceed certain threshold value, it could lead to machine part damage or even damages to the humans working around it. It would be of great importance if we can visualize on screen the direction of vibration or movement and the intensity with which the vibrations are taking place.

*MPU 6050:*
The sensor MPU6050 contains MEMS accelerometer and a MEMS gyro scope in a single chip. MPU stands for ‘Motion Processor Unit’. It is very accurate, as it contains 16-bits analog to digital conversion hardware for each channel. Therefore it captures the x, y and z channel simultaneously at the same time. The sensor uses the I2C-bus to interface with the Atmega-328 controller.

*FTDI Basic:*
This is a programmer module designed by Future Technology Devices International which is can be used to upload the code in the arduino IDE. Uses USB to serial converter. It requires 3.3V/5V power supply. It also has a direct to reset (DTR).
