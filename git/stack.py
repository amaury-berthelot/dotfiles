#!/usr/bin/python3

import os
import sys
import re
import subprocess

class Stack:
    stacked_branch_name_regex = re.compile('^(.*)-(\d+)$')

    def __init__(self, branch_name):
        stack_details = self.parse_branch_name(branch_name)

        self.name = stack_details['name']
        self.prefix = self.name + "-"
        self.current_position = stack_details['number']
        self.branches = self.get_branches()
        self.stack_top_position = self.get_higher_branch_number(self.branches)

    def parse_branch_name(self, branch_name):
      stack_match = self.stacked_branch_name_regex.match(branch_name)

      if stack_match:
        return { "name": stack_match.group(1), "number": int(stack_match.group(2)) }
      else:
        raise Exception("Not a stacked branch")

    def get_branches(self):
        all_branches = exec_command("git for-each-ref --format '%(refname:short)' refs/heads/").split('\n')
        branches_of_stack = list(filter(lambda branch: branch.startswith(self.prefix), all_branches))
        return branches_of_stack

    def get_higher_branch_number(self, branches):
        branches_numbers = map(lambda branch: self.parse_branch_name(branch)['number'], branches)
        return max(branches_numbers)

    def show_status(self):
        result = exec_command("git branch --verbose --list \"" + self.name + "-*\"")
        print(result)

    def go_to_branch_number(self, number):
        exec_command("git checkout " + self.name + "-" + str(number))

    def add_to_stack(self):
        if self.current_position == self.stack_top_position:
            exec_command("git checkout -b " + self.prefix + str(self.stack_top_position + 1))
        else:
            raise Exception("Can only add to stack from the stack top")
    
    def rebase_on_branch_number(self, number):
        subprocess.call(["git", "rebase", "-i", self.prefix + str(number)])


def get_current_branch():
  return exec_command("git branch --show-current").strip()

def exec_command(command):
  output_stream = os.popen(command)
  output = output_stream.read()
  output_stream.close()
  return output.strip('\n')

def handle_command(args):
    command_handlers = {
        "checkout": handle_checkout,
        "status": handle_status,
        "push": handle_push,
        "rebase": handle_rebase
    }

    if len(args) != 0 and args[0] in command_handlers:
        command_handler = command_handlers[args[0]]
        command_handler(args[1:])
    else:
        print_help()

def handle_checkout(args):
    if len(args) == 1:
        stack = init_stack()
        stack.go_to_branch_number(args[0])
    else:
        raise Exception("expected usage is \"checkout <branch number>\"")

def handle_status(args):
    if len(args) == 0:
        stack = init_stack()
        stack.show_status()
    else:
        raise Exception("expected usage is \"status\"")

def handle_push(args):
    if len(args) == 0:
        stack = init_stack()
        stack.add_to_stack()
    else:
        raise Exception("expected usage is \"push\"")

def handle_rebase(args):
    if len(args) == 1:
        stack = init_stack()
        stack.rebase_on_branch_number(args[0])
    else:
        raise Exception("expected usage is \"rebase <branch number>\"")

def init_stack():
    return Stack(get_current_branch())

def print_help():
    print('''Usage: <action> [args]
Possible actions are:
    - status                      list the branches of the stack
    - checkout <branch number>    go to the given branch in the stack
    - push                        add a new branch to the stack
    - rebase <branch number>      rebase the current branch with another
                                  branch of the stack''')

if __name__ == '__main__':
    try:
        handle_command(sys.argv[1:])
    except Exception as err:
        print("Error: " + str(err))
