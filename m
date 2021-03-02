Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3C632AE7F
	for <lists+netfilter-devel@lfdr.de>; Wed,  3 Mar 2021 03:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbhCBXii (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 2 Mar 2021 18:38:38 -0500
Received: from correo.us.es ([193.147.175.20]:43058 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1575963AbhCBQFL (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 2 Mar 2021 11:05:11 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 63D54508CD3
        for <netfilter-devel@vger.kernel.org>; Tue,  2 Mar 2021 16:38:28 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 4FF10DA78F
        for <netfilter-devel@vger.kernel.org>; Tue,  2 Mar 2021 16:38:28 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 4426DDA78B; Tue,  2 Mar 2021 16:38:28 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-105.9 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        FORGED_MUA_MOZILLA,NICE_REPLY_A,SMTPAUTH_US2,URIBL_BLOCKED,
        USER_IN_WELCOMELIST,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 9A7C4DA704;
        Tue,  2 Mar 2021 16:38:25 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 02 Mar 2021 16:38:25 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 7A41B42DF562;
        Tue,  2 Mar 2021 16:38:25 +0100 (CET)
Date:   Tue, 2 Mar 2021 16:38:25 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org
Subject: Re: [nf:master 7/7] net/netfilter/nf_tables_api.c:920:15: warning:
 converting the enum constant to a boolean
Message-ID: <20210302153825.GA26011@salvia>
References: <202103022132.6FiROxhQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202103022132.6FiROxhQ-lkp@intel.com>
User-Agent: Mozilla/5.0
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Mar 02, 2021 at 09:17:37PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pablo/nf.git master
> head:   64d075d0d3770d761018500d59dbca37b1867017
> commit: 64d075d0d3770d761018500d59dbca37b1867017 [7/7] netfilter: nftables: disallow updates on table ownership
> config: powerpc64-randconfig-r022-20210302 (attached as .config)
> compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project 5de09ef02e24d234d9fc0cd1c6dfe18a1bb784b0)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install powerpc64 cross compiling tool for clang build
>         # apt-get install binutils-powerpc64-linux-gnu
>         # https://git.kernel.org/pub/scm/linux/kernel/git/pablo/nf.git/commit/?id=64d075d0d3770d761018500d59dbca37b1867017
>         git remote add nf https://git.kernel.org/pub/scm/linux/kernel/git/pablo/nf.git
>         git fetch --no-tags nf master
>         git checkout 64d075d0d3770d761018500d59dbca37b1867017
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=powerpc64 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
> >> net/netfilter/nf_tables_api.c:920:15: warning: converting the enum constant to a boolean [-Wint-in-bool-context]
>                 !(flags && NFT_TABLE_F_OWNER)) ||
>                         ^

Ouch. Fixed.
