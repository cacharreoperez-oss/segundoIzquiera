import os
from http.server import HTTPServer, BaseHTTPRequestHandler
from datetime import datetime

PUERTO = 8000
CARPETA_REPORTES = "reportes_clientes"

# Crea la carpeta donde se almacenarán los reportes
if not os.path.exists(CARPETA_REPORTES):
    os.makedirs(CARPETA_REPORTES)

class ReceptorReportes(BaseHTTPRequestHandler):
    def do_POST(self):
        # Lee la longitud del contenido recibido
        content_length = int(self.headers['Content-Length'])
        datos_recibidos = self.rfile.read(content_length).decode('utf-8')
        
        # Obtiene datos del remitente
        ip_cliente = self.client_address[0]
        fecha_actual = datetime.now().strftime("%Y%m%d_%H%M%S")
        
                # Guarda y acumula los reportes en el archivo único de ese día
        dia_actual = datetime.now().strftime("%Y-%m-%d")
        nombre_archivo = f"{CARPETA_REPORTES}/incidencias_asistente_familiar_{dia_actual}.log"
        with open(nombre_archivo, "a", encoding="utf-8") as archivo:
            archivo.write(f"\n[ORIGEN: {ip_cliente}] [HORA: {datetime.now().strftime('%H:%M:%S')}]\n")
            archivo.write(datos_recibidos)
            archivo.write("\n" + "="*50 + "\n")
        print(f"[+] Reporte acumulado en -> {nombre_archivo}")

        # Envía la confirmación de éxito al cliente
        self.send_response(200)
        self.send_header('Content-type', 'text/plain')
        self.end_headers()
        self.wfile.write(b"Conexion con Ground Control exitosa. Telemetria guardada.\n")

def iniciar():
    servidor = HTTPServer(('0.0.0.0', PUERTO), ReceptorReportes)
    print(f"=== Ground Control activo escuchando en el puerto {PUERTO} ===")
    print(f"Los reportes se guardaran en la carpeta: ./{CARPETA_REPORTES}/")
    try:
        servidor.serve_forever()
    except KeyboardInterrupt:
        print("\n[-] Apagando Ground Control...")
        servidor.server_close()

if __name__ == "__main__":
    iniciar()
