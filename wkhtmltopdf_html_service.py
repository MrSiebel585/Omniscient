import os
import time
from watchdog.observers import Observer
from watchdog.events import FileSystemEventHandler
import subprocess

# Define a custom event handler that triggers when a new file is created
class HTMLHandler(FileSystemEventHandler):
    def on_created(self, event):
        """
        Called automatically whenever a new file/folder is created in the watched directory.
        If the file is an HTML file, trigger conversion to PDF.
        """
        if event.src_path.endswith(".html"):
            self.convert_to_pdf(event.src_path)
    
    def convert_to_pdf(self, html_path):
        """
        Convert the given HTML file to a PDF using wkhtmltopdf.
        - html_path: full path to the .html file that was created
        """
        pdf_path = html_path.replace('.html', '.pdf')  # Generate output path by swapping extension
        command = ['wkhtmltopdf', html_path, pdf_path]  # CLI command for conversion
        subprocess.run(command)  # Execute the system command
        print(f"Converted {html_path} to {pdf_path}")  # Log conversion result

if __name__ == "__main__":
    # Directory to monitor for new .html files
    path_to_watch = "/opt/omniscient/data/html"  # TODO: Replace with the actual directory you want

    # Set up the event handler and observer
    event_handler = HTMLHandler()
    observer = Observer()
    # Schedule the observer to monitor the directory (non-recursive: only top-level)
    observer.schedule(event_handler, path_to_watch, recursive=False)
    observer.start()
    print(f"Monitoring {path_to_watch} for new .html files...")

    try:
        # Keep the script running indefinitely, checking for new files
        while True:
            time.sleep(1)  # Prevents busy-waiting; observer handles events in the background
    except KeyboardInterrupt:
        # Gracefully stop monitoring if user interrupts with Ctrl+C
        observer.stop()
    observer.join()  # Wait until the observer thread fully stops
