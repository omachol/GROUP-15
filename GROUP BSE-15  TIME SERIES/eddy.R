#importing data
data(AirPassengers)
#shows the that the data series is in time series format. 
class(AirPassengers)
# This is the start of the time series
start(AirPassengers)
# This is this end of the time series
end(AirPassengers)
#the cycles of this time series is 12 months in a year
frequency(AirPassengers)
# Shows how the number of passengers across the spectrum  
summary(AirPassengers)
plot(aggregate(AirPassengers(FUN=mean)))
boxplot(AirPassengers~cycle(AirPassengers))#sense of seasonal effect
# plots time series
plot(AirPassengers)
abline(reg = lm(AirPassengers~time(AirPassengers)))#for mean
plot(log(AirPassengers))# make variance equal
plot(diff(log(AirPassengers)))# makes mean constant

# determining values of p d and q to be used in the arima model
acf(AirPassengers)# series are not stationary
pacf(AirPassengers)
#use pacf and acf functions

pacf(diff(log(AirPassengers)))
# determines value of p

acf(diff(log(AirPassengers)))# determines value of q
# predicting future

fit<-arima(log(AirPassengers),c(0,1,1),seasonal = list(order=c(0,1,1),period = 12))
pred<-predict(fit,n.ahead = 10*12)
pred1<-2.718^pred$pred
ts.plot(AirPassengers,2.718^pred$pred,log = "y",lty = c(1,3))#predicted graph
# testing the model
datawide<-ts(AirPassengers,frequency = 12,start=c(1949,1),end = c(1959,12))
fit<-arima(log(datawide),c(0,1,1),seasonal = list(order=c(0,1,1),period=12))
pred<-predict(fit,n.ahead = 10*12)
pred1<-2.718^pred$pred
datal<-head(pred1,12)
predicted_1960<-round(datal,digits = 0)
original_1960<-tail(AirPassengers,12)
predicted_1960
original_1960
#### visualization
AirPassengers
barplot(predicted_1960, main="predicted values")
barplot(original_1960, main="original values")
plot(decompose(AirPassengers))

