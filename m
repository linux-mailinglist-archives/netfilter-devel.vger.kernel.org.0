Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D25C1271DC
	for <lists+netfilter-devel@lfdr.de>; Fri, 20 Dec 2019 00:55:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbfLSXzX (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 19 Dec 2019 18:55:23 -0500
Received: from correo.us.es ([193.147.175.20]:58894 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726952AbfLSXzW (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 19 Dec 2019 18:55:22 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 174C2C39F4
        for <netfilter-devel@vger.kernel.org>; Fri, 20 Dec 2019 00:55:20 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 06A33DA70A
        for <netfilter-devel@vger.kernel.org>; Fri, 20 Dec 2019 00:55:20 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id F08C1DA703; Fri, 20 Dec 2019 00:55:19 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id B7AA9DA703;
        Fri, 20 Dec 2019 00:55:17 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Fri, 20 Dec 2019 00:55:17 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 9C1614265A5A;
        Fri, 20 Dec 2019 00:55:17 +0100 (CET)
Date:   Fri, 20 Dec 2019 00:55:17 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     wenxu@ucloud.cn
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf 2/3] netfilter: nf_tables: fix miss activate operation
 in the
Message-ID: <20191219235517.nbdbbdppfxanozba@salvia>
References: <1576681153-10578-1-git-send-email-wenxu@ucloud.cn>
 <1576681153-10578-3-git-send-email-wenxu@ucloud.cn>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="m3axtri5zvbk2td6"
Content-Disposition: inline
In-Reply-To: <1576681153-10578-3-git-send-email-wenxu@ucloud.cn>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org


--m3axtri5zvbk2td6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 18, 2019 at 10:59:12PM +0800, wenxu@ucloud.cn wrote:
> From: wenxu <wenxu@ucloud.cn>
> 
> nf_tables_commit for NFT_MSG_NEWRULE
> 
> The new create rule should be activated in the nf_tables_commit.
> 
> create a flowtable:
> nft add table firewall
> nft add flowtable firewall fb1 { hook ingress priority 2 \; devices = { tun1, mlx_pf0vf0 } \; }
> nft add chain firewall ftb-all {type filter hook forward priority 0 \; policy accept \; }
> nft add rule firewall ftb-all ct zone 1 ip protocol tcp flow offload @fb1
> nft add rule firewall ftb-all ct zone 1 ip protocol udp flow offload @fb1
> 
> delete the related rule:
> nft delete chain firewall ftb-all
> 
> The flowtable can be deleted
> nft delete flowtable firewall fb1
> 
> But failed with: Device is busy
> 
> The nf_flowtable->use is not zero for no activated operation.

This is correct.

> Signed-off-by: wenxu <wenxu@ucloud.cn>
> ---
>  net/netfilter/nf_tables_api.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
> index 27e6a6f..174b362 100644
> --- a/net/netfilter/nf_tables_api.c
> +++ b/net/netfilter/nf_tables_api.c
> @@ -7101,6 +7101,7 @@ static int nf_tables_commit(struct net *net, struct sk_buff *skb)
>  			nf_tables_rule_notify(&trans->ctx,
>  					      nft_trans_rule(trans),
>  					      NFT_MSG_NEWRULE);
> +			nft_rule_expr_activate(&trans->ctx, nft_trans_rule(trans));

I don't think this fix is correct, probably this patch?

--m3axtri5zvbk2td6
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="x.patch"

diff --git a/net/netfilter/nft_flow_offload.c b/net/netfilter/nft_flow_offload.c
index dd82ff2ee19f..f1280321b129 100644
--- a/net/netfilter/nft_flow_offload.c
+++ b/net/netfilter/nft_flow_offload.c
@@ -186,6 +186,9 @@ static void nft_flow_offload_deactivate(const struct nft_ctx *ctx,
 {
 	struct nft_flow_offload *priv = nft_expr_priv(expr);
 
+	if (phase == NFT_TRANS_COMMIT)
+		return;
+
 	nf_tables_deactivate_flowtable(ctx, priv->flowtable, phase);
 }
 

--m3axtri5zvbk2td6--
