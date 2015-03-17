<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  <meta http-equiv="Content-Style-Type" content="text/css">
  <title>OouraFFT.h at master from alexbw's iPhoneFFT - GitHub</title>
  <meta name="Description" content="A simple FFT library for the iPhone, based on Ooura's FFT code. Built for oScope, now on the app store! http://www.itunes.com/apps/oscope/">
  <meta name="Generator" content="Cocoa HTML Writer">
  <meta name="CocoaVersion" content="1038.32">
  <style type="text/css">
    p.p1 {margin: 0.0px 0.0px 0.0px 0.0px; line-height: 18.0px; font: 12.0px Helvetica; background-color: #fcfcfc}
    p.p2 {margin: 0.0px 0.0px 0.0px 0.0px; line-height: 18.0px; font: 12.0px Helvetica; background-color: #fcfcfc; min-height: 14.0px}
  </style>
</head>
<body>
<p class="p1">//</p>
<p class="p1">// OouraFFT.h</p>
<p class="p1">// oScope</p>
<p class="p1">//</p>
<p class="p1">// Created by Alex Wiltschko on 10/14/09.</p>
<p class="p1">// This software is free because I love you.</p>
<p class="p1">// But remember: Prof Ooura did the hard work.</p>
<p class="p1">// A metaphor: Ooura raised the cow, slaughtered it, ground the beef,</p>
<p class="p1">// made the beef sausages, and delivered it to my fridge.</p>
<p class="p1">// I took it out of the fridge, microwaved it,</p>
<p class="p1">// slathered it with mustard and then called it dinner.</p>
<p class="p1">//</p>
<p class="p1">// Algorithm from fft4g.c</p>
<p class="p1">//</p>
<p class="p1">// Quirks and to-do's...</p>
<p class="p1">// * Rewrite to use single-precision (iPhone's single-precision abilities are more greaterer and betterest)</p>
<p class="p1">// - i'm not entirely familiar with the bit-reversal part of the FFT algorithm, so it might be a difficult rewrite</p>
<p class="p2"><br></p>
<p class="p1">// data[2*k] = R[k], 0&lt;=k&lt;n/2, real frequency data</p>
<p class="p1">// data[2*k+1] = I[k], 0&lt;k&lt;n/2, imaginary frequency data</p>
<p class="p1">// data[1] = R[n/2]</p>
<p class="p2"><br></p>
<p class="p2"><br></p>
<p class="p2"><br></p>
<p class="p1">#import &lt;Foundation/Foundation.h&gt;</p>
<p class="p1">#import "fft4g.h"</p>
<p class="p2"><br></p>
<p class="p1">// Define integer values for various windows</p>
<p class="p1">// NOTE: not using any windows that require parameter input.</p>
<p class="p1">#define kWindow_Rectangular 1</p>
<p class="p1">#define kWindow_Hamming 2</p>
<p class="p1">#define kWindow_Hann 3</p>
<p class="p1">#define kWindow_Bartlett 4</p>
<p class="p1">#define kWindow_Triangular 5</p>
<p class="p2"><br></p>
<p class="p2"><br></p>
<p class="p2"><br></p>
<p class="p1">@interface OouraFFT : NSObject {</p>
<p class="p1">double *inputData;</p>
<p class="p2"><br></p>
<p class="p1">int dataLength;</p>
<p class="p1">int numFrequencies;</p>
<p class="p1">BOOL dataIsFrequency;</p>
<p class="p2"><br></p>
<p class="p2"><br></p>
<p class="p1">double *window;</p>
<p class="p1">int windowType;</p>
<p class="p1">int numWindows;</p>
<p class="p1">int oldestDataIndex;</p>
<p class="p2"><br></p>
<p class="p1">double **allWindowedFFTs;</p>
<p class="p1">double *spectrumData;</p>
<p class="p1">// TODO: hold onto real and imaginary parts? no? maybe?</p>
<p class="p2"><br></p>
<p class="p1">}</p>
<p class="p2"><br></p>
<p class="p1">@property double *inputData;</p>
<p class="p2"><br></p>
<p class="p1">@property double *window;</p>
<p class="p1">@property int windowType;</p>
<p class="p1">@property int numWindows;</p>
<p class="p2"><br></p>
<p class="p1">@property int numFrequencies;</p>
<p class="p1">@property int dataLength;</p>
<p class="p1">@property double **allWindowedFFTs;</p>
<p class="p1">@property double *spectrumData;</p>
<p class="p2"><br></p>
<p class="p1">- (void)doFFT;</p>
<p class="p1">- (void)doIFFT;</p>
<p class="p2"><br></p>
<p class="p1">- (void)calculateWelchPeriodogramWithNewSignalSegment;</p>
<p class="p1">- (void)windowSignalSegment;</p>
<p class="p2"><br></p>
<p class="p1">- (id)initForSignalsOfLength:(int)numPoints andNumWindows:(int)numberOfWindows;</p>
<p class="p1">- (BOOL)checkDataLength:(int)inDataLength;</p>
<p class="p2"><br></p>
<p class="p1">- (void)setWindowType:(int)inWindowType;</p>
<p class="p2"><br></p>
<p class="p1">@end</p>
</body>
</html>
