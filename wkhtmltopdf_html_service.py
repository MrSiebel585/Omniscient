import os
import time
from watchdog.observers import Observer
from watchdog.events import FileSystemEventHandler
import subprocess

class HTMLHandler(FileSystemEventHandler):
    def on_created(self, event):
        if event.src_path.endswith(".html"):
            self.convert_to_pdf(event.src_path)
    
    def convert_to_pdf(self, html_path):
        pdf_path = html_path.replace('.html', '.pdf')
        command = ['wkhtmltopdf', html_path, pdf_path]
        subprocess.run(command)
        print(f"Converted {html_path} to {pdf_path}")

if __name__ == "__main__":
    path_to_watch = "/path/to/watch"  # Change to the directory you want to monitor
    event_handler = HTMLHandler()
    observer = Observer()
    observer.schedule(event_handler, path_to_watch, recursive=False)
    observer.start()
    print(f"Monitoring {path_to_watch} for new .html files...")

    try:
        while True:
            time.sleep(1)
    except KeyboardInterrupt:
        observer.stop()
    observer.join()
