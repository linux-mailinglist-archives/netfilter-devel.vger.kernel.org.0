Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F36E142E0
	for <lists+netfilter-devel@lfdr.de>; Mon,  6 May 2019 00:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727767AbfEEWbg (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 5 May 2019 18:31:36 -0400
Received: from mail.us.es ([193.147.175.20]:50846 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727593AbfEEWbg (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 5 May 2019 18:31:36 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 9BCDFDA70A
        for <netfilter-devel@vger.kernel.org>; Mon,  6 May 2019 00:31:34 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 8C32ADA705
        for <netfilter-devel@vger.kernel.org>; Mon,  6 May 2019 00:31:34 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 81D8EDA703; Mon,  6 May 2019 00:31:34 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 99E2BDA701;
        Mon,  6 May 2019 00:31:32 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 06 May 2019 00:31:32 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 798324265A31;
        Mon,  6 May 2019 00:31:32 +0200 (CEST)
Date:   Mon, 6 May 2019 00:31:32 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>
Cc:     fw@strlen.de, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf v2] netfilter: nf_conntrack_h323: Remove deprecated
 config check
Message-ID: <20190505223132.bbwsnlhfyvvxhsti@salvia>
References: <1556908748-22202-1-git-send-email-subashab@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556908748-22202-1-git-send-email-subashab@codeaurora.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, May 03, 2019 at 12:39:08PM -0600, Subash Abhinov Kasiviswanathan wrote:
> CONFIG_NF_CONNTRACK_IPV6 has been deprecated so replace it with
> a check for IPV6 instead.
> 
> v1->v2: Use nf_ip6_route6() instead of v6ops->route() and keep
> the IS_MODULE() in nf_ipv6_ops as mentioned by Florian so that
> direct calls are used when IPV6 is builtin and indirect calls
> are used only when IPV6 is a module.

Applied, thanks.
