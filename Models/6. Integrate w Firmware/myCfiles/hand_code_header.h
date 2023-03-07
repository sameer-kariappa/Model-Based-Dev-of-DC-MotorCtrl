#if defined HAND_CODE_HEADER_H
/* This file has already been included. */
#else

/* "Short-circuit" subsequent inclusions: */
#  define HAND_CODE_HEADER_H

extern double get_motor_refAngle( void );
extern double get_measuredAngle( void );
extern void   request_mtrCmd( const double vCommand );

#endif /* HAND_CODE_HEADER_H */