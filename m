Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 554413982F
	for <lists+netfilter-devel@lfdr.de>; Sat,  8 Jun 2019 00:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbfFGWGQ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 7 Jun 2019 18:06:16 -0400
Received: from mail.us.es ([193.147.175.20]:36710 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726754AbfFGWGQ (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 7 Jun 2019 18:06:16 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id D623980764
        for <netfilter-devel@vger.kernel.org>; Sat,  8 Jun 2019 00:06:13 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id B7778DA701
        for <netfilter-devel@vger.kernel.org>; Sat,  8 Jun 2019 00:06:13 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id ACEB6DA704; Sat,  8 Jun 2019 00:06:13 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id BEA2EDA701;
        Sat,  8 Jun 2019 00:06:11 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Sat, 08 Jun 2019 00:06:11 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 9E9CD4265A2F;
        Sat,  8 Jun 2019 00:06:11 +0200 (CEST)
Date:   Sat, 8 Jun 2019 00:06:11 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH 0/4] Some fixes and minor improvements in tests/
Message-ID: <20190607220611.nvqsyz4njxdc2j5j@salvia>
References: <20190607172527.22177-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190607172527.22177-1-phil@nwl.cc>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

i
On Fri, Jun 07, 2019 at 07:25:23PM +0200, Phil Sutter wrote:
> This series mostly adds missing bits and changes to JSON equivalents in
> tests/py to avoid errors when running the suite with -j flag.
> 
> In addition to that, patch 3 fixes awk syntax in 0028delete_handle_0
> test of tests/shell suite. Patch 4 improves the diff output upon dump
> errors in same suite by printing unified diffs instead of normal ones.

Applied, thanks Phil.
