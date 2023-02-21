import datetime
import os
import sqlite3
import subprocess
import sys
import tempfile

EDITOR = os.environ.get("EDITOR", "vim")

COMMANDS = ["create", "list", "update", "start", "stop", "log"]

db = sqlite3.connect("test.sqlite")
cursor = db.cursor()

cursor.execute("""CREATE TABLE IF NOT EXISTS tasks (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL,
    description TEXT,
    done BOOLEAN
)""")
cursor.execute("""CREATE TABLE IF NOT EXISTS tasks_tags (
    task_id INTEGER NOT NULL,
    tag TEXT
)""")
cursor.execute("""CREATE TABLE IF NOT EXISTS worklog (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    task_id INTEGER NOT NULL,
    start_date INTEGER NOT NULL,
    end_date INTEGER
)""")

class Task:
    id = ""
    title = ""
    description = ""
    tags = []
    done = "false"

    def to_string(self):
        return "tags: " + ", ".join(self.tags) + "\n" + "done: " + self.done + "\n" + "\n" + "title: " + self.title + "\n" + "\n" + "description: " + self.description

    def from_string(self, string):
        lines = string.split('\n')

        tags_line = lines[0]
        doneçline = lines[1]
        title_line = lines[3]
        description = "\n".join(lines[5:])

        tags_list = tags_line.split("tags:")[1]
        self.tags = map(lambda e: e.strip(), tags_list.split(","))

        self.done = doneçline.split("done:")[1].strip()
        self.title = title_line.split("title:")[1].strip()
        self.description = description.split("description:")[1].strip()

def open_editor(task):
    with tempfile.NamedTemporaryFile() as tmp_file:
        tmp_file.write(task.to_string().encode("utf-8"))
        tmp_file.flush()

        subprocess.call([EDITOR, tmp_file.name])

        tmp_file.seek(0)
        new_content = tmp_file.read().decode("utf-8")

        new_task = Task()
        new_task.from_string(new_content)
        return new_task

def create():
    task = open_editor(Task())

    cursor.execute("INSERT INTO tasks (title, description, done) VALUES (?, ?, ?)", (task.title, task.description, task.done))
    task.id = str(cursor.lastrowid)

    for tag in task.tags:
        cursor.execute("INSERT INTO tasks_tags VALUES (?, ?)", (task.id, tag))

    db.commit()

def update(id):
    stored_task = cursor.execute("SELECT * from tasks WHERE id = ?", (id)).fetchone()
    stored_tags = cursor.execute("SELECT tag FROM tasks_tags WHERE task_id = ?", (id)).fetchall()

    task = Task()
    task.id = stored_task[0]
    task.title = stored_task[1]
    task.description = stored_task[2]
    task.tags = map(lambda e: e[0], stored_tags)

    updated_task = open_editor(task)

    cursor.execute("DELETE FROM tasks_tags WHERE task_id = ?", (id))

    cursor.execute("UPDATE tasks SET title = ?, description = ? WHERE id = ?", (updated_task.title, updated_task.description, id))
    task.id = str(cursor.lastrowid)

    for tag in updated_task.tags:
        cursor.execute("INSERT INTO tasks_tags VALUES (?, ?)", (id, tag))

    db.commit()

def list():
    tasks = cursor.execute("SELECT t.id, t.title, group_concat(tt.tag, ', #') FROM tasks t LEFT JOIN tasks_tags tt ON t.id = tt.task_id GROUP BY t.id").fetchall()

    for entry in tasks:
        displayed_line = f"[{str(entry[0])}] {entry[1]}"

        if len(entry[2]) > 0:
            displayed_line = displayed_line + f" (#{entry[2]})"
        
        print(displayed_line)

def start(id):
    now = int(datetime.datetime.now().timestamp())
    cursor.execute("INSERT INTO worklog (task_id, start_date) VALUES (?, ?)", (id, now))
    db.commit()

def stop():
    now = int(datetime.datetime.now().timestamp())
    current_log_entry = cursor.execute("SELECT id FROM worklog WHERE end_date IS NULL").fetchone()
    cursor.execute("UPDATE worklog SET end_date = ? WHERE id = ?", (now, current_log_entry[0]))
    db.commit()

def log():
    today_log = cursor.execute("SELECT t.id, t.title, sum(wl.end_date - wl.start_date) FROM worklog wl INNER JOIN tasks t ON wl.task_id = t.id GROUP BY t.id").fetchall()

    for entry in today_log:
        print(f"[{entry[0]}] {entry[1]}: {entry[2] / 3600:.2f}h")

if __name__ == "__main__":
    if len(sys.argv) == 1 or sys.argv[1] not in COMMANDS:
        print("wrong command")
        sys.exit(1)

    command = sys.argv[1]
    args = sys.argv[2:]

    if command == "create":
        create()
    elif command == "list":
        list()
    elif command == "update":
        update(args[0])
    elif command == "start":
        start(args[0])
    elif command == "stop":
        stop()
    elif command == "log":
        log()

    # now = datetime.datetime.now()
    # today = datetime.date.today()
    # today_timestamp = datetime.datetime(year=today.year, month=today.month, day=today.day)
    # print(now)
    # print(today)
    # print(today_timestamp)
