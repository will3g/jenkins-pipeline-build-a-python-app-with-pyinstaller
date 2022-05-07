import os
import sys
# jenkins exposes the workspace directory through env.

from src.app import index

sys.path.append(os.environ['WORKSPACE'])

def test_index():
    assert index() == 'Hello, world!'
