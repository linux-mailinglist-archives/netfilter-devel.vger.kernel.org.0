Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA2EF1E27D3
	for <lists+netfilter-devel@lfdr.de>; Tue, 26 May 2020 19:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbgEZRAy (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 26 May 2020 13:00:54 -0400
Received: from correo.us.es ([193.147.175.20]:52142 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729597AbgEZRAy (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 26 May 2020 13:00:54 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 94C0FC106C
        for <netfilter-devel@vger.kernel.org>; Tue, 26 May 2020 19:00:52 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 85999DA720
        for <netfilter-devel@vger.kernel.org>; Tue, 26 May 2020 19:00:52 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 84536DA71F; Tue, 26 May 2020 19:00:52 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 7FCADDA711;
        Tue, 26 May 2020 19:00:50 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 26 May 2020 19:00:50 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 60A9D42EF42D;
        Tue, 26 May 2020 19:00:50 +0200 (CEST)
Date:   Tue, 26 May 2020 19:00:50 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH] doc: libxt_MARK: OUTPUT chain is fine, too
Message-ID: <20200526170050.GA16695@salvia>
References: <20200519230822.15290-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519230822.15290-1-phil@nwl.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, May 20, 2020 at 01:08:22AM +0200, Phil Sutter wrote:
> In order to route packets originating from the host itself based on
> fwmark, mangle table's OUTPUT chain must be used. Mention this chain as
> alternative to PREROUTING.
> 
> Fixes: c9be7f153f7bf ("doc: libxt_MARK: no longer restricted to mangle table")
> Signed-off-by: Phil Sutter <phil@nwl.cc>
> ---
>  extensions/libxt_MARK.man | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/extensions/libxt_MARK.man b/extensions/libxt_MARK.man
> index 712fb76f7340c..b2408597e98f1 100644
> --- a/extensions/libxt_MARK.man
> +++ b/extensions/libxt_MARK.man
> @@ -1,7 +1,7 @@
>  This target is used to set the Netfilter mark value associated with the packet.
>  It can, for example, be used in conjunction with routing based on fwmark (needs
> -iproute2). If you plan on doing so, note that the mark needs to be set in the
> -PREROUTING chain of the mangle table to affect routing.
> +iproute2). If you plan on doing so, note that the mark needs to be set in
> +either the PREROUTING or the OUTPUT chain of the mangle table to affect routing.

You have two choices:

* Set the mark in filter OUTPUT chain => it does not affect routing.
* Set the mark in the mangle OUTPUT chain => it _does_ affect routing.

Are we on the same page?
