Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58F2BF9B73
	for <lists+netfilter-devel@lfdr.de>; Tue, 12 Nov 2019 22:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbfKLVH3 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 12 Nov 2019 16:07:29 -0500
Received: from correo.us.es ([193.147.175.20]:55008 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726645AbfKLVH3 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 12 Nov 2019 16:07:29 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id B2F1F130E39
        for <netfilter-devel@vger.kernel.org>; Tue, 12 Nov 2019 22:07:24 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id A6259B7FF6
        for <netfilter-devel@vger.kernel.org>; Tue, 12 Nov 2019 22:07:24 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 9BAAFB7FF2; Tue, 12 Nov 2019 22:07:24 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id A7E7EBAACC;
        Tue, 12 Nov 2019 22:07:22 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 12 Nov 2019 22:07:22 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 82C414251481;
        Tue, 12 Nov 2019 22:07:22 +0100 (CET)
Date:   Tue, 12 Nov 2019 22:07:24 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Arturo Borrero Gonzalez <arturo@netfilter.org>
Cc:     Phil Sutter <phil@nwl.cc>, netfilter-devel@vger.kernel.org,
        Ash Hughes <sehguh.hsa@gmail.com>
Subject: Re: [conntrack-tools PATCH] helpers: Fix for warning when compiling
 against libtirpc
Message-ID: <20191112210724.jdm6ynbuwyl5tqgj@salvia>
References: <20191111172001.14319-1-phil@nwl.cc>
 <99228355-5f8e-e251-ea3a-0371729e01fd@netfilter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99228355-5f8e-e251-ea3a-0371729e01fd@netfilter.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Nov 12, 2019 at 11:58:30AM +0100, Arturo Borrero Gonzalez wrote:
> On 11/11/19 6:20 PM, Phil Sutter wrote:
> > Fix for the following warning:
> > 
> > In file included from rpc.c:29:
> > /usr/include/tirpc/rpc/rpc_msg.h:214:52: warning: 'struct rpc_err' declared inside parameter list will not be visible outside of this definition or declaration
> >   214 | extern void _seterr_reply(struct rpc_msg *, struct rpc_err *);
> >       |                                                    ^~~~~~~
> > 
> > Struct rpc_err is declared in rpc/clnt.h which also declares rpc_call(),
> > therefore rename the local version.
> > 
> > Fixes: 5ededc4476f27 ("conntrackd: search for RPC headers")
> > Signed-off-by: Phil Sutter <phil@nwl.cc>
> > ---
> >  src/helpers/rpc.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> > 
> 
> Acked-by: Arturo Borrero Gonzalez <arturo@netfilter.org>

Acked-by: Pablo Neira Ayuso <pablo@netfilter.org>
