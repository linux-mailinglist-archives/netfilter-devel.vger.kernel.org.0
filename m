Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1DC4A9FD
	for <lists+netfilter-devel@lfdr.de>; Tue, 18 Jun 2019 20:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730245AbfFRSfT (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 18 Jun 2019 14:35:19 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36312 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730116AbfFRSfT (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 18 Jun 2019 14:35:19 -0400
Received: by mail-ot1-f65.google.com with SMTP id r6so16428005oti.3
        for <netfilter-devel@vger.kernel.org>; Tue, 18 Jun 2019 11:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FobvbuZf2QjvYArc1fO/ke4bAinQUyEbm/ELDBCFhUw=;
        b=AJO3zO6A23XrAh/lacKWTOeeYu1DLsli0RtOIsX2IG+dvM8rrlkHsq+ujPl/wMucwe
         Um7ow0znW27WlRfpLgcl7CDvjoL6bp+gxhQ5lynE2DWSVCrmpdQqIpJuC5ja7ypGoFAo
         L2bn0keTM+mqPHMmijvPuAzr3HLACbl8NnvwOFa+MdtzySOHvBz7KpPyi+EWw/PnwNWq
         8oO403ad9d7AFPMIN9uSNfOU3GhsLGoBhEKTM9WdELkXl3f3Rod7/LIZxTSXk8BPmRIS
         LatjueOL9Tt/VXxGg0rQsit1ausMjJ6avNcE3r9BcqUbIB52bByBAccBQOW2SBXjfDi9
         kUig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FobvbuZf2QjvYArc1fO/ke4bAinQUyEbm/ELDBCFhUw=;
        b=oqr7uUpIQynDnmuxdKxislUx9lTQBYdelle1wq1Cw8pjSmfXD0WbDjsyxGUTQWs4vs
         TWVyrNvfXzaYeFeQ+cYKAor+nSwt0NhoKYoMpJer8tlR+TG/FapJZAohj4QDy2jSKA50
         C1Id4SXJj5gfutd11vCvHqcDLmd9Q3gt2N/g4aOswN2UIVwsiosngPwGyiVBJ0C9/aUO
         mTZAy3eMfKmLJcR168OATdjsKxJ9lqj1/lsvdUCxdsikfT8xWDWj1Sp7DlcTHPWn6X4I
         IitpxImRu1Eq26aPlJYvQtVaUre1IVoOCLEoVaDfvx6XuRxyRDUQU/1XN8IvsHSbe1WI
         8anA==
X-Gm-Message-State: APjAAAXk7tCDqL4LsZUAPXqmY8jDgz7teElBf1EFkQeQDDFbqxhXF3f+
        5Ief/7faTWhadKUvalfGOzHEoxS/tmIk9mHr6Aw=
X-Google-Smtp-Source: APXvYqxFhSmJpaxgTe1cgPn+cqqgqOlFVJlL5ae1IDopzxgxeU+tnpJvQaQ7fToqKVSG5768oZjg6qEAYI5WYdGmBqQ=
X-Received: by 2002:a9d:5911:: with SMTP id t17mr16975101oth.159.1560882918269;
 Tue, 18 Jun 2019 11:35:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAN9XX2pWQY0Rz2cGv7V=v8+g0mUTNGWS4pf0FJwScmrNpC5Kjg@mail.gmail.com>
 <20190618182127.21110-1-eric@garver.life>
In-Reply-To: <20190618182127.21110-1-eric@garver.life>
From:   shekhar sharma <shekhar250198@gmail.com>
Date:   Wed, 19 Jun 2019 00:05:06 +0530
Message-ID: <CAN9XX2o6jbZyZdKp956vK9Zzb9xR5H-2zF7=KnU-nRPY9kLJHA@mail.gmail.com>
Subject: Re: [PATCH nft] nft-test.py: use tempfile module
To:     Eric Garver <eric@garver.life>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Netfilter Development Mailing list 
        <netfilter-devel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi Eric!

On Tue, Jun 18, 2019 at 11:51 PM Eric Garver <eric@garver.life> wrote:
>
> os.tmpfile() is not in python3.
>
Did not know that. It should resolve the problem. Thanks!

---
>  tests/py/nft-test.py | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/tests/py/nft-test.py b/tests/py/nft-test.py
> index f80517e67bfd..4da6fa650f6d 100755
> --- a/tests/py/nft-test.py
> +++ b/tests/py/nft-test.py
> @@ -20,6 +20,7 @@ import argparse
>  import signal
>  import json
>  import traceback
> +import tempfile
>
>  TESTS_PATH = os.path.dirname(os.path.abspath(__file__))
>  sys.path.insert(0, os.path.join(TESTS_PATH, '../../py/'))
> @@ -771,7 +772,7 @@ def rule_add(rule, filename, lineno, force_all_family_option, filename_path):
>              unit_tests += 1
>              table_flush(table, filename, lineno)
>
> -            payload_log = os.tmpfile()
> +            payload_log = tempfile.TemporaryFile(mode="w+")
>
>              # Add rule and check return code
>              cmd = "add rule %s %s %s" % (table, chain, rule[0])
> @@ -911,7 +912,7 @@ def rule_add(rule, filename, lineno, force_all_family_option, filename_path):
>                                gotf.name, 1)
>
>              table_flush(table, filename, lineno)
> -            payload_log = os.tmpfile()
> +            payload_log = tempfile.TemporaryFile(mode="w+")
>
>              # Add rule in JSON format
>              cmd = json.dumps({ "nftables": [{ "add": { "rule": {
> --
> 2.20.1
>


Shekhar
