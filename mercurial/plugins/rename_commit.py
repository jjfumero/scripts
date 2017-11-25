#!/usr/bin/python

# Hook in mercurial to show a fix message in the commit
# In this case: [current_branch] + message
# Link: http://stackoverflow.com/questions/10284172/mercurial-hg-commit-message-prefixed-with-current-branch-directory

import re
import os
import sys
import mercurial

# Include in the .hg/hgrc file:
# [hooks]
# precommit = python:/path/to/hook/hook.py:prefix_commit_message

def prefix_commit_message(repo, **kwargs):
    commitctx = repo.commitctx

    def rewrite_ctx(ctx, error):
        text = ctx._text
        branchName = ctx.branch()
        ctx._text = "[" + branchName + "] " + text

        return commitctx(ctx, error)

    repo.commitctx = rewrite_ctx
