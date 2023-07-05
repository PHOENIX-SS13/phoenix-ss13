#!/usr/bin/env python

'''ingest_pr_changelog.py - Parse & compile changelog metadata for SS13 from PRs

Licensed under MIT - see adjacent LICENSE file for more information.
'''

__copyright__ = ""
__version__ = "1.0.0"

import argparse, html, json, logging, re
from datetime import datetime, date
from pathlib import Path, PurePath
import sys

from github import Github
import yaml

def getChangelogEntryType(input):
    for type_def, type_data in type_definitions.items():
        type_kws = type_data['keywords']
        keywords = [type_kws] if isinstance(type_kws, str) else type_kws
        if input in keywords:
            return type_def

parser = argparse.ArgumentParser()
parser.add_argument(
    'repo',
    help='Origin in format owner/repo',
    metavar='owner/repo'
)
parser.add_argument(
    'pr_number',
    help='Pull Request Number to pull the changelog from.',
    type=int
)
parser.add_argument(
    '-a',
    '--auth',
    help='Supply a GitHub API Token to raise rate-limits or authenticate against private repos',
    metavar='GITHUB_AUTH_TOKEN'
)
parser.add_argument(
    '-c',
    '--check',
    help='Only check the PR if it has a valid changelog, does not write a changelog. Always runs in strict mode.',
    action='store_true'
)
parser.add_argument(
    '-s',
    '--strict',
    help='If the validator should skip/error on unknown change types.',
    action='store_true'
)
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

# One shot configuration for small scripts
# https://stackoverflow.com/a/69961204/4863926
logging.basicConfig(
    format='{asctime}.{msecs:0>3.0f} [{levelname}] {message}',
    datefmt='%H:%M:%S',
    style='{'
)

log = logging.getLogger(__name__)
log.setLevel(logging_level)

log.info(f"{PurePath(__file__).name} version {__version__} - {__copyright__}")


# Let's not print our auth token to the console
do_we_have_token = "Yes" if args.auth else "No"

arg_debug = [
    "Arguments:",
    f"Repository: {args.repo}",
    f"Pull Request Number: {args.pr_number}",
    f"Auth Token: {do_we_have_token}",
    f"Only Validate: {args.check}",
    f"Strict Mode: {args.strict}",
]
# And now all together...
log.debug("\n\t".join(arg_debug))

# Called check because -v is already verbosity
validate_only = False
if args.check:
    log.info("Check parameter passed - no changelog will be written.")
    validate_only = True

strict_mode = False
if args.strict:
    log.info("Strict mode enabled.")
    strict_mode = True

if args.auth:
    log.debug("Contacting GitHub with authentication")
    gh = Github(args.auth)
else:
    log.debug("Contacting GitHub as guest")
    gh = Github()


log.info(f"Getting Repository data for {args.repo}...")
repo = gh.get_repo(args.repo)

log.info(f"Getting Pull Request {args.pr_number}...")
pr = repo.get_pull(args.pr_number)

if not pr.body:
    log.info("Pull Request has no body. Exiting.")
    sys.exit()

# Path declarations
script_path = Path(__file__).parent.resolve()
project_root = script_path.parent.parent
config_path = script_path.joinpath('config.json').resolve()
type_definitions_path = script_path.joinpath('type_definitions.json').resolve()

log.debug("Reading config file...")
with open(config_path, 'r') as f:
    config = json.load(f)
    log.debug("Configuration loaded!")

changelog_path = project_root.joinpath(config['directories']['changelog']).resolve()


# Author of the changes, either supplied by GitHub or custom entry
changelog_author = ""
# Merge date of the PR, in YYYY-MM-DD format
changelog_date = datetime.fromtimestamp(0).date()
# Our changelog file's name
changelog_filename = f"{config['filenamePrefix']}{pr.number}.yml"
changelog_file = changelog_path.joinpath(changelog_filename).resolve()

changelog_match = re.search(r'(?::cl:|🆑)([\S ]*)?(?:\r\n|[\r\n])(.+)/(?::cl:|🆑)', pr.body, re.DOTALL)
merge_date = pr.merged_at

# Do we even have a changelog?
if not changelog_match:
    log.info("No changelog section found. Exiting.")
    sys.exit()

# Check if the PR author set a custom author name
if changelog_match.group(1):
    log.debug("Author specified in changelog.")
    changelog_author = changelog_match.group(1).strip()
    changelog_author = html.escape(changelog_author)
else:
    log.debug("Author not specified, pulling from GitHub.")
    changelog_author = f"{pr.user.name} ({pr.user.login})" if pr.user.name else pr.user.login

# Check if we got the merge date from the PR. Should normally be the case.
if merge_date:
    log.debug("Merge date supplied by PR as changelog date.")
    changelog_date = merge_date.date()
else:
    log.debug("Using today as changelog date.")
    changelog_date = date.today()

# Load our typedefs config file
log.debug("Reading changelog type definitions...")
with open(type_definitions_path, 'r') as f:
    type_definitions = json.load(f)['types']
    log.debug("Loaded changelog type definitions!")

# YAML changelog object
changelog = {
    "author": changelog_author,
    "changes": [],
    "merge-date": changelog_date,
    "prnumber": pr.number
}

# Invalid changelog entries, used for validation only
if validate_only:
    invalid_entries = []

# And now, go through every line in the changelog.
log.info("Scanning changelog...")
for line in changelog_match.group(2).splitlines():
    line = line.strip()
    line_match = re.search(r'([\w\ ]+):(.+?)$', line)

    if(line_match):
        type_input = html.escape(line_match.group(1).strip())
        # Get the type by trying to find the input in the definitions
        # Stays null if nothing matches
        type = getChangelogEntryType(type_input)
        message = html.escape(line_match.group(2).strip())

        # Someone gave us a bogus type definition.
        if not type:
            invalid_entry = f"{type_input}: {message}"
            if validate_only:
                invalid_entries.append(invalid_entry)

            warn_msg = [
                f"Invalid change type encountered { '- Skipping!' if strict_mode else '' }",
                invalid_entry
            ]
            log.warning("\n\t".join(warn_msg))

            # We are either strictly skipping unknown types or only validating.
            if strict_mode or validate_only:
                continue
            # We are not affected by the above, so we'll use what we got.
            type = type_input

        # Go through all entries and add them to the changes key on the YAML object
        log.debug(f'Adding type "{type}" with message "{message}" to entries')
        changelog['changes'].append({type: message})

if validate_only:
    if invalid_entries:
        err_message = "Invalid entries found:\n\t" + "\n\t".join(invalid_entries)
        log.error(err_message)
        log.error("Changelog did not pass validation.")
        sys.exit(1)

    log.info("Changelog was successfully validated.")
    sys.exit()

if not changelog["changes"]:
    log.info("No changelog entries to be written. Exiting.")
    sys.exit()

# Let's write!
log.debug(f"Attempting to write changelog entry...\n\tFile: {changelog_file}")
with open(changelog_file, 'w', encoding='utf-8') as f:
    yaml.dump(changelog, f, default_flow_style=False)
    log.debug("Changelog written!")

log.info("Changelog generated!")
