Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B947682D17
	for <lists+netfilter-devel@lfdr.de>; Tue, 31 Jan 2023 13:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbjAaM6w (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 31 Jan 2023 07:58:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbjAaM6u (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 31 Jan 2023 07:58:50 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7F38B4940C
        for <netfilter-devel@vger.kernel.org>; Tue, 31 Jan 2023 04:58:49 -0800 (PST)
Date:   Tue, 31 Jan 2023 13:58:46 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Roi Dayan <roid@nvidia.com>
Cc:     Florian Westphal <fw@strlen.de>,
        netfilter-devel <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH nf-next] netfilter: conntrack: udp: fix seen-reply test
Message-ID: <Y9kQhlJ8FtosZ8LG@salvia>
References: <20230123120433.98002-1-fw@strlen.de>
 <a6323260-da2e-1403-4764-423219b604a4@nvidia.com>
 <2a1a5bb8-a656-bce9-7a17-e7c949cab135@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2a1a5bb8-a656-bce9-7a17-e7c949cab135@nvidia.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Jan 31, 2023 at 02:37:21PM +0200, Roi Dayan wrote:
> 
> 
> On 23/01/2023 18:16, Roi Dayan wrote:
> > 
> > 
> > On 23/01/2023 14:04, Florian Westphal wrote:
> >> IPS_SEEN_REPLY_BIT is only useful for test_bit() api.
> >>
> >> Fixes: 4883ec512c17 ("netfilter: conntrack: avoid reload of ct->status")
> >> Reported-by: Roi Dayan <roid@nvidia.com>
> >> Signed-off-by: Florian Westphal <fw@strlen.de>
> >> ---
> >>  net/netfilter/nf_conntrack_proto_udp.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/net/netfilter/nf_conntrack_proto_udp.c b/net/netfilter/nf_conntrack_proto_udp.c
> >> index 6b9206635b24..0030fbe8885c 100644
> >> --- a/net/netfilter/nf_conntrack_proto_udp.c
> >> +++ b/net/netfilter/nf_conntrack_proto_udp.c
> >> @@ -104,7 +104,7 @@ int nf_conntrack_udp_packet(struct nf_conn *ct,
> >>  	/* If we've seen traffic both ways, this is some kind of UDP
> >>  	 * stream. Set Assured.
> >>  	 */
> >> -	if (status & IPS_SEEN_REPLY_BIT) {
> >> +	if (status & IPS_SEEN_REPLY) {
> >>  		unsigned long extra = timeouts[UDP_CT_UNREPLIED];
> >>  		bool stream = false;
> >>  
> > 
> > Reviewed-by: Roi Dayan <roid@nvidia.com>
> > 
> > thanks
> 
> hi, just pinging. when is this fix going to be merged?

I'll take care of this.

Thanks.
