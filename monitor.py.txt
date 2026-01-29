import socket
import json
import time
from concurrent.futures import ThreadPoolExecutor, as_completed
from datetime import datetime

TIMEOUT = 1.5
PORTS = [80, 443, 22, 21, 8080, 8443, 3389, 445, 8291]  # 8291 MikroTik
MAX_THREADS = 50

def check_port(ip, port):
    try:
        s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        s.settimeout(TIMEOUT)
        return s.connect_ex((ip, port)) == 0
    except:
        return False
    finally:
        s.close()

def check_device(device):
    for port in PORTS:
        if check_port(device["ip"], port):
            return {
                "name": device["name"],
                "ip": device["ip"],
                "status": "online",
                "time": datetime.now().strftime("%H:%M:%S")
            }
    return {
        "name": device["name"],
        "ip": device["ip"],
        "status": "offline",
        "time": datetime.now().strftime("%H:%M:%S")
    }

def run_check():
    with open("devices.json", "r", encoding="utf-8") as f:
        devices = json.load(f)

    results = []
    checked_ips = set()

    with ThreadPoolExecutor(max_workers=MAX_THREADS) as executor:
        futures = []
        for d in devices:
            if d["ip"] not in checked_ips:
                checked_ips.add(d["ip"])
                futures.append(executor.submit(check_device, d))

        for f in as_completed(futures):
            results.append(f.result())

    with open("status.json", "w", encoding="utf-8") as f:
        json.dump(results, f, ensure_ascii=False, indent=2)

    print("✔ تحديث الحالة", datetime.now().strftime("%H:%M:%S"))

if __name__ == "__main__":
    while True:
        run_check()
        time.sleep(30)
