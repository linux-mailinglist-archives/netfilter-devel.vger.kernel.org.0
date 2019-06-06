Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80B4036FCA
	for <lists+netfilter-devel@lfdr.de>; Thu,  6 Jun 2019 11:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbfFFJ0K (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 6 Jun 2019 05:26:10 -0400
Received: from mail.us.es ([193.147.175.20]:40790 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727664AbfFFJ0K (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 6 Jun 2019 05:26:10 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 32077C4271
        for <netfilter-devel@vger.kernel.org>; Thu,  6 Jun 2019 11:26:08 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 1253EDA70A
        for <netfilter-devel@vger.kernel.org>; Thu,  6 Jun 2019 11:26:08 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 7C766DA7F6; Thu,  6 Jun 2019 11:25:56 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 87717DA808;
        Thu,  6 Jun 2019 11:25:54 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Thu, 06 Jun 2019 11:25:54 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 5C1F44265A32;
        Thu,  6 Jun 2019 11:25:54 +0200 (CEST)
Date:   Thu, 6 Jun 2019 11:25:53 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     phil@nwl.cc, fw@strlen.de
Subject: Re: [PATCH nft 0/4] split parse and evaluation phase to simplify
 cache logic
Message-ID: <20190606092553.oe4cffltnkoi7mkd@salvia>
References: <20190605164652.20199-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190605164652.20199-1-pablo@netfilter.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Phil,

I have pushed out this to master so you can rebase your patchset to
revisit index logic on top of what is in git HEAD.

If there's any fallout from this, just let me know, I'll be swift
about addressing it.

Thanks!
