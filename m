Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5CF32B89E
	for <lists+netfilter-devel@lfdr.de>; Mon, 27 May 2019 17:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbfE0Py5 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 27 May 2019 11:54:57 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:35282 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726329AbfE0Py5 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 27 May 2019 11:54:57 -0400
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.91)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1hVHxe-0000EQ-NO; Mon, 27 May 2019 17:54:54 +0200
Date:   Mon, 27 May 2019 17:54:54 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Shekhar Sharma <shekhar250198@gmail.com>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft v1] tests: json_echo: fix python3
Message-ID: <20190527155454.GY31548@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Shekhar Sharma <shekhar250198@gmail.com>,
        netfilter-devel@vger.kernel.org
References: <20190524184409.466036-1-shekhar250198@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524184409.466036-1-shekhar250198@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi,

On Sat, May 25, 2019 at 12:14:09AM +0530, Shekhar Sharma wrote:
> This patch converts the 'run-test.py' file to run on both python2 and python3.
> 
> Signed-off-by: Shekhar Sharma <shekhar250198@gmail.com>
> ---
>  tests/json_echo/run-test.py | 45 +++++++++++++++++++------------------
>  1 file changed, 23 insertions(+), 22 deletions(-)
> 
> diff --git a/tests/json_echo/run-test.py b/tests/json_echo/run-test.py
> index 0132b139..f5c81b7d 100755
> --- a/tests/json_echo/run-test.py
> +++ b/tests/json_echo/run-test.py
> @@ -1,5 +1,7 @@
>  #!/usr/bin/python2

If the script now runs with either python 2 or 3, maybe change the
shebang to just '/usr/bin/python'?

> +from nftables import Nftables
> +from __future__ import print_function
>  import sys
>  import os
>  import json
> @@ -7,14 +9,13 @@ import json
>  TESTS_PATH = os.path.dirname(os.path.abspath(__file__))
>  sys.path.insert(0, os.path.join(TESTS_PATH, '../../py/'))
>  
> -from nftables import Nftables

Are you aware that the import was put here deliberately after the call
to sys.path.insert()? Why did you decide to move the import call?

>  # Change working directory to repository root
>  os.chdir(TESTS_PATH + "/../..")
>  
>  if not os.path.exists('src/.libs/libnftables.so'):
> -    print "The nftables library does not exist. " \
> -          "You need to build the project."
> +    print("The nftables library does not exist. " \
> +          "You need to build the project.")
>      sys.exit(1)

Drop the backslash here?

Cheers, Phil
