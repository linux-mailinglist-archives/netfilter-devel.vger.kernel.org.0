Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB9473D5FC
	for <lists+netfilter-devel@lfdr.de>; Tue, 11 Jun 2019 21:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392177AbfFKS7W (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 11 Jun 2019 14:59:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38098 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388630AbfFKS7W (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 11 Jun 2019 14:59:22 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C7D392F8BF0;
        Tue, 11 Jun 2019 18:59:13 +0000 (UTC)
Received: from egarver.localdomain (ovpn-124-94.rdu2.redhat.com [10.10.124.94])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CC47C1972B;
        Tue, 11 Jun 2019 18:59:10 +0000 (UTC)
Date:   Tue, 11 Jun 2019 14:59:09 -0400
From:   Eric Garver <eric@garver.life>
To:     Shekhar Sharma <shekhar250198@gmail.com>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH iptables v1] iptables-test: fix python3
Message-ID: <20190611185909.lxxmgw5zbmqgq2ek@egarver.localdomain>
Mail-Followup-To: Eric Garver <eric@garver.life>,
        Shekhar Sharma <shekhar250198@gmail.com>,
        netfilter-devel@vger.kernel.org
References: <20190606195058.4411-1-shekhar250198@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606195058.4411-1-shekhar250198@gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Tue, 11 Jun 2019 18:59:21 +0000 (UTC)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Jun 07, 2019 at 01:20:58AM +0530, Shekhar Sharma wrote:
> This patch converts the 'iptables-test.py' file (iptables/iptables-test.py) to run on
> both python 2 and python3.
> 
> 
> Signed-off-by: Shekhar Sharma <shekhar250198@gmail.com>
> ---
>  iptables-test.py | 43 ++++++++++++++++++++++---------------------
>  1 file changed, 22 insertions(+), 21 deletions(-)
> 
> diff --git a/iptables-test.py b/iptables-test.py
> index 532dee7..8018b65 100755
> --- a/iptables-test.py
> +++ b/iptables-test.py
[..]
> @@ -79,7 +80,7 @@ def run_test(iptables, rule, rule_save, res, filename, lineno, netns):
>  
>      cmd = iptables + " -A " + rule
>      if netns:
> -            cmd = "ip netns exec ____iptables-container-test " + EXECUTEABLE + " " + cmd
> +            cmd = "ip netns exec ____iptables-container-test " + EXECUTEABLE + "  {}".format(cmd)

This is a bogus change. No reason to switch to format() when we're just
concatenating strings. Many occurrences of this in the patch.

I think you only need to fix the print statements.

>  
>      ret = execute_cmd(cmd, filename, lineno)
>  
[..]
> @@ -365,9 +366,9 @@ def main():
>              passed += file_passed
>              test_files += 1
>  
> -    print ("%d test files, %d unit tests, %d passed" %
> -           (test_files, tests, passed))
> +    print("{} test files, {} unit tests, {} passed".format(test_files, tests, passed))
>  
>  
>  if __name__ == '__main__':
>      main()
> +

Bogus new line.
