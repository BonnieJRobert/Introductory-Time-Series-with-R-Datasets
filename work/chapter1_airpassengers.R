data(AirPassengers)
AP <- AirPassengers
AP
class(AP)
start(AP)
end(AP)
frequency(AP)
plot(
  AP,
  ylab = "Number of Passengers",
  xlab = "Year",
  main = "Monthly Airline Passenger Numbers 1949-1960"
)
# trend: a systematic change that does not appear to be periodic
# seasonal variation: applied generally to repeating patterns within any fixed period of time (e.g. days of the week)
# cycles: pattern that do not correspond to some fix ed period of time (e.g. business cycles)
# general assumption: in the absence of some shock to the system, trends generally change slowly => linear extrapolation is reasonable.
