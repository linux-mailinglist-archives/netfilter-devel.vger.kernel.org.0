Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35CED18ACB2
	for <lists+netfilter-devel@lfdr.de>; Thu, 19 Mar 2020 07:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725747AbgCSGW0 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 19 Mar 2020 02:22:26 -0400
Received: from scp8.hosting.reg.ru ([31.31.196.44]:54722 "EHLO
        scp8.hosting.reg.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgCSGW0 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 19 Mar 2020 02:22:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=marinkevich.ru; s=default; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=UOP4N07w/7Dtfe6b9c2RhpbH/vchZ2TTDjtPe42q0B0=; b=i983TKP5elVgROsz9AdnFVXe7i
        YvFt4zDuFj02yR2yPNdo6zkTIRgJvbTHpWkoWduu3qas0sCQBASnxgw8QezLeAhf5gFeEhU0ajkFN
        yl9WXz5pDw2umctUSIHQURfeyEPx5e4pKR8EuRk69cglyqOlNjOhXcFCXvwTViArozTKDI0scT4Q3
        0qrLJ86C54+TS9EB52yJqi89+gfjJHybSOAjSq6nat1Q7mUQxmrI9aw/bKutWg14NwA0J0oGCDF2G
        zvleX5hQ6eJlF6fDDkqrdrZG9/8uIyD3gtzs2XF7i8Cay/de6scwXWLJLtmhoFUVBW0bweEnsrlxw
        S924Uc1Q==;
Received: from mail.eltex.org ([92.125.152.58]:54964 helo=[10.25.24.25])
        by scp8.hosting.reg.ru with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <s@marinkevich.ru>)
        id 1jEoZT-0005Z7-6P; Thu, 19 Mar 2020 09:22:23 +0300
To:     netfilter-devel@vger.kernel.org
Cc:     pablo@netfilter.org
From:   =?UTF-8?B?0KHQtdGA0LPQtdC5INCc0LDRgNC40L3QutC10LLQuNGH?= 
        <s@marinkevich.ru>
Subject: Re: [PATCH nft] evaluate: add range specified flag setting (missing
 NF_NAT_RANGE_PROTO_SPECIFIED)
Message-ID: <d40883ea-174f-9be7-0431-30f5d69ea4ad@marinkevich.ru>
Date:   Thu, 19 Mar 2020 13:22:22 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - scp8.hosting.reg.ru
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - marinkevich.ru
X-Get-Message-Sender-Via: scp8.hosting.reg.ru: authenticated_id: s@marinkevich.ru
X-Authenticated-Sender: scp8.hosting.reg.ru: s@marinkevich.ru
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

> Sergey reports:  > > With nf_tables it is not possible to use port range for 
masquerading. > Masquerade statement has option "to [:port-port]" which 
give no effect > to translation behavior. But it must change source port 
of packet to > one from ":port-port" range. > > My network: > > 
+-----------------------------+ > | ROUTER | > | | > | Masquerade| > | 
10.0.0.1 1.1.1.1 | > | +------+ +------+ | > | | eth1 | | eth2 | | > 
+-+--^---+-----------+---^--+-+ > | | > | | > +----v------+ 
+------v----+ > | | | | > | 10.0.0.2 | | 1.1.1.2 | > | | | | > |PC1 | 
|PC2 | > +-----------+ +-----------+ > > For testing i used rule like 
this: > > rule ip nat POSTROUTING oifname eth2 masquerade to :666 > > 
Run netcat for 1.1.1.2 667(UDP) and get dump from PC2: > > 
15:22:25.591567 a8:f9:4b:aa:08:44 > a8:f9:4b:ac:e7:8f, ethertype IPv4 
(0x0800), length 60: 1.1.1.1.34466 > 1.1.1.2.667: UDP, length 1 > > 
Address translation works fine, but source port are not belongs to > 
specified range. > > I see in similar source code (i.e. nft_redir.c, 
nft_nat.c) that > there is setting NF_NAT_RANGE_PROTO_SPECIFIED flag. 
After adding this, > repeat test for kernel with this patch, and get 
dump: > > 16:16:22.324710 a8:f9:4b:aa:08:44 > a8:f9:4b:ac:e7:8f, 
ethertype IPv4 (0x0800), length 60: 1.1.1.1.666 > 1.1.1.2.667: UDP, 
length 1 > > Now it is works fine. > > Reported-by: Sergey Marinkevich 
<s@marinkevich.ru> > Signed-off-by: Pablo Neira Ayuso 
<pablo@netfilter.org> > --- > Sergey, could you try this userspace patch 
instead? Thanks.
I tried this patch with equal environment but another
net(192.168.122.0/24). Router uses vanilla kernel v5.4.19.
Translation is the same.

     12:59:11.599887 08:00:27:ec:9c:b3 > 52:54:00:57:d2:7d, ethertype 
IPv4 (0x0800), length 60: 192.168.122.38.666 > 192.168.122.1.667: UDP, 
length 4

I think i have to add this tag:

Tested-by: Sergey Marinkevich <s@marinkevich.ru>

>  > src/evaluate.c | 3 +++ > 1 file changed, 3 insertions(+) > > diff 
--git a/src/evaluate.c b/src/evaluate.c > index 
4a23b231c74d..d0e712dc02f0 100644 > --- a/src/evaluate.c > +++ 
b/src/evaluate.c > @@ -18,6 +18,7 @@ > #include <linux/netfilter_arp.h> 
 > #include <linux/netfilter/nf_tables.h> > #include 
<linux/netfilter/nf_synproxy.h> > +#include <linux/netfilter/nf_nat.h> > 
#include <linux/netfilter_ipv4.h> > #include <netinet/ip_icmp.h> > 
#include <netinet/icmp6.h> > @@ -2950,6 +2951,8 @@ static int 
stmt_evaluate_nat(struct eval_ctx *ctx, struct stmt *stmt) > err = 
nat_evaluate_transport(ctx, stmt, &stmt->nat.proto); > if (err < 0) > 
return err; > + > + stmt->nat.flags |= NF_NAT_RANGE_PROTO_SPECIFIED; > } 
 > > stmt->flags |= STMT_F_TERMINAL; > -- > 2.11.0
