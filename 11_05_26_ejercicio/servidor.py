import http.server
import os
import datetime

class ArtemisHandler(http.server.SimpleHTTPRequestHandler):
    # Esta función se ejecuta cada vez que tú haces un POST desde nivel4.sh
    def do_POST(self):
        # 1. Leer cuántos bytes envías
        content_length = int(self.headers['Content-Length'])
        body = self.rfile.read(content_length)
        
        # 2. Obtener metadatos (fecha, hora, IP)
        fecha_hora = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        ip_cliente = self.client_address[0]
        
        # 3. Intentar extraer el nombre del agente del reporte para el log
        agente = "Agente Desconocido"
        try:
            lineas = body.decode('utf-8', errors='ignore').split('\n')
            for linea in lineas:
                if "REPORTE DE AGENTE:" in linea:
                    agente = linea.split(":")[1].strip()
                    break
        except:
            pass

        # 4. Guardar el contenido en el archivo único (reportes.log)
        with open('reportes.log', 'ab') as f:
            # Escribimos un encabezado con la información solicitada
            encabezado = f"\n[NUEVO REPORTE]\nFECHA/HORA: {fecha_hora}\nORIGEN (IP): {ip_cliente}\nUSUARIO: {agente}\n"
            f.write(encabezado.encode())
            f.write(b"-"*20 + b"\n")
            f.write(body)
            # Añadimos un separador final
            f.write(b"\n" + b"="*40 + b"\n")
            
        print(f"\n[!] ¡ALERTA! Reporte recibido de {agente} ({ip_cliente})")
        print(f"[i] Guardado en: reportes.log")
        
        # 4. Responder al cliente (a ti) que todo ha ido bien
        self.send_response(200)
        self.end_headers()
        self.wfile.write(b"RECIBIDO")

# Iniciamos el servidor en todas las interfaces (0.0.0.0) y puerto 8000
print("=== GROUND CONTROL: ESCUCHANDO EN EL PUERTO 8000 ===")
http.server.HTTPServer(('0.0.0.0', 8000), ArtemisHandler).serve_forever()