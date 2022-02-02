#!/usr/bin/env python

'''compile_monthly_changelogs.py - Compile monthly changelog files from PR files for SS13

This is loosely based on `ss13_genchangelog.py` by Rob "N3X15" Nelson,
    all credits to them for the original idea.

Copyright, 2022 Alex 'Avunia' Takiya <takiya.eu>
Copyright, 2022 Horizon Project <hrzn.fun>

Licensed under MIT - see adjacent LICENSE file for more information.
'''

__copyright__ = "Copyright 2022, Alex 'Avunia' Takiya <takiya.eu>"
__version__ = "1.0.0"

import argparse, html, json, logging, sys, re
from datetime import datetime
from pathlib import Path, PurePath

import yaml

# Note to maintainer: Lots of duplicated code with the ingest script
# Make this a proper module at a later point

parser = argparse.ArgumentParser()
parser.add_argument(
    '-v',
    '--verbose',
    action='count',
    help="Adjust the verbosity level"
)
args = parser.parse_args()

logging_level = logging.WARNING

if args.verbose:
    if args.verbose == 1:
        logging_level = logging.INFO
    elif args.verbose >= 2:
        logging_level = logging.DEBUG

logging.basicConfig(
    format='{asctime}.{msecs:0>3.0f} [{levelname}] {message}',
    datefmt='%H:%M:%S',
    style='{'
)

log = logging.getLogger(__name__)
log.setLevel(logging_level)

log.info(f"{PurePath(__file__).name} version {__version__} - {__copyright__}")


# Path declarations
script_path = Path(__file__).parent.resolve()
project_root = script_path.parent.parent
config_path = script_path.joinpath('config.json').resolve()
# Todo: Add type definition validation. Not strictly needed but could be useful with --strict
#type_definitions_path = script_path.joinpath('type_definitions.json').resolve()

log.debug("Reading config file...")
with open(config_path, 'r') as f:
    config = json.load(f)
    log.debug("Configuration loaded!")

config_debug = [
    "Config Values:",
    f"Directories: {config['directories']}",
    f"Filename Prefix: {config['filenamePrefix']}"
]
log.debug("\n\t".join(config_debug))

changelogs_path = project_root.joinpath(config['directories']['changelog']).resolve()
archive_path = project_root.joinpath(config['directories']['archive']).resolve()

changelogs = []
changelogs.extend(changelogs_path.glob('*.yml'))

if not changelogs:
    log.info("No pending changelogs to be compiled. Exiting.")
    sys.exit()


# Oh my god please I'm having to merge like 20 PRs
#   that I don't want to manually run all this crap for
# Excuse this massive pile of shit here. Should be massively reworked
#   to use functions and comments and debug logging.
# If this is still here by 2023, send me an angry email
log.info("Reading changelogs...")
for file_path in changelogs:
    file_path: Path

    # Skip if the file is a directory masquerading
    # as a changelog for some awful reason
    if file_path.is_dir():
        log.debug(f"Skipping directory: {file_path}")
        continue

    working_changelog = {}

    log.debug(f"Reading {file_path.name}...")
    with open(file_path, 'r') as fr:
        working_changelog = yaml.safe_load(fr)

    changelog_date: datetime = working_changelog['merge-date']
    log.debug(f"Changelog entry date: {changelog_date}")

    archive_file = archive_path.joinpath(f"{changelog_date.strftime('%Y-%m')}.yml")

    # Our new or old archived changelog we wish to write to.
    archived_changelog = {}

    # Read the existing archived changelog file if it exists
    if archive_file.exists():
        log.info("Archived changelog exists, reading...")
        with open(archive_file, 'r') as fr:
            archived_changelog = yaml.safe_load(fr)

    # Is there an entry with our merge date yet?
    if not changelog_date in archived_changelog:
        # No? Okay, let's make a new entry then.
        log.debug("Changelog does not contain our merge date, adding.")
        archived_changelog[changelog_date] = {}

    # Does the author have an entry already?
    if not working_changelog['author'] in archived_changelog[changelog_date]:
        # If not, create one
        log.debug("Changelog does not contain any changes from the author, adding.")
        archived_changelog[changelog_date][working_changelog['author']] = []

    for change in working_changelog['changes']:
        if change in archived_changelog[changelog_date][working_changelog['author']]:
            log.debug("Change already exists, skipping!")
            continue

        log.debug("Adding change..")
        archived_changelog[changelog_date][working_changelog['author']] += [change]

    log.info("Writing updated changelog...")
    with open(archive_file, 'w') as fw:
        yaml.dump(archived_changelog, fw, default_flow_style=False)
        log.info("Changelog updated.")

    log.info(f"Deleting {file_path.name}...")
    file_path.unlink()

log.info("All changelogs processed!")
