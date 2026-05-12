import http.server
import datetime
import os

class RitualHandler(http.server.SimpleHTTPRequestHandler):
    def do_GET(self):
        # Si la petición es para una agenda, extraemos el nombre del usuario
        if "agendas/" in self.path:
            # Extraemos el nombre del archivo (ej: hola.txt) y quitamos el .txt
            usuario = os.path.basename(self.path).replace(".txt", "")
            fecha_hora = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
            
            # Guardamos en el log
            log_line = f"[{fecha_hora}] Conexión detectada - Usuario: {usuario}\n"
            with open("nivel5/conexiones.log", "a") as log_file:
                log_file.write(log_line)
            
            print(f"[LOG] {log_line.strip()}")

        # Continuamos con la descarga normal del archivo
        return http.server.SimpleHTTPRequestHandler.do_GET(self)

print("=== ARTEMIS RITUAL SERVER: ESCUCHANDO Y LOGUEANDO ===")
http.server.HTTPServer(('0.0.0.0', 8000), RitualHandler).serve_forever()
