import matplotlib.pyplot as plt
import math
import numpy 
import pandas
import matplotlib.pyplot as plt

def calc_attenuation(sea_level_temp, rainfall_intensity, latitude):
  
  #parameters
  h0 = sea_level_temp
  hS = 0.6
  u = 30
  ff = latitude
  f = numpy.arange(1,31)

  #step 1:
  hR = h0 + 0.36

  #step 2:
  Ls = (hR - hS)/math.sin(math.radians(u))

  #step 3:
  LG = Ls * math.cos(math.radians(u))

  #step 4:
  R0_01 = rainfall_intensity

  #step 5:
  data = pandas.read_excel('Frequency-dependent coefficients.xlsx')
  k = data["kH"].values
  a = data["αH"].values
  gR = k * (R0_01 ** a)

  #step 6:
  r0_01 = 1 / (1 + 0.78 * numpy.sqrt((LG*gR)/f) - 0.38*(1 - math.exp(-2*LG)))
  
  #step 7:
  z = numpy.atan((hR - hS) / (LG * r0_01))
  if z.all() > u:
    LR = (LG*r0_01)/math.cos(math.radians(u))  
  else:
    LR = (hR - hS)/math.sin(math.radians(u))
  if abs(ff) < 36: 
    x = 36 - abs(ff) 
  else:
    x = 0
  n0_01 = 1/(1+math.sqrt(math.sin(math.radians(u)))*(31*(1 - math.exp(-1*(u/(1+x))))*(numpy.sqrt(LR*gR)/(f ** 2)) - 0.45))

  #step 8:
  LE = LR * n0_01

  #step 9:
  A0_01 = gR * LE
  return A0_01

# 1st climatic zone(latitude=-z=15, longitude=-135)
att1 = calc_attenuation(sea_level_temp=5, rainfall_intensity=19, latitude=-15)
print(att1)
f = numpy.arange(1,31)
plt.plot(att1, f)

# 2nd climatic zone(latitude=-15, longitude=-30)
att2 = calc_attenuation(sea_level_temp=5.5, rainfall_intensity=95, latitude=-15)
plt.plot(att2, f)

# 3rd climatic zone(latitude=0, longitude=-60)
att3 = calc_attenuation(sea_level_temp=5, rainfall_intensity=145, latitude=0)
plt.plot(att3, f)

# 4th climatic zone(latitude=-30, longitude=-90)
att4 = calc_attenuation(sea_level_temp=3.5, rainfall_intensity=22, latitude=-30)
plt.plot(att4, f)

plt.xlabel('x - attenuation')
plt.ylabel('y - frequency')
plt.title('Attenuation of the signals')
plt.legend()
plt.show()