Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E842C140E4
	for <lists+netfilter-devel@lfdr.de>; Sun,  5 May 2019 17:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfEEP6D convert rfc822-to-8bit (ORCPT
        <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 5 May 2019 11:58:03 -0400
Received: from Chamillionaire.breakpoint.cc ([146.0.238.67]:56562 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726524AbfEEP6D (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 5 May 2019 11:58:03 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1hNJWb-0006vL-Iz; Sun, 05 May 2019 17:58:01 +0200
Date:   Sun, 5 May 2019 17:58:01 +0200
From:   Florian Westphal <fw@strlen.de>
To:     =?iso-8859-15?Q?St=E9phane?= Veyret <sveyret@gmail.com>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH] netfilter: nft_ct: add ct expectations support
Message-ID: <20190505155801.pzwtzc3ksjmplszt@breakpoint.cc>
References: <20190505154016.3505-1-sveyret@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20190505154016.3505-1-sveyret@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

St�phane Veyret <sveyret@gmail.com> wrote:
> +static void nft_ct_expect_obj_eval(struct nft_object *obj,
> +				    struct nft_regs *regs,
> +				    const struct nft_pktinfo *pkt)
> +{
> +	const struct nft_ct_expect_obj *priv = nft_obj_data(obj);
> +	enum ip_conntrack_info ctinfo;
> +	struct nf_conn *ct = nf_ct_get(pkt->skb, ctinfo);
> +	int dir = CTINFO2DIR(ctinfo);
> +	struct nf_conntrack_expect *exp;
> +
> +	exp = nf_ct_expect_alloc(ct);
> +	if (exp == NULL) {
> +		nf_ct_helper_log(skb, ct, "cannot allocate expectation");
> +		regs->verdict.code = NF_DROP;
> +		return;
> +	}
> +
> +	nf_ct_expect_init(exp, NF_CT_EXPECT_CLASS_DEFAULT, priv->l3num,
> +		&ct->tuplehash[!dir].tuple.src.u3, &ct->tuplehash[!dir].tuple.dst.u3,
> +		priv->l4proto, NULL, &priv->dport);
> +	if (priv->timeout)
> +		exp->timeout.expires = jiffies + priv->timeout * HZ;
> +
> +	if (nf_ct_expect_related(exp) != 0) {
> +		nf_ct_helper_log(skb, ct, "cannot add expectation");

Please remove the nf_ct_helper_log() calls, it will crash in case there is no helper
attached to the conntrack.

Other than this I don't see any issues here, thanks for working on this!
