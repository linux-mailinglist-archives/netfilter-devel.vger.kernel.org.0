Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB79B7DEE2E
	for <lists+netfilter-devel@lfdr.de>; Thu,  2 Nov 2023 09:30:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233226AbjKBIar (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 2 Nov 2023 04:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjKBIar (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 2 Nov 2023 04:30:47 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E3F128
        for <netfilter-devel@vger.kernel.org>; Thu,  2 Nov 2023 01:30:44 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1qyT6B-0006JP-01; Thu, 02 Nov 2023 09:30:43 +0100
Date:   Thu, 2 Nov 2023 09:30:42 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org,
        Lorenzo Bianconi <lorenzo@kernel.org>
Subject: Re: [PATCH RFC] netfilter: nf_tables: add flowtable map for xdp
 offload
Message-ID: <20231102083042.GB6174@breakpoint.cc>
References: <20231019202507.16439-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019202507.16439-1-fw@strlen.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Florian Westphal <fw@strlen.de> wrote:
> This adds a small internal mapping table so that a new bpf (xdp) kfunc
> A device cannot be added to multiple flowtables, the mapping needs
> to be unique.

This breaks two cases:
1.  Two-Phase commmit protocol:
nft -f - <<EOF
flush ruleset
table t {
	flowtable ...
EOF

fails when called a 2nd time.  This problem also exists
for at least the mlx hw offload too.

It would be good to fix this generically but I do not see
how given this problem is nftables specific and not really
flowtable related.

2. currently nftables supports
table ip t {
	flowtable f {
		devices = { eth0 ...

table ip6 t {
	flowtable f {
		devices = { eth0 ...

table inet t {
	flowtable f {
		devices = { eth0 ...

... and this works, i.e. same device can be part of
up to 6 flowtables.

This one is easier to fix, the program can guess ip/ip6
based to packet data and can a family to the kfunc as a
function argument.

inet would be shadowed / hidden when an ip/ip6 flowtable
mapping exists as well.

This is not nice, but the ip(6) and inet thing should
not occur in practice and nothing breaks here because
existing sw path is still going to work.

> +static int nf_flow_offload_xdp_setup(struct nf_flowtable *flowtable,
> +				     struct net_device *dev,
> +				     enum flow_block_command cmd)
> +{
> +	switch (cmd) {
> +	case FLOW_BLOCK_BIND:
> +		return nf_flowtable_by_dev_insert(flowtable, dev);

This is fine or at least can be made to work.

> +	case FLOW_BLOCK_UNBIND:
> +		nf_flowtable_by_dev_remove(dev);

This is broken.  UNBIND comes too late when things are torn down.

I only see two solutions:

1. add a new nf_flow_offload_unbind_prepare() that does this
2. Decouple nf_flowtable from nft_flowtable and make nf_flowtable
   refcounted.  As-is, the UNBIND will result in UAF because the
   underlying structures will be free'd immediately after this,
   without any synchronize_rcu().
