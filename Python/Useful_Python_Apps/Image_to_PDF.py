from fpdf import FPDF

pdf = FPDF()
for image in imagelist:
  pdf.add_page()
  pdf.image(image,x,y,w,h)
  pdf.output("yourfile.pdf", "F")