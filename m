Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C41C212AD8F
	for <lists+netfilter-devel@lfdr.de>; Thu, 26 Dec 2019 17:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbfLZQmV (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 26 Dec 2019 11:42:21 -0500
Received: from correo.us.es ([193.147.175.20]:55298 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726653AbfLZQmV (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 26 Dec 2019 11:42:21 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 1415BE34D8
        for <netfilter-devel@vger.kernel.org>; Thu, 26 Dec 2019 17:42:19 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 05757DA703
        for <netfilter-devel@vger.kernel.org>; Thu, 26 Dec 2019 17:42:19 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id EF19CDA702; Thu, 26 Dec 2019 17:42:18 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 0D74FDA703;
        Thu, 26 Dec 2019 17:42:17 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Thu, 26 Dec 2019 17:42:17 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id E4F334251480;
        Thu, 26 Dec 2019 17:42:16 +0100 (CET)
Date:   Thu, 26 Dec 2019 17:42:17 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf-next 0/9] netfilter: nft_meta: add support for slave
 device matching
Message-ID: <20191226164216.2ysrdyrsmynjenqp@salvia>
References: <20191218110521.14048-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191218110521.14048-1-fw@strlen.de>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Dec 18, 2019 at 12:05:12PM +0100, Florian Westphal wrote:
> Martin Willi recently proposed addition of new xt_slavedev module to
> allow matching the real interface within a VRF domain.
> 
> This adds an nft equivalent:
> 
> meta sdif "realdev" accept
> meta sdifname "realdev" accept
> 
> In case packet had no vrf slave, sdif stores 0 or "" name, just
> like 'oif/oifname' would on input.
> 
> sdif(name) is restricted to the ipv4/ipv6 input and forward hooks,
> as it depends on ip(6) stack parsing/storing info in skb->cb[].
> 
> Because meta main eval function is now exceeding more than 200 LOC,
> the first patches are diet work to debloat the function by using
> helpers where appropriate.
>
> Last patch adds the sdif/sdifname functionality.

Series applied, thanks Florian.
