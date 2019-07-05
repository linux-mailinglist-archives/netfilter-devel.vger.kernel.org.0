Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 240DD5F8F0
	for <lists+netfilter-devel@lfdr.de>; Thu,  4 Jul 2019 15:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbfGDNO0 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 4 Jul 2019 09:14:26 -0400
Received: from mail.us.es ([193.147.175.20]:33788 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727087AbfGDNO0 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 4 Jul 2019 09:14:26 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 6627DF2687
        for <netfilter-devel@vger.kernel.org>; Thu,  4 Jul 2019 15:14:24 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 577511150CC
        for <netfilter-devel@vger.kernel.org>; Thu,  4 Jul 2019 15:14:24 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 4D1381150CB; Thu,  4 Jul 2019 15:14:24 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 56671DA708;
        Thu,  4 Jul 2019 15:14:22 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Thu, 04 Jul 2019 15:14:22 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 34A934265A2F;
        Thu,  4 Jul 2019 15:14:22 +0200 (CEST)
Date:   Thu, 4 Jul 2019 15:14:21 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Shekhar Sharma <shekhar250198@gmail.com>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft v12]tests: py: add netns feature
Message-ID: <20190704131421.sejz6sby3odwl6yx@salvia>
References: <20190702192045.16537-1-shekhar250198@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190702192045.16537-1-shekhar250198@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Jul 03, 2019 at 12:50:45AM +0530, Shekhar Sharma wrote:
> diff --git a/tests/py/nft-test.py b/tests/py/nft-test.py
> index fcbd28ca..8076ce78 100755
> --- a/tests/py/nft-test.py
> +++ b/tests/py/nft-test.py
> @@ -174,27 +174,31 @@ def print_differences_error(filename, lineno, cmd):
[...]
> -def table_create(table, filename, lineno):
> +def table_create(table, filename, lineno, netns=""):
>      '''
>      Adds a table.
>      '''
> @@ -208,6 +212,8 @@ def table_create(table, filename, lineno):
>  
>      # We add a new table
>      cmd = "add table %s" % table
> +    if netns:
> +        cmd = "ip netns exec " + "{} {}".format(netns,cmd)
>      ret = execute_cmd(cmd, filename, lineno)
>  
>      if ret != 0:

You're missing updates of table_create() invocations, because you are
setting a default value to the netns parameter to "", this never runs
the netns patch I'm afraid.
