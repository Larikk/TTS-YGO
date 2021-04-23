import tkinter as tk
from tkinter import ttk
import boxtexture.creator as creator
import lib.imgur as imgur

imgur = imgur.Client("JuyjXZW")

class App(tk.Tk):
    def __init__(self):
        super().__init__()
        self.title('Tkinter StringVar')
        self.geometry("300x100")

        self.path_var = tk.StringVar()
        self.name_var = tk.StringVar()

        self.columnconfigure(0, weight=1)
        self.columnconfigure(1, weight=1)

        self.create_widgets()

    def create_widgets(self):

        padding = {'padx': 5, 'pady': 5}
        # labels
        ttk.Label(self, text='Path:').grid(column=0, row=0, **padding)
        ttk.Label(self, text='Name:').grid(column=0, row=1, **padding)

        # Entries
        path_entry = ttk.Entry(self, textvariable=self.path_var)
        path_entry.grid(column=1, row=0, **padding)
        path_entry.focus()

        name_entry = ttk.Entry(self, textvariable=self.name_var)
        name_entry.grid(column=1, row=1, **padding)

        # Button
        upload_button = ttk.Button(self, text='Upload', command=self.upload)
        upload_button.grid(column=2, row=3, **padding)


    def upload(self):
        path = self.path_var.get().strip()
        name = self.name_var.get().strip()

        creator.create(path)
        imgur.uploadLocalImage(name, "box.png")

        print(self.path_var.get())
        print(self.name_var.get())


if __name__ == "__main__":
    app = App()
    app.mainloop()