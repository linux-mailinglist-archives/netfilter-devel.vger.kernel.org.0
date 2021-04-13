Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 072D935DE97
	for <lists+netfilter-devel@lfdr.de>; Tue, 13 Apr 2021 14:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbhDMMY6 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 13 Apr 2021 08:24:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:54066 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230025AbhDMMY6 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 13 Apr 2021 08:24:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1618316677; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yVSX+divyvl5YED8Kbt4VC5W4KJQMko/a8fW5q0+iJc=;
        b=oDqoEP0gDe4Gjzbn01Hgzt0tcrGwU9lCZ1jfodQsPBWcGRxl81vz17/EVaT33zuJGCLfdf
        LMUMvYNiVlaQJuaSAYbLfBMKcp89Rwuor3puSTLPrcgGMeJ+zv89r7yRoOXR0PC3qhIiv6
        WXZEjKCnDZqZhThzB8scvkawF3zAA9A=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C862EAE20;
        Tue, 13 Apr 2021 12:24:37 +0000 (UTC)
Date:   Tue, 13 Apr 2021 14:24:36 +0200
From:   Ali Abdallah <ali.abdallah@suse.com>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH] conntrack_tcp: Reset the max ACK flag on SYN in ignore
 state
Message-ID: <20210413122436.aejo4pwaafwrlzsh@Fryzen495>
References: <20210408061203.35kbl44elgz4resh@Fryzen495>
 <20210408090459.GQ13699@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210408090459.GQ13699@breakpoint.cc>
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi,

Please find out the updated patch with the fixed comment.

PS: I'm just wondering if isn't better to just reset the MAXACK_SET on
both directions once an RST is observed on the tracked connection, what
do you think?

Thanks,
Ali

---

From e9d4d3a70a19d8a3868d16c93281119797fb54df Mon Sep 17 00:00:00 2001
From: Ali Abdallah <aabdallah@suse.de>
Date: Thu, 13 Apr 2021 14:18:02 +0200
Subject: [PATCH] Reset the max ACK flag on SYN in ignore state

In ignore state, we let SYN goes in original, the server might respond
with RST/ACK, and that RST packet is erroneously dropped because of the
flag IP_CT_TCP_FLAG_MAXACK_SET being already set.
---
 net/netfilter/nf_conntrack_proto_tcp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/netfilter/nf_conntrack_proto_tcp.c b/net/netfilter/nf_conntrack_proto_tcp.c
index ec23330687a5..891a66e35afd 100644
--- a/net/netfilter/nf_conntrack_proto_tcp.c
+++ b/net/netfilter/nf_conntrack_proto_tcp.c
@@ -963,6 +963,9 @@ int nf_conntrack_tcp_packet(struct nf_conn *ct,
 
             ct->proto.tcp.last_flags =
             ct->proto.tcp.last_wscale = 0;
+            /* Reset the max ack flag so in case the server replies
+             * with RST/ACK it will not be marked as an invalid rst */
+            ct->proto.tcp.seen[dir].flags &= ~IP_CT_TCP_FLAG_MAXACK_SET;
             tcp_options(skb, dataoff, th, &seen);
             if (seen.flags & IP_CT_TCP_FLAG_WINDOW_SCALE) {
                 ct->proto.tcp.last_flags |=
-- 
2.26.2

On 08.04.2021 11:04, Florian Westphal wrote:
> Ali Abdallah <ali.abdallah@suse.com> wrote:
> > In ignore state, we let SYN goes in original, the server might respond
> > with RST/ACK, and that RST packet is erroneously dropped because of the
> > flag IP_CT_TCP_FLAG_MAXACK_SET being already set.
> > ---
> >  net/netfilter/nf_conntrack_proto_tcp.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/net/netfilter/nf_conntrack_proto_tcp.c b/net/netfilter/nf_conntrack_proto_tcp.c
> > index ec23330687a5..891a66e35afd 100644
> > --- a/net/netfilter/nf_conntrack_proto_tcp.c
> > +++ b/net/netfilter/nf_conntrack_proto_tcp.c
> > @@ -963,6 +963,9 @@ int nf_conntrack_tcp_packet(struct nf_conn *ct,
> >  
> >  			ct->proto.tcp.last_flags =
> >  			ct->proto.tcp.last_wscale = 0;
> > +			/* Reset the max ack flag so in case the server replies
> > +			 * with RST/ACK it will be marked as an invalid rst */
> 
> "not be marked"?
> 
> > +			ct->proto.tcp.seen[dir].flags &= ~IP_CT_TCP_FLAG_MAXACK_SET;
> >  			tcp_options(skb, dataoff, th, &seen);
> >  			if (seen.flags & IP_CT_TCP_FLAG_WINDOW_SCALE) {
> 

-- 
Ali Abdallah | SUSE Linux L3 Engineer
GPG fingerprint: 51A0 F4A0 C8CF C98F 842E  A9A8 B945 56F8 1C85 D0D5

