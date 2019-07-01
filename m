Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA053BB3D
	for <lists+netfilter-devel@lfdr.de>; Mon, 10 Jun 2019 19:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388491AbfFJRpr (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 10 Jun 2019 13:45:47 -0400
Received: from mail.us.es ([193.147.175.20]:38180 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388215AbfFJRpr (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 10 Jun 2019 13:45:47 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id CCD73C1A16
        for <netfilter-devel@vger.kernel.org>; Mon, 10 Jun 2019 19:45:45 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id BDD0BDA711
        for <netfilter-devel@vger.kernel.org>; Mon, 10 Jun 2019 19:45:45 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id B34BEDA70B; Mon, 10 Jun 2019 19:45:45 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id B4F8ADA709;
        Mon, 10 Jun 2019 19:45:43 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 10 Jun 2019 19:45:43 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 9123A4265A2F;
        Mon, 10 Jun 2019 19:45:43 +0200 (CEST)
Date:   Mon, 10 Jun 2019 19:45:43 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     xiao ruizhu <katrina.xiaorz@gmail.com>
Cc:     kadlec@blackhole.kfki.hu, fw@strlen.de, davem@davemloft.net,
        alin.nastac@gmail.com, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH v5] netfilter: nf_conntrack_sip: fix expectation clash
Message-ID: <20190610174543.chflcq4udmpqitnu@salvia>
References: <20190514101801.xregz4uqppy3lg7j@salvia>
 <1559637263-2679-1-git-send-email-katrina.xiaorz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559637263-2679-1-git-send-email-katrina.xiaorz@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Looks good, only one more little change and we go.

On Tue, Jun 04, 2019 at 04:34:23PM +0800, xiao ruizhu wrote:
[...]
> @@ -420,8 +421,10 @@ static inline int __nf_ct_expect_check(struct nf_conntrack_expect *expect)
>  	}
>  	h = nf_ct_expect_dst_hash(net, &expect->tuple);
>  	hlist_for_each_entry_safe(i, next, &nf_ct_expect_hash[h], hnode) {
> -		if (expect_matches(i, expect)) {
> -			if (i->class != expect->class)
> +		if ((flags & NF_CT_EXP_F_CHECK_MASTER ? true : i->master ==
> +		    expect->master) && expect_matches(i, expect)) {

Could you add a function for this? eg.

static bool nf_ct_check_master(struct nf_conntrack_expect *a,
                               struct nf_conntrack_expect *b)
{
        if (flags & NF_CT_EXP_F_CHECK_MASTER)
                return true;

        return i->master == expect->master &&
               expect_matches(i, expect);
}

Was that the intention?

I'm a bit confused with the use of the single statement branch above.

Thanks!

> +			if (i->class != expect->class ||
> +			    i->master != expect->master)
>  				return -EALREADY;
>  
>  			if (nf_ct_remove_expect(i))
