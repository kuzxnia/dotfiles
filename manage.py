#!/usr/bin/env python3
from __future__ import print_function

import os
import argparse
import pathlib
import subprocess
import logging
from time import sleep
from importlib.util import find_spec
import sys
import json
import pprint
from collections import OrderedDict


logging.basicConfig(format='%(asctime)s - %(name)s - %(levelname)s - %(message)s', level=logging.DEBUG)
log = logging.getLogger(__name__)
is_debug_on = bool(os.environ.get('DEBUG'))
log.disabled = not is_debug_on


class InstalationStatistic:
    SUCCES = 0
    FAIL = 0
    SKIP = 0

    @classmethod
    def summarize(cls):
        print(
            '{}Installed sucessfuly {}, skipped {}, failed {}{}'
            .format(
                '\033[92m' if cls.FAIL == 0 else '\033[91m',
                cls.SUCCES,
                cls.SKIP,
                cls.FAIL,
                ' stderr logs in .dotfiles.log' if cls.FAIL != 0 else ''
            )
        )


def sort_by_key(key):
    key = key.split(':')
    if len(key) > 1:
        order, key = key
    else:
        order = None
        if key in ConfigParser.default_import_order:
            return ConfigParser.default_import_order.index(key)
    return float(order or float('nan'))


def get_key_without_order(key):
    *_, key = key.split(':')

    return key


class ConfigParser:
    default_import_order = ['apt', 'pip', 'execute', 'clone', 'link']
    actions = {
        'apt': lambda lib: 'sudo apt-get install -y {}'.format(lib),  # if check_apt_installed(lib) else None,
        'pip': lambda lib: 'yes | pip3 install {0}; yes | sudo pip3 install {0}'.format(lib),
        'clone': lambda url: f'git clone {url}',
        'execute': lambda command: command,
        'link': lambda path: f"mkdir -p $HOME/{os.path.dirname(path)} && ln -sf $HOME/.dotfiles/{path} $HOME/{path}"
    }
    validation_actions = {
        'not_exists': lambda path: is_directory_exists(path),
        'not_installed': lambda command: not check_installed(command)
    }

    def __init__(self, path):
        with open(path, 'r') as config_file:
            data = json.load(config_file)

        self.dotfiles = self.load(data)

    def load(self, data: dict):
        dotfiles = OrderedDict()

        if isinstance(data, (list, str)):
            return data

        for key in sorted(data.keys(), key=sort_by_key):
            pure_key = get_key_without_order(key)

            dotfiles[pure_key] = self.load(data[key])
        return dotfiles

    def install(self):
        lst = self.get_instruction_lst(self.dotfiles)
        with open('t.sh', 'w') as f:
            f.writelines(line + '\n' for line in lst)

    def get_instruction_lst(self, dotfiles):
        instructions = []
        for app, vals in dotfiles.items():
            if confirm(f'Do you want do install {app} [y]: '):
                instructions.extend(
                    self.handle_instruction(vals)
                )
            print(instructions)
        return instructions

    def handle_instruction(self, data):
        instructions = []

        def _handle_instruction(data, instruction=None):
            func = self.actions.get(instruction)

            if isinstance(data, str) and func:
                return instructions.append(func(data))
            elif isinstance(data, list):
                for val in data:
                    _handle_instruction(val, instruction)
            elif isinstance(data, dict) and self.validate(data):
                for instruction, commands in self.filtered_actions(data):
                    func = self.actions.get(instruction)
                    _handle_instruction(commands, instruction)

            return instructions
        return _handle_instruction(data)

    def validate(self, data: dict):
        if isinstance(data, dict) and any(key in self.validation_actions for key in data):
            for instruction, command in data.items():
                if instruction in self.validation_actions:
                    return self.validation_actions[instruction](command)
        return True

    def filtered_actions(self, data):
        for instr, command in data.items():
            if instr not in self.validation_actions:
                yield instr, command

def execute():
    if find_spec('tqdm'):
        from tqdm import tqdm
    else:
        tqdm = lambda x, *args, **kwargs: x  # noqa: E731


    commands_amound = sum(
        1 if not isinstance(command, tuple) else len(command)-1
        for command in via_apt + via_pip + via_os + link_files
    )

    for command in tqdm(gen_commands(), msg, total=commands_amound, smoothing=0.5):
        print(command)
        # run(command)


def is_directory_exists(path):
    return pathlib.Path(path).expanduser().exists()


def check_installed(command):
    return bool(subprocess.run(command, shell=True, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL).returncode)


def check_apt_installed(package):
    return check_installed('dpkg --get-selections | grep -q "^{}*[[:space:]]*install$"'.format(package))


def run(command):
    if not is_debug_on:
        sleep(0.1)  # pleasing to the eye, debug off

    if not command:
        InstalationStatistic.SKIP += 1
        log.debug('Command skipped.')
        return

    log.debug('Executing command=%s', command)

    output = subprocess.run(command, shell=True, stdout=subprocess.DEVNULL, stderr=subprocess.PIPE)

    if output.returncode == 0:
        log.debug('Command executed succesfuly.')
        InstalationStatistic.SUCCES += 1
    else:
        log.error('Found errors %r', output.stdout)
        InstalationStatistic.FAIL += 1
        if not is_debug_on:
            with open('.dotfiles.log', 'ab') as f:
                f.write(output.stderr)
        else:
            sys.exit()  # to fail docker build


def confirm(message):
    output = input('{}{}'.format('\033[91m', message))

    if output in '1;Tak;tak;True;true;Y;y;T;t'.split(";"):
        return True
    return False


def parse_args():
    parser = argparse.ArgumentParser()
    # parser.set_defaults('')
    parser.add_argument("--config_file", required=True, help="Path to configuration file")
    return parser.parse_args()


if __name__ == '__main__':
    log.debug('Starting dotfiles import.')

    if not bool(subprocess.run('groups | grep -q "\\bsudo\b"', shell=True, stdout=subprocess.PIPE).returncode):
        print('Sudo not set. Exit.')
        sys.exit(0)

    path = parse_args().config_file

    config = ConfigParser(path)
    config.install()
    # InstalationStatistic.summarize()
