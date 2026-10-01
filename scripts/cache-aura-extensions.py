#!/usr/bin/env python3
"""Cache compatible EGO extensions before the image build."""
import json
import pathlib
import shutil
import sys
import tempfile
import time
import urllib.parse
import urllib.request
import zipfile

source = pathlib.Path(sys.argv[1])
destination = pathlib.Path(sys.argv[2])
major = sys.argv[3]
text = (source / 'lib/steps.sh').read_text()
selection = text.split('EXT_EXTRA_ALL=(', 1)[1].split(')', 1)[0].split()
destination.mkdir(parents=True, exist_ok=True)

def supports(path):
    try:
        metadata = json.loads((path / 'metadata.json').read_text())
        return major in [str(v).split('.')[0] for v in metadata['shell-version']]
    except (OSError, ValueError, KeyError):
        return False

for uuid in selection:
    target = destination / uuid
    if supports(target):
        print('Cached:', uuid, flush=True)
        continue
    for attempt in range(3):
        try:
            query = urllib.parse.urlencode({'uuid': uuid, 'shell_version': major})
            with urllib.request.urlopen('https://extensions.gnome.org/extension-info/?' + query, timeout=30) as response:
                info = json.load(response)
            with tempfile.TemporaryDirectory() as temporary:
                root = pathlib.Path(temporary)
                with urllib.request.urlopen('https://extensions.gnome.org' + info['download_url'], timeout=30) as response:
                    (root / 'extension.zip').write_bytes(response.read())
                with zipfile.ZipFile(root / 'extension.zip') as archive:
                    archive.extractall(root / 'unpacked')
                if not supports(root / 'unpacked'):
                    raise ValueError('Published archive does not support GNOME ' + major)
                if target.exists():
                    shutil.rmtree(target)
                shutil.copytree(root / 'unpacked', target)
            print('Downloaded:', uuid, flush=True)
            break
        except Exception as error:
            if attempt == 2:
                raise SystemExit(f'{uuid}: {error}')
            time.sleep(2)
