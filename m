Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 543BF25B1A2
	for <lists+netfilter-devel@lfdr.de>; Wed,  2 Sep 2020 18:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbgIBQ13 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 2 Sep 2020 12:27:29 -0400
Received: from correo.us.es ([193.147.175.20]:57832 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728386AbgIBQ1Y (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 2 Sep 2020 12:27:24 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 7360B4FFE01
        for <netfilter-devel@vger.kernel.org>; Wed,  2 Sep 2020 18:27:21 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 64935DA73D
        for <netfilter-devel@vger.kernel.org>; Wed,  2 Sep 2020 18:27:21 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 5A04BDA72F; Wed,  2 Sep 2020 18:27:21 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WELCOMELIST,USER_IN_WHITELIST autolearn=disabled
        version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 5BBD5DA722;
        Wed,  2 Sep 2020 18:27:19 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Wed, 02 Sep 2020 18:27:19 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 3F33342EF42A;
        Wed,  2 Sep 2020 18:27:19 +0200 (CEST)
Date:   Wed, 2 Sep 2020 18:27:18 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>, netfilter-devel@vger.kernel.org,
        eric@garver.life
Subject: Re: [PATCH nf,v2] netfilter: nf_tables: coalesce multiple
 notifications into one skbuff
Message-ID: <20200902162718.GA17031@salvia>
References: <20200902145202.6822-1-pablo@netfilter.org>
 <20200902150443.GE23632@orbyte.nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200902150443.GE23632@orbyte.nwl.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Sep 02, 2020 at 05:04:43PM +0200, Phil Sutter wrote:
> On Wed, Sep 02, 2020 at 04:52:02PM +0200, Pablo Neira Ayuso wrote:
> [...]
> > +static void nft_commit_notify(struct net *net, u32 portid)
> > +{
> > +	struct sk_buff *batch_skb = NULL, *nskb, *skb;
> > +	unsigned char *data;
> > +	int len;
> > +
> > +	list_for_each_entry_safe(skb, nskb, &net->nft.notify_list, list) {
> > +		if (!batch_skb) {
> > +new_batch:
> > +			batch_skb = skb;
> > +			NFT_CB(batch_skb).report = NFT_CB(skb).report;
> 
> Is this assignment needed? NFT_CB() merely dereferences skb->cb, so
> after assigning 'batch_skb = skb', NFT_CB(batch_skb) == NFT_CB(skb), no?

That's right, thanks for reviewing.
