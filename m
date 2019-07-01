Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89FA93D5BE
	for <lists+netfilter-devel@lfdr.de>; Tue, 11 Jun 2019 20:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392030AbfFKSrw (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 11 Jun 2019 14:47:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45078 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392016AbfFKSrv (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 11 Jun 2019 14:47:51 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A1ECB8666A;
        Tue, 11 Jun 2019 18:47:50 +0000 (UTC)
Received: from egarver.localdomain (ovpn-124-94.rdu2.redhat.com [10.10.124.94])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0EE051001B02;
        Tue, 11 Jun 2019 18:47:47 +0000 (UTC)
Date:   Tue, 11 Jun 2019 14:47:46 -0400
From:   Eric Garver <eric@garver.life>
To:     Shekhar Sharma <shekhar250198@gmail.com>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft v6 2/2]tests: py: add netns feature
Message-ID: <20190611184746.i5sg64gr4u2quiw5@egarver.localdomain>
Mail-Followup-To: Eric Garver <eric@garver.life>,
        Shekhar Sharma <shekhar250198@gmail.com>,
        netfilter-devel@vger.kernel.org
References: <20190609181849.10131-1-shekhar250198@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190609181849.10131-1-shekhar250198@gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Tue, 11 Jun 2019 18:47:50 +0000 (UTC)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sun, Jun 09, 2019 at 11:48:49PM +0530, Shekhar Sharma wrote:
> This patch adds the netns feature to the 'nft-test.py' file.
> 
> Signed-off-by: Shekhar Sharma <shekhar250198@gmail.com>
> ---
> The version history of the patch is :
> v1: add the netns feature
> v2: use format() method to simplify print statements.
> v3: updated the shebang
> v4: resent the same with small changes
> 
>  tests/py/nft-test.py | 98 ++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 80 insertions(+), 18 deletions(-)
> 
> diff --git a/tests/py/nft-test.py b/tests/py/nft-test.py
> index 4e18ae54..c9f65dc5 100755
> --- a/tests/py/nft-test.py
> +++ b/tests/py/nft-test.py
[..]
> @@ -245,6 +251,8 @@ def table_delete(table, filename=None, lineno=None):
>          return -1
>  
>      cmd = "delete table %s" % table
> +    if netns:
> +        cmd = "ip netns exec ___nftables-container-test {}".format(cmd) 

Can we pass the netns name via the netns argument? Then we don't have to
have instances of ___nftables-container-test in the command literals.
Just make netns part of your string format. You can also change the
default arg value to "".

Please fix all occurrences.

>      ret = execute_cmd(cmd, filename, lineno)
>      if ret != 0:
>          reason = "%s: I cannot delete table %s. Giving up!" % (cmd, table)
[..]
> @@ -1208,6 +1262,9 @@ def run_test_file(filename, force_all_family_option, specific_file):
>      filename_path = os.path.join(TESTS_PATH, filename)
>      f = open(filename_path)
>      tests = passed = total_unit_run = total_warning = total_error = 0
> +    if netns:
> +        execute_cmd("ip netns add ___nftables-container-test", filename, 0)
> + 

netns is not defined here.

>  
>      for lineno, line in enumerate(f):
>          sys.stdout.flush()
> @@ -1327,6 +1384,8 @@ def run_test_file(filename, force_all_family_option, specific_file):
>      else:
>          if tests == passed and tests > 0:
>              print(filename + ": " + Colors.GREEN + "OK" + Colors.ENDC)
> +        if netns:
> +            execute_cmd("ip netns del ___nftables-container-test", filename, 0)

netns is not defined here.
