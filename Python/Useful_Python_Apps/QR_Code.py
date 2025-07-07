import pyqrcode
import png
from pyqrcode import QRCode

S = "www.youtube.com"

url = pyqrcode.create(S)

url.svg("myqr.svg", scale = 8)

url.png('myqr.png', scale = 6)