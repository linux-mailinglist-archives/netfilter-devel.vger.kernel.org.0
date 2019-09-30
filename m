Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCB1BC2546
	for <lists+netfilter-devel@lfdr.de>; Mon, 30 Sep 2019 18:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732197AbfI3Qg7 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 30 Sep 2019 12:36:59 -0400
Received: from correo.us.es ([193.147.175.20]:49012 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731459AbfI3Qg7 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 30 Sep 2019 12:36:59 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 3929D500D91
        for <netfilter-devel@vger.kernel.org>; Mon, 30 Sep 2019 18:36:55 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 29EBCB7FFE
        for <netfilter-devel@vger.kernel.org>; Mon, 30 Sep 2019 18:36:55 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 1F78DDA72F; Mon, 30 Sep 2019 18:36:55 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 208ADB7FFE;
        Mon, 30 Sep 2019 18:36:53 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 30 Sep 2019 18:36:53 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id F3F4442EF9E0;
        Mon, 30 Sep 2019 18:36:52 +0200 (CEST)
Date:   Mon, 30 Sep 2019 18:36:54 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     Phil Sutter <phil@nwl.cc>, netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH v2 04/24] nft: Fix for add and delete of same
 rule in single batch
Message-ID: <20190930163654.fdvjkbnxizxjohcc@salvia>
References: <20190925212605.1005-1-phil@nwl.cc>
 <20190925212605.1005-5-phil@nwl.cc>
 <20190927142027.GE9938@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190927142027.GE9938@breakpoint.cc>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Sep 27, 2019 at 04:20:27PM +0200, Florian Westphal wrote:
> Phil Sutter <phil@nwl.cc> wrote:
> > Another corner-case found when extending restore ordering test: If a
> > delete command in a dump referenced a rule added earlier within the same
> > dump, kernel would reject the resulting NFT_MSG_DELRULE command.
> > 
> > Catch this by assigning the rule to delete a RULE_ID value if it doesn't
> > have a handle yet. Since __nft_rule_del() does not duplicate the
> > nftnl_rule object when creating the NFT_COMPAT_RULE_DELETE command, this
> > RULE_ID value is added to both NEWRULE and DELRULE commands - exactly
> > what is needed to establish the reference.
> 
> Acked-by: Florian Westphal <fw@strlen.de>

Acked-by: Pablo Neira Ayuso <pablo@netfilter.org>
