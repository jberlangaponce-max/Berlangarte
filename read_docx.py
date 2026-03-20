import os
import zipfile
import xml.etree.ElementTree as ET

base_path = r"C:\Users\Usuario\Desktop\PORTFOLIO WEB"
docx_path = os.path.join(base_path, "IMAGENES PAGINA WEB", "CHULETA_Web.docx")

def extract_text(docx_file):
    try:
        if not os.path.exists(docx_file):
            return "File not found"
        doc = zipfile.ZipFile(docx_file)
        xml_content = doc.read('word/document.xml')
        doc.close()
        tree = ET.XML(xml_content)
        
        namespace = {'w': 'http://schemas.openxmlformats.org/wordprocessingml/2006/main'}
        paragraphs = []
        for p in tree.iterfind('.//w:p', namespace):
            texts = [node.text for node in p.iterfind('.//w:t', namespace) if node.text]
            if texts:
                paragraphs.append(''.join(texts))
        return '\n'.join(paragraphs)
    except Exception as e:
        return str(e)

print("--- DOCX CONTENT ---")
print(extract_text(docx_path))
